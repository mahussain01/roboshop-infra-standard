module "web" {
  source               = "../../terraform-roboshop-app"
  project_name         = var.project_name
  env                  = var.env
  tags                 = var.tags
  health_check         = var.health_check
  target_group_port    = var.target_group_port
  vpc_id               = data.aws_ssm_parameter.vpc_id.value
  image_id             = data.aws_ami.devops_id.id
  security_group_id    = data.aws_ssm_parameter.web_sg_id.value
  user_data            = filebase64("${path.module}/web.sh")
  launch_template_tags = var.launch_template_tags
  vpc_zone_identifier  = split(",", data.aws_ssm_parameter.private_subnet_ids.value)
  tag                  = var.autoscaling_tags
  aws_lb_listener_arn  = data.aws_ssm_parameter.web_alb_listener_arn.value
  host_header          = "joindevops.online"
  rule_priority        = 10


}
