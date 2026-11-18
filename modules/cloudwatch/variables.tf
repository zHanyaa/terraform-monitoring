variable "name_prefix" {
  description = "Prefixo usado no nome dos recursos."
  type        = string
}

variable "aws_region" {
  description = "Região, usada nos widgets do dashboard."
  type        = string
}

variable "instance_id" {
  description = "ID da instância EC2 monitorada."
  type        = string
}

variable "sns_topic_arn" {
  description = "ARN do tópico SNS que recebe os alarmes."
  type        = string
}

variable "cpu_threshold" {
  description = "Percentual de CPU que dispara o alarme."
  type        = number
}

variable "memory_threshold" {
  description = "Percentual de memória que dispara o alarme."
  type        = number
}

variable "disk_threshold" {
  description = "Percentual de disco que dispara o alarme."
  type        = number
}
