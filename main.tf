locals {
  name_prefix = "${var.project_name}-${var.environment}"
}

module "ec2" {
  source = "./modules/ec2"

  name_prefix   = local.name_prefix
  instance_type = var.instance_type
}

module "sns" {
  source = "./modules/sns"

  name_prefix = local.name_prefix
  email       = var.notification_email
}

module "cloudwatch" {
  source = "./modules/cloudwatch"

  name_prefix      = local.name_prefix
  aws_region       = var.aws_region
  instance_id      = module.ec2.instance_id
  sns_topic_arn    = module.sns.topic_arn
  cpu_threshold    = var.cpu_threshold
  memory_threshold = var.memory_threshold
  disk_threshold   = var.disk_threshold
}
