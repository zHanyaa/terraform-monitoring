variable "aws_region" {
  description = "AWS region"
  default     = "us-east-1"
}

variable "instance_type" {
  description = "Tipo da instância EC2"
  default     = "t2.micro"
}

variable "tags" {
  description = "Tags para os recursos"
  type        = map(string)
  default     = {
    Environment = "dev"
    Project     = "Monitoramento"
  }
}

variable "notification_email" {
  description = "E-mail para receber notificações"
  type        = string
}
