# Terraform-aws-rds-mysql

Terraform module which creates MySQL RDS resources on AWS.

## Description

Provision [RDS DB Instance](https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/Overview.DBInstance.html),
[Option Group](https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/USER_WorkingWithOptionGroups.html) and
[Parameter Group](https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/USER_WorkingWithParamGroups.html).

This module provides recommended settings:

- Enable deletion protection
- Enable Multi-AZ
- Enable automated backups
- Sufficient backup retention period

## Usage
```hcl
module "rds" {
  source               = "./rds"
  name                 = var.name
  storage_size         = var.storage_size
  storage_type         = var.storage_type
  engine               = var.engine
  version_number       = var.version_number
  class                = var.class
  parameterGN          = var.parameterGN
  backup_window        = var.backup_window
  backup_retention     = var.backup_retention
  subnet1              = var.subnet1
  subnet2              = var.subnet2
  multi_az             = var.multi_az
  db_identifier        = var.db_identifier
  db_subnet_group_name = var.db_subnet_group_name
  port                 = var.port
  vpc_id               = var.vpc_id
  db_security_group    = var.db_security_group
  allowed_sg           = var.allowed_sg
}
```

## Requirements

| Name      | Version |
| --------- | ------- |
| terraform | >= 0.12 |

## Providers

| Name | Version |
| ---- | ------- |
| aws  | 2.70    |

## Inputs

| Name                                | Description                                                                                                           | Type           | Default                    | Required |
| ----------------------------------- | --------------------------------------------------------------------------------------------------------------------- | -------------- | -------------------------- | :------: |
| allocated_storage                   | The allocated storage in gibibytes.                                                                                   | `string`       | n/a                        |   yes    |
| engine_version                      | The engine version to use.                                                                                            | `string`       | n/a                        |   yes    |
| identifier                          | The name of the RDS instance.                                                                                         | `string`       | n/a                        |   yes    |
| instance_class                      | The instance type of the RDS instance.                                                                                | `string`       | n/a                        |   yes    |
| password                            | Password for the master DB user.                                                                                      | `string`       | n/a                        |   yes    |
| source_cidr_blocks                  | List of source CIDR blocks.                                                                                           | `list(string)` | n/a                        |   yes    |
| subnet_ids                          | A list of VPC subnet IDs.                                                                                             | `list(string)` | n/a                        |   yes    |
| username                            | Username for the master DB user.                                                                                      | `string`       | n/a                        |   yes    |
| vpc_id                              | VPC Id to associate with RDS MySQL.                                                                                   | `string`       | n/a                        |   yes    |
| backup_retention_period             | The days to retain backups for. Must be between 0 and 35.                                                             | `string`       | `"30"`                     |    no    |
| backup_window                       | The daily time range (in UTC) during which automated backups are created if they are enabled.                         | `string`       | `""`                       |    no    |
| multi_az                            | Specifies if the RDS instance is multi-AZ.                                                                            | `string`       | `true`                     |    no    |
| name                                | The name of the database to create when the DB instance is created.                                                   | `string`       | `""`                       |    no    |
| port                                | The port on which the DB accepts connections.                                                                         | `string`       | `3306`                     |    no    |

## Outputs

| Name                                | Description                                                                              |
| ----------------------------------- | ---------------------------------------------------------------------------------------- |
| db_instance_endpoint                | .The connection endpoint in address:port format.                                         |

## Issues I faced while was doing this project

Had struggled with the generation of RDS password and putting that in the secret manager of AWS. Found built-in solutions to solve the problem.

Had problems with security_group because it wasn't allowing me to specify the name of the different security_group. The reason was that we didn't have VPC-peering yet.

Had issues with the syntax of  Terraform when was writing module.
