variable "instance_type" {
  description = "Tipo da instância EC2"
  type        = string
  default     = "t3.micro"
}

variable "tags" {
  description = "Tags para a instância EC2"
  type        = map(string)
  default     = {}
} 