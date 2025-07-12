provider "aws" {
  region = var.aws_region
}

module "ec2" {
  source = "./Modules/ec2"
  instance_type = var.instance_type
  tags          = var.tags
}

module "sns" {
  source = "./Modules/sns"
  email  = var.notification_email
}

module "cloudwatch" {
  source        = "./Modules/cloudwatch"
  instance_id   = module.ec2.instance_id
  sns_topic_arn = module.sns.topic_arn
}
