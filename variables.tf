variable "aws_region" {
  description = "Região AWS."
  type        = string
  default     = "us-east-1"
}

variable "project_name" {
  description = "Nome do projeto, usado como prefixo nos recursos."
  type        = string
  default     = "monitoring"
}

variable "environment" {
  description = "Ambiente (dev, staging, prod)."
  type        = string
  default     = "dev"
}

variable "instance_type" {
  description = "Tipo da instância EC2."
  type        = string
  default     = "t3.micro"
}

variable "notification_email" {
  description = "E-mail que recebe os alarmes (é preciso confirmar a inscrição no e-mail da AWS)."
  type        = string
}

variable "cpu_threshold" {
  description = "Percentual de CPU que dispara o alarme."
  type        = number
  default     = 80
}

variable "memory_threshold" {
  description = "Percentual de memória usada que dispara o alarme."
  type        = number
  default     = 85
}

variable "disk_threshold" {
  description = "Percentual de disco usado (/) que dispara o alarme."
  type        = number
  default     = 85
}
