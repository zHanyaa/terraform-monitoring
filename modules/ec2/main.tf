resource "aws_instance" "this" {
  ami           = "ami-0c55b159cbfafe1f0" # Ajuste conforme necessário
  instance_type = var.instance_type
  tags          = var.tags
  iam_instance_profile = aws_iam_instance_profile.monitoring_profile.name
}

data "aws_iam_policy_document" "assume_role" {
  statement {
    actions = ["sts:AssumeRole"]
    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "monitoring" {
  name               = "ec2-monitoring-role"
  assume_role_policy = data.aws_iam_policy_document.assume_role.json
}

resource "aws_iam_role_policy_attachment" "cloudwatch" {
  role       = aws_iam_role.monitoring.name
  policy_arn = "arn:aws:iam::aws:policy/CloudWatchAgentServerPolicy"
}

resource "aws_iam_instance_profile" "monitoring_profile" {
  name = "ec2-monitoring-profile"
  role = aws_iam_role.monitoring.name
}


