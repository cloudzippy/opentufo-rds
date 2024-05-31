<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |

## Modules
# RDS Monitoring Module

This Terraform module sets up CloudWatch alarms for an RDS instance and sends notifications to an SNS topic. The following metrics are monitored:

- CPU Utilization
- Free Storage Space
- Freeable Memory
- Database Connections

## Usage

```hcl
module "rds_monitoring" {
  source                = "./rds-monitoring"
  region                = "us-west-2"
  db_instance_identifier = "mydb"
  sns_topic_arn         = "arn:aws:sns:us-west-2:123456789012:my-sns-topic"
  cloudwatch_log_group  = "rds-log-group"
}
No modules.

## Resources

| Name | Type |
|------|------|
| [aws_cloudwatch_log_group.rds_logs](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_log_group) | resource |
| [aws_cloudwatch_metric_alarm.cpu_utilization](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_metric_alarm) | resource |
| [aws_cloudwatch_metric_alarm.database_connections](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_metric_alarm) | resource |
| [aws_cloudwatch_metric_alarm.free_storage_space](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_metric_alarm) | resource |
| [aws_cloudwatch_metric_alarm.freeable_memory](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_metric_alarm) | resource |
| [aws_db_instance.primary](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/db_instance) | resource |
| [aws_db_instance.replica](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/db_instance) | resource |
| [aws_db_parameter_group.postgresql](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/db_parameter_group) | resource |
| [aws_iam_role.rds_monitoring](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy_attachment.rds_monitoring](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_security_group.rds](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_allocated_storage"></a> [allocated\_storage](#input\_allocated\_storage) | The allocated storage size in GB | `number` | n/a | yes |
| <a name="input_allowed_cidrs"></a> [allowed\_cidrs](#input\_allowed\_cidrs) | List of allowed CIDR blocks for ingress | `list(string)` | n/a | yes |
| <a name="input_create_replica"></a> [create\_replica](#input\_create\_replica) | Toggle to create read replicas. | `bool` | `false` | no |
| <a name="input_db_name"></a> [db\_name](#input\_db\_name) | The name of the database to create | `string` | n/a | yes |
| <a name="input_engine_version"></a> [engine\_version](#input\_engine\_version) | The version of the PostgreSQL engine | `string` | n/a | yes |
| <a name="input_instance_class"></a> [instance\_class](#input\_instance\_class) | The instance type of the RDS instance | `string` | n/a | yes |
| <a name="input_monitoring_interval"></a> [monitoring\_interval](#input\_monitoring\_interval) | The interval, in seconds, between points when Enhanced Monitoring metrics are collected | `number` | `60` | no |
| <a name="input_monitoring_role_arn"></a> [monitoring\_role\_arn](#input\_monitoring\_role\_arn) | The ARN for the IAM role that permits RDS to send enhanced monitoring metrics to CloudWatch Logs | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | The name of the RDS instance | `string` | n/a | yes |
| <a name="input_parameter_group_name"></a> [parameter\_group\_name](#input\_parameter\_group\_name) | Name of the RDS parameter group | `string` | n/a | yes |
| <a name="input_password"></a> [password](#input\_password) | The master password for the RDS instance | `string` | n/a | yes |
| <a name="input_region"></a> [region](#input\_region) | The AWS region to create resources in | `string` | `"us-west-2"` | no |
| <a name="input_replica_names"></a> [replica\_names](#input\_replica\_names) | List of replica names. | `list(string)` | `[]` | no |
| <a name="input_security_group_name"></a> [security\_group\_name](#input\_security\_group\_name) | Name of the security group | `string` | n/a | yes |
| <a name="input_username"></a> [username](#input\_username) | The master username for the RDS instance | `string` | n/a | yes |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | The VPC ID where the RDS instance will be created | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_cpu_utilization_alarm_arn"></a> [cpu\_utilization\_alarm\_arn](#output\_cpu\_utilization\_alarm\_arn) | n/a |
| <a name="output_database_connections_alarm_arn"></a> [database\_connections\_alarm\_arn](#output\_database\_connections\_alarm\_arn) | n/a |
| <a name="output_db_instance_id"></a> [db\_instance\_id](#output\_db\_instance\_id) | n/a |
| <a name="output_free_storage_space_alarm_arn"></a> [free\_storage\_space\_alarm\_arn](#output\_free\_storage\_space\_alarm\_arn) | n/a |
| <a name="output_freeable_memory_alarm_arn"></a> [freeable\_memory\_alarm\_arn](#output\_freeable\_memory\_alarm\_arn) | n/a |
| <a name="output_primary_endpoint"></a> [primary\_endpoint](#output\_primary\_endpoint) | The endpoint of the primary RDS instance |
| <a name="output_replica_endpoints"></a> [replica\_endpoints](#output\_replica\_endpoints) | The endpoints of the read replicas |
| <a name="output_security_group_id"></a> [security\_group\_id](#output\_security\_group\_id) | The ID of the security group |
<!-- END_TF_DOCS -->
