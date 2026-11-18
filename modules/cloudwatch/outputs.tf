output "alarm_names" {
  description = "Nomes dos alarmes criados."
  value = [
    aws_cloudwatch_metric_alarm.cpu.alarm_name,
    aws_cloudwatch_metric_alarm.status_check.alarm_name,
    aws_cloudwatch_metric_alarm.memory.alarm_name,
    aws_cloudwatch_metric_alarm.disk.alarm_name,
  ]
}

output "dashboard_url" {
  description = "Link do dashboard no console."
  value       = "https://${var.aws_region}.console.aws.amazon.com/cloudwatch/home?region=${var.aws_region}#dashboards:name=${aws_cloudwatch_dashboard.main.dashboard_name}"
}
