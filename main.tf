provider "aws" {
  region = var.region
}

resource "aws_db_parameter_group" "postgresql" {
  name   = var.parameter_group_name
  family = "postgres13"
  description = "Custom PostgreSQL RDS parameter group"

  parameter {
    name  = "max_connections"
    value = "200"
  }

  # Add more parameters as needed
}

resource "aws_security_group" "rds" {
  name        = var.security_group_name
  description = "RDS security group"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    cidr_blocks = var.allowed_cidrs
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_db_instance" "primary" {
  identifier              = "${var.name}-primary"
  instance_class          = var.instance_class
  allocated_storage       = var.allocated_storage
  engine                  = "postgres"
  engine_version          = var.engine_version
  username                = var.username
  password                = var.password
  db_name                 = var.db_name
  parameter_group_name    = aws_db_parameter_group.postgresql.name
  vpc_security_group_ids  = [aws_security_group.rds.id]
  monitoring_interval     = var.monitoring_interval
  monitoring_role_arn     = var.monitoring_role_arn
  lifecycle {
    create_before_destroy = true
  }
  # Other settings as needed
}

resource "aws_db_instance" "replica" {
  count                   = var.create_replica ? length(var.replica_names) : 0
  identifier              = element(var.replica_names, count.index)
  instance_class          = var.instance_class
  allocated_storage       = var.allocated_storage
  engine                  = "postgres"
  engine_version          = var.engine_version
  username                = var.username
  password                = var.password
  db_name                 = var.db_name
  parameter_group_name    = aws_db_parameter_group.postgresql.name
  vpc_security_group_ids  = [aws_security_group.rds.id]
  monitoring_interval     = var.monitoring_interval
  monitoring_role_arn     = var.monitoring_role_arn
  replicate_source_db     = aws_db_instance.primary.id
  lifecycle {
    create_before_destroy = true
  }
  # Other settings as needed
}

resource "aws_iam_role" "rds_monitoring" {
  name = "rds-monitoring-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = "sts:AssumeRole",
        Effect = "Allow",
        Principal = {
          Service = "monitoring.rds.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "rds_monitoring" {
  role       = aws_iam_role.rds_monitoring.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonRDSEnhancedMonitoringRole"
}


resource "aws_cloudwatch_log_group" "rds_logs" {
  name = var.cloudwatch_log_group
}

resource "aws_cloudwatch_metric_alarm" "cpu_utilization" {
  alarm_name          = "${var.db_instance_identifier}-cpu-utilization"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = "2"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/RDS"
  period              = "300"
  statistic           = "Average"
  threshold           = "80"
  alarm_description   = "This metric monitors RDS CPU utilization"
  alarm_actions       = [var.sns_topic_arn]

  dimensions = {
    DBInstanceIdentifier = aws_db_instance.default.id
  }
}

resource "aws_cloudwatch_metric_alarm" "free_storage_space" {
  alarm_name          = "${var.db_instance_identifier}-free-storage-space"
  comparison_operator = "LessThanThreshold"
  evaluation_periods  = "2"
  metric_name         = "FreeStorageSpace"
  namespace           = "AWS/RDS"
  period              = "300"
  statistic           = "Average"
  threshold           = "2000000000" # 2 GB
  alarm_description   = "This metric monitors RDS free storage space"
  alarm_actions       = [var.sns_topic_arn]

  dimensions = {
    DBInstanceIdentifier = aws_db_instance.default.id
  }
}

resource "aws_cloudwatch_metric_alarm" "freeable_memory" {
  alarm_name          = "${var.db_instance_identifier}-freeable-memory"
  comparison_operator = "LessThanThreshold"
  evaluation_periods  = "2"
  metric_name         = "FreeableMemory"
  namespace           = "AWS/RDS"
  period              = "300"
  statistic           = "Average"
  threshold           = "1000000000" # 1 GB
  alarm_description   = "This metric monitors RDS freeable memory"
  alarm_actions       = [var.sns_topic_arn]
  ok_actions          = [var.sns_topic_arn]

  dimensions = {
    DBInstanceIdentifier = var.db_instance_identifier
  }
}

resource "aws_cloudwatch_metric_alarm" "database_connections" {
  alarm_name          = "${var.db_instance_identifier}-database-connections"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = "2"
  metric_name         = "DatabaseConnections"
  namespace           = "AWS/RDS"
  period              = "300"
  statistic           = "Average"
  threshold           = "100"
  alarm_description   = "This metric monitors RDS database connections"
  alarm_actions       = [var.sns_topic_arn]
  ok_actions          = [var.sns_topic_arn]

  dimensions = {
    DBInstanceIdentifier = var.db_instance_identifier
  }
}
