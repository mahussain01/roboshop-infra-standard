# module "mongodb_sg" {
#   source         = "../../terraform-aws-securitygroup"
#   sg_name        = "mongodb"
#   sg_description = "Allowing traffic"
#   #sg_ingress_rules = var.sg_ingress_rules
#   vpc_id       = data.aws_ssm_parameter.vpc_id.value
#   project_name = var.project_name

# }
# resource "aws_security_group_rule" "mongodb" {
#   type      = "ingress"
#   from_port = 22
#   to_port   = 22
#   protocol  = "tcp"
#   #cidr_blocks              = ["${chomp(data.http.myip.response_body)}/32"]
#   source_security_group_id = data.aws_ssm_parameter.vpn_sg_id.value
#   #ipv6_cidr_blocks  = [aws_vpc.example.ipv6_cidr_block]
#   security_group_id = module.mongodb_sg.security_group_id
# }

module "rabbitmq_instance" {
  #   for_each               = var.instances
  source                 = "terraform-aws-modules/ec2-instance/aws"
  ami                    = data.aws_ami.devops_id.id
  instance_type          = "t3.medium"
  vpc_security_group_ids = [data.aws_ssm_parameter.rabbitmq_sg_id.value]
  subnet_id              = local.db_subnet_id
  user_data              = file("rabbitmq.sh")
  tags = merge(
    {
      Name = "rabbitmq-Dev"
    }
  )
}
module "hussain" {
  source    = "terraform-aws-modules/route53/aws//modules/records"
  zone_name = var.zone_name
  records = [
    {
      name = "rabbitmq"
      type = "A"
      ttl  = 1
      records = [
        module.rabbitmq_instance.private_ip
      ]
    }
  ]

}
