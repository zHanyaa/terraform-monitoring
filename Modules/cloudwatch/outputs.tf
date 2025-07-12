output "alarm_arn" {
  description = "ARN do alarme CloudWatch criado"
  value       = aws_cloudwatch_metric_alarm.cpu_utilization.arn
}

output "alarm_name" {
  description = "Nome do alarme CloudWatch"
  value       = aws_cloudwatch_metric_alarm.cpu_utilization.alarm_name
} 