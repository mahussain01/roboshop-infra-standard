# module "vpn_sg" {
#   source         = "../../terraform-aws-securitygroup"
#   sg_name        = "roboshop-vpn"
#   sg_description = "Allowing all ports from myhome IPs"
#   #sg_ingress_rules = var.sg_ingress_rules
#   vpc_id       = data.aws_vpc.default.id
#   project_name = var.project_name
# }
# resource "aws_security_group_rule" "vpn" {
#   type        = "ingress"
#   from_port   = 0
#   to_port     = 65535
#   protocol    = "tcp"
#   cidr_blocks = ["${chomp(data.http.myip.response_body)}/32"]
#   #ipv6_cidr_blocks  = [aws_vpc.example.ipv6_cidr_block]
#   security_group_id = module.vpn_sg.security_group_id
# }
module "vpn_instance" {
  #   for_each               = var.instances
  source                 = "terraform-aws-modules/ec2-instance/aws"
  ami                    = data.aws_ami.devops_id.id
  instance_type          = "t2.micro"
  vpc_security_group_ids = [data.aws_ssm_parameter.vpn_sg_id.value]
  #subnet_id              = each.key == "Web" ? local.public_subnet_ids[0] : local.private_subnet_ids[0]
  tags = merge(
    {
      Name = "Roboshop-Vpn"
    }
  )
}
