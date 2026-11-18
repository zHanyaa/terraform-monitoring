locals {
  actions = [var.sns_topic_arn]
}

resource "aws_cloudwatch_metric_alarm" "cpu" {
  alarm_name          = "${var.name_prefix}-cpu-high"
  alarm_description   = "CPU acima de ${var.cpu_threshold}% por 5 minutos"
  namespace           = "AWS/EC2"
  metric_name         = "CPUUtilization"
  statistic           = "Average"
  period              = 60
  evaluation_periods  = 5
  datapoints_to_alarm = 5
  threshold           = var.cpu_threshold
  comparison_operator = "GreaterThanThreshold"
  treat_missing_data  = "missing"
  alarm_actions       = local.actions
  ok_actions          = local.actions

  dimensions = {
    InstanceId = var.instance_id
  }
}

resource "aws_cloudwatch_metric_alarm" "status_check" {
  alarm_name          = "${var.name_prefix}-status-check-failed"
  alarm_description   = "Falha no status check da instância ou do host"
  namespace           = "AWS/EC2"
  metric_name         = "StatusCheckFailed"
  statistic           = "Maximum"
  period              = 60
  evaluation_periods  = 2
  threshold           = 0
  comparison_operator = "GreaterThanThreshold"
  treat_missing_data  = "breaching"
  alarm_actions       = local.actions
  ok_actions          = local.actions

  dimensions = {
    InstanceId = var.instance_id
  }
}

# Métricas abaixo vêm do CloudWatch Agent (namespace CWAgent).
resource "aws_cloudwatch_metric_alarm" "memory" {
  alarm_name          = "${var.name_prefix}-memory-high"
  alarm_description   = "Memória acima de ${var.memory_threshold}% por 5 minutos"
  namespace           = "CWAgent"
  metric_name         = "mem_used_percent"
  statistic           = "Average"
  period              = 60
  evaluation_periods  = 5
  threshold           = var.memory_threshold
  comparison_operator = "GreaterThanThreshold"
  treat_missing_data  = "missing"
  alarm_actions       = local.actions
  ok_actions          = local.actions

  dimensions = {
    InstanceId = var.instance_id
  }
}

resource "aws_cloudwatch_metric_alarm" "disk" {
  alarm_name          = "${var.name_prefix}-disk-high"
  alarm_description   = "Disco (/) acima de ${var.disk_threshold}%"
  namespace           = "CWAgent"
  metric_name         = "disk_used_percent"
  statistic           = "Maximum"
  period              = 300
  evaluation_periods  = 1
  threshold           = var.disk_threshold
  comparison_operator = "GreaterThanThreshold"
  treat_missing_data  = "missing"
  alarm_actions       = local.actions
  ok_actions          = local.actions

  # Amazon Linux 2023 usa xfs na raiz; drop_device no agente remove a dimensão device.
  dimensions = {
    InstanceId = var.instance_id
    path       = "/"
    fstype     = "xfs"
  }
}

resource "aws_cloudwatch_dashboard" "main" {
  dashboard_name = "${var.name_prefix}-ec2"

  dashboard_body = jsonencode({
    widgets = [
      {
        type   = "metric"
        x      = 0
        y      = 0
        width  = 12
        height = 6
        properties = {
          title       = "CPU (%)"
          region      = var.aws_region
          view        = "timeSeries"
          metrics     = [["AWS/EC2", "CPUUtilization", "InstanceId", var.instance_id]]
          annotations = { horizontal = [{ label = "alarme", value = var.cpu_threshold }] }
        }
      },
      {
        type   = "metric"
        x      = 12
        y      = 0
        width  = 12
        height = 6
        properties = {
          title       = "Memória (%)"
          region      = var.aws_region
          view        = "timeSeries"
          metrics     = [["CWAgent", "mem_used_percent", "InstanceId", var.instance_id]]
          annotations = { horizontal = [{ label = "alarme", value = var.memory_threshold }] }
        }
      },
      {
        type   = "metric"
        x      = 0
        y      = 6
        width  = 12
        height = 6
        properties = {
          title       = "Disco / (%)"
          region      = var.aws_region
          view        = "timeSeries"
          metrics     = [["CWAgent", "disk_used_percent", "InstanceId", var.instance_id, "path", "/", "fstype", "xfs"]]
          annotations = { horizontal = [{ label = "alarme", value = var.disk_threshold }] }
        }
      },
      {
        type   = "alarm"
        x      = 12
        y      = 6
        width  = 12
        height = 6
        properties = {
          title = "Alarmes"
          alarms = [
            aws_cloudwatch_metric_alarm.cpu.arn,
            aws_cloudwatch_metric_alarm.status_check.arn,
            aws_cloudwatch_metric_alarm.memory.arn,
            aws_cloudwatch_metric_alarm.disk.arn,
          ]
        }
      },
    ]
  })
}
