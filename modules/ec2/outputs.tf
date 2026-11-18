output "instance_id" {
  description = "ID da instância EC2 criada."
  value       = aws_instance.this.id
}

output "instance_arn" {
  description = "ARN da instância EC2."
  value       = aws_instance.this.arn
}

output "public_ip" {
  description = "IP público da instância EC2."
  value       = aws_instance.this.public_ip
}
