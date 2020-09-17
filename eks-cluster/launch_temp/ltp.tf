data "template_file" "user_data" {
  template = <<EOF
#!/bin/bash
set -o xtrace
/etc/eks/bootstrap.sh eks-exchange
EOF
}

resource "aws_launch_template" "eks_tmp" {
  name          = "${var.name}-lt"
  image_id      = var.image_id
  instance_type = var.instance_type


  iam_instance_profile {
    name = "terraform-eks-node-exchange"
  }

  network_interfaces {
    security_groups = var.sg_id
    subnet_id       = var.subnet_id[0]
  }
  tags = {
    Name = "${var.name}-lt"
  }
  user_data = "${base64encode(data.template_file.user_data.rendered)}"
}

resource "aws_autoscaling_group" "eks_cluster-asg" {
  # availability_zones  = var.avz
  health_check_type   = var.health_check_type
  desired_capacity    = var.desired_capacity
  max_size            = var.max_size
  min_size            = var.min_size
  vpc_zone_identifier = var.subnet_id

  mixed_instances_policy {
    launch_template {
      launch_template_specification {
        launch_template_id = aws_launch_template.eks_tmp.id
      }

      override {
        instance_type = var.instance_type2
      }

      override {
        instance_type = var.instance_type
      }
    }

    instances_distribution {
      on_demand_base_capacity                  = var.on_demand_base_capacity
      on_demand_percentage_above_base_capacity = var.on_demand_percentage_above_base_capacity
      spot_allocation_strategy                 = var.spot_allocation_strategy
      spot_instance_pools                      = var.spot_instance_pools
      spot_max_price                           = var.spot_max_price
    }
  }
  tag {
    key                 = "kubernetes.io/cluster/eks-exchange"
    value               = "owned"
    propagate_at_launch = true
  }

  tag {
    key                 = "Name"
    value               = "${var.name}-asg"
    propagate_at_launch = true
  }

  lifecycle {
    create_before_destroy = true
  }
}

# Setup IAM role & instance profile for worker nodes

resource "aws_iam_role" "tf-eks-node-exchange" {
  name = "terraform-eks-tf-eks-node"

  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
POLICY
}

resource "aws_iam_role_policy_attachment" "tf-eks-node-AmazonEKSWorkerNodePolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  role       = aws_iam_role.tf-eks-node-exchange.name
}

resource "aws_iam_role_policy_attachment" "tf-eks-node-AmazonEKS_CNI_Policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role       = aws_iam_role.tf-eks-node-exchange.name
}

resource "aws_iam_role_policy_attachment" "tf-eks-node-AmazonEC2ContainerRegistryReadOnly" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role       = aws_iam_role.tf-eks-node-exchange.name
}

resource "aws_iam_instance_profile" "node" {
  name = "terraform-eks-node-exchange"
  role = aws_iam_role.tf-eks-node-exchange.name
}
