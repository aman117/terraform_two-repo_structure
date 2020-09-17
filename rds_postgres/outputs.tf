  
output "rds_endpoint" {
  description = "the endpoint of the rds"
  value       = module.rds-postgres-instance.rds_endpoint
}

output "rds_name" {
  description = "the name of the rds"
  value       = module.rds-postgres-instance.rds_name
}