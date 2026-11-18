variable "instance_id" {
  description = "ID da instância EC2 para monitorar"
  type        = string
}

variable "sns_topic_arn" {
  description = "ARN do tópico SNS para enviar alarmes"
  type        = string
} 