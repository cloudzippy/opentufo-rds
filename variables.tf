variable "region" {
  description = "The AWS region to create resources in"
  type        = string
  default     = "us-west-2"
}

variable "parameter_group_name" {
  description = "Name of the RDS parameter group"
  type        = string
}

variable "security_group_name" {
  description = "Name of the security group"
  type        = string
}

variable "vpc_id" {
  description = "The VPC ID where the RDS instance will be created"
  type        = string
}

variable "allowed_cidrs" {
  description = "List of allowed CIDR blocks for ingress"
  type        = list(string)
}

variable "name" {
  description = "The name of the RDS instance"
  type        = string
}

variable "instance_class" {
  description = "The instance type of the RDS instance"
  type        = string
}

variable "allocated_storage" {
  description = "The allocated storage size in GB"
  type        = number
}

variable "engine_version" {
  description = "The version of the PostgreSQL engine"
  type        = string
}

variable "username" {
  description = "The master username for the RDS instance"
  type        = string
}

variable "password" {
  description = "The master password for the RDS instance"
  type        = string
}

variable "db_name" {
  description = "The name of the database to create"
  type        = string
}

variable "monitoring_interval" {
  description = "The interval, in seconds, between points when Enhanced Monitoring metrics are collected"
  type        = number
  default     = 60
}

variable "monitoring_role_arn" {
  description = "The ARN for the IAM role that permits RDS to send enhanced monitoring metrics to CloudWatch Logs"
  type        = string
}

variable "create_replica" {
  description = "Toggle to create read replicas."
  type        = bool
  default     = false
}

variable "replica_names" {
  description = "List of replica names."
  type        = list(string)
  default     = []
}
