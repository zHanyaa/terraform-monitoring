output "instance_id" {
  description = "ID da instância monitorada."
  value       = module.ec2.instance_id
}

output "topic_arn" {
  description = "ARN do tópico SNS dos alarmes."
  value       = module.sns.topic_arn
}

output "alarm_names" {
  description = "Nomes dos alarmes criados."
  value       = module.cloudwatch.alarm_names
}

output "dashboard_url" {
  description = "Link do dashboard no console do CloudWatch."
  value       = module.cloudwatch.dashboard_url
}

output "ssm_session_command" {
  description = "Comando para abrir terminal na instância via SSM."
  value       = "aws ssm start-session --target ${module.ec2.instance_id} --region ${var.aws_region}"
}
