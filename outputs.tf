output "primary_endpoint" {
  description = "The endpoint of the primary RDS instance"
  value       = aws_db_instance.primary.endpoint
}

output "replica_endpoints" {
  description = "The endpoints of the read replicas"
  value       = [for replica in aws_db_instance.replica : replica.endpoint]
}

output "security_group_id" {
  description = "The ID of the security group"
  value       = aws_security_group.rds.id
}

output "db_instance_id" {
  value = aws_db_instance.primary.id
}

output "cpu_utilization_alarm_arn" {
  value = aws_cloudwatch_metric_alarm.cpu_utilization.arn
}

output "free_storage_space_alarm_arn" {
  value = aws_cloudwatch_metric_alarm.free_storage_space.arn
}

output "freeable_memory_alarm_arn" {
  value = aws_cloudwatch_metric_alarm.freeable_memory.arn
}

output "database_connections_alarm_arn" {
  value = aws_cloudwatch_metric_alarm.database_connections.arn
}
