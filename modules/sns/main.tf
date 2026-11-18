# Sem SSE com a chave gerenciada alias/aws/sns: o CloudWatch não consegue
# publicar em tópicos criptografados com ela (exigiria uma chave KMS própria).
resource "aws_sns_topic" "alarms" {
  name = "${var.name_prefix}-alarms"
}

resource "aws_sns_topic_subscription" "email" {
  topic_arn = aws_sns_topic.alarms.arn
  protocol  = "email"
  endpoint  = var.email
}
