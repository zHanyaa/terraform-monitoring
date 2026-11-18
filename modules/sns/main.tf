resource "aws_sns_topic" "alarms" {
  name = "ec2-alarms-topic"
}

resource "aws_sns_topic_subscription" "email" {
  topic_arn = aws_sns_topic.alarms.arn
  protocol  = "email"
  endpoint  = var.email
}


