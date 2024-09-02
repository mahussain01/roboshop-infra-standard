module "mongodb_sg" {
  source         = "../../terraform-aws-securitygroup"
  sg_name        = "mongodb"
  sg_description = "Allowing traffic from Catalogue,Mongodb and VPN"
  #sg_ingress_rules = var.sg_ingress_rules
  vpc_id       = data.aws_ssm_parameter.vpc_id.value
  project_name = var.project_name
  tags = merge(
    var.tags,
    {
      Component = "Mongodb"
    }
  )
}
module "catalogue_sg" {
  source         = "../../terraform-aws-securitygroup"
  sg_name        = "catalogue"
  sg_description = "Allowing traffic from Catalogue,Mongodb and VPN"
  #sg_ingress_rules = var.sg_ingress_rules
  vpc_id       = data.aws_ssm_parameter.vpc_id.value
  project_name = var.project_name
  tags = merge(
    var.tags,
    {
      Component = "Catalogue"
    }
  )
}
module "vpn_sg" {
  source         = "../../terraform-aws-securitygroup"
  sg_name        = "roboshop-vpn"
  sg_description = "Allowing all ports from myhome IPs"
  #sg_ingress_rules = var.sg_ingress_rules
  vpc_id       = data.aws_vpc.default.id
  project_name = var.project_name
  tags = merge(
    var.tags,
    {
      Component = "Vpn"
      Name      = "Roboshop-vpn"
    }
  )

}
module "web_sg" {
  source         = "../../terraform-aws-securitygroup"
  sg_name        = "web"
  sg_description = "Allowing traffic from Web"
  #sg_ingress_rules = var.sg_ingress_rules
  vpc_id       = data.aws_ssm_parameter.vpc_id.value
  project_name = var.project_name
  tags = merge(
    var.tags,
    {
      Name = "Web"
    }
  )
}
module "app_alb_sg" {
  source         = "../../terraform-aws-securitygroup"
  sg_name        = "app_alb"
  sg_description = "Allowing traffic "
  #sg_ingress_rules = var.sg_ingress_rules
  vpc_id       = data.aws_ssm_parameter.vpc_id.value
  project_name = var.project_name
  tags = merge(
    var.tags,
    {
      Component = "app-alb"
      Name      = "App_alb"
    }
  )
}
module "web_alb_sg" {
  source         = "../../terraform-aws-securitygroup"
  sg_name        = "web_alb"
  sg_description = "Allowing traffic from Catalogue,Mongodb and VPN"
  #sg_ingress_rules = var.sg_ingress_rules
  vpc_id       = data.aws_ssm_parameter.vpc_id.value
  project_name = var.project_name
  tags = merge(
    var.tags,
    {
      Component = "Web_alb"
      Name      = "web_alb"
    }
  )
}
module "redis_sg" {
  source         = "../../terraform-aws-securitygroup"
  sg_name        = "redis_sg"
  sg_description = "Allowing traffic from Catalogue,User and VPN"
  #sg_ingress_rules = var.sg_ingress_rules
  vpc_id       = data.aws_ssm_parameter.vpc_id.value
  project_name = var.project_name
  tags = merge(
    var.tags,
    {
      Component = "redis"
      Name      = "redis"
    }
  )
}
module "user_sg" {
  source         = "../../terraform-aws-securitygroup"
  sg_name        = "user_sg"
  sg_description = "Allowing traffic from App_alb and VPN"
  #sg_ingress_rules = var.sg_ingress_rules
  vpc_id       = data.aws_ssm_parameter.vpc_id.value
  project_name = var.project_name
  tags = merge(
    var.tags,
    {
      Component = "user"
      Name      = "user"
    }
  )
}
module "cart_sg" {
  source         = "../../terraform-aws-securitygroup"
  sg_name        = "cart_sg"
  sg_description = "Allowing traffic from App_alb and VPN"
  #sg_ingress_rules = var.sg_ingress_rules
  vpc_id       = data.aws_ssm_parameter.vpc_id.value
  project_name = var.project_name
  tags = merge(
    var.tags,
    {
      Component = "cart"
      Name      = "cart"
    }
  )
}
module "mysql_sg" {
  source         = "../../terraform-aws-securitygroup"
  sg_name        = "mysql_sg"
  sg_description = "Allowing traffic from App_alb and VPN"
  #sg_ingress_rules = var.sg_ingress_rules
  vpc_id       = data.aws_ssm_parameter.vpc_id.value
  project_name = var.project_name
  tags = merge(
    var.tags,
    {
      Component = "mysql"
      Name      = "mysql"
    }
  )
}
module "shipping_sg" {
  source         = "../../terraform-aws-securitygroup"
  sg_name        = "shipping_sg"
  sg_description = "Allowing traffic from App_alb and VPN"
  #sg_ingress_rules = var.sg_ingress_rules
  vpc_id       = data.aws_ssm_parameter.vpc_id.value
  project_name = var.project_name
  tags = merge(
    var.tags,
    {
      Component = "shipping"
      Name      = "shipping"
    }
  )
}
module "rabbitmq_sg" {
  source         = "../../terraform-aws-securitygroup"
  sg_name        = "rabbitmq_sg"
  sg_description = "Allowing traffic from App_alb and VPN"
  #sg_ingress_rules = var.sg_ingress_rules
  vpc_id       = data.aws_ssm_parameter.vpc_id.value
  project_name = var.project_name
  tags = merge(
    var.tags,
    {
      Component = "rabbitmq"
      Name      = "rabbitmq"
    }
  )
}
module "payment_sg" {
  source         = "../../terraform-aws-securitygroup"
  sg_name        = "payment_sg"
  sg_description = "Allowing traffic from App_alb and VPN"
  #sg_ingress_rules = var.sg_ingress_rules
  vpc_id       = data.aws_ssm_parameter.vpc_id.value
  project_name = var.project_name
  tags = merge(
    var.tags,
    {
      Component = "payment"
      Name      = "payment"
    }
  )
}
resource "aws_security_group_rule" "vpn" {
  type        = "ingress"
  from_port   = 0
  to_port     = 65535
  protocol    = "tcp"
  cidr_blocks = ["${chomp(data.http.myip.response_body)}/32"]
  #ipv6_cidr_blocks  = [aws_vpc.example.ipv6_cidr_block]
  security_group_id = module.vpn_sg.security_group_id
}
resource "aws_security_group_rule" "mongodb_catalogue" {
  type        = "ingress"
  description = "allowing 27017 port number from catalogue"
  from_port   = 27017
  to_port     = 27017
  protocol    = "tcp"
  #cidr_blocks              = ["${chomp(data.http.myip.response_body)}/32"]
  source_security_group_id = module.catalogue_sg.security_group_id
  #ipv6_cidr_blocks  = [aws_vpc.example.ipv6_cidr_block]
  security_group_id = module.mongodb_sg.security_group_id
}
resource "aws_security_group_rule" "mongodb_vpn" {
  type        = "ingress"
  description = "allowing 22 port number from vpn"
  from_port   = 22
  to_port     = 22
  protocol    = "tcp"
  #cidr_blocks              = ["${chomp(data.http.myip.response_body)}/32"]
  source_security_group_id = module.vpn_sg.security_group_id
  #ipv6_cidr_blocks  = [aws_vpc.example.ipv6_cidr_block]
  security_group_id = module.mongodb_sg.security_group_id
}

resource "aws_security_group_rule" "catalogue_vpn" {
  type        = "ingress"
  description = "allowing 22 port number from vpn"
  from_port   = 22
  to_port     = 22
  protocol    = "tcp"
  #cidr_blocks              = ["${chomp(data.http.myip.response_body)}/32"]
  source_security_group_id = module.vpn_sg.security_group_id
  #ipv6_cidr_blocks  = [aws_vpc.example.ipv6_cidr_block]
  security_group_id = module.catalogue_sg.security_group_id
}
resource "aws_security_group_rule" "catalogue_app_alb" {
  type        = "ingress"
  description = "allowing 8080 port number from vpn"
  from_port   = 8080
  to_port     = 8080
  protocol    = "tcp"
  #cidr_blocks              = ["${chomp(data.http.myip.response_body)}/32"]
  source_security_group_id = module.app_alb_sg.security_group_id
  #ipv6_cidr_blocks  = [aws_vpc.example.ipv6_cidr_block]
  security_group_id = module.catalogue_sg.security_group_id
}
resource "aws_security_group_rule" "app_alb_vpn" {
  type        = "ingress"
  description = "allowing 80 port number from vpn"
  from_port   = 80
  to_port     = 80
  protocol    = "tcp"
  #cidr_blocks              = ["${chomp(data.http.myip.response_body)}/32"]
  source_security_group_id = module.vpn_sg.security_group_id
  #ipv6_cidr_blocks  = [aws_vpc.example.ipv6_cidr_block]
  security_group_id = module.app_alb_sg.security_group_id
}
resource "aws_security_group_rule" "app_alb_web" {
  type        = "ingress"
  description = "allowing 80 port number from vpn"
  from_port   = 80
  to_port     = 80
  protocol    = "tcp"
  #cidr_blocks              = ["${chomp(data.http.myip.response_body)}/32"]
  source_security_group_id = module.web_sg.security_group_id
  #ipv6_cidr_blocks  = [aws_vpc.example.ipv6_cidr_block]
  security_group_id = module.app_alb_sg.security_group_id
}
resource "aws_security_group_rule" "web_vpn" {
  type        = "ingress"
  description = "allowing 80 port number from vpn"
  from_port   = 80
  to_port     = 80
  protocol    = "tcp"
  #cidr_blocks              = ["${chomp(data.http.myip.response_body)}/32"]
  source_security_group_id = module.vpn_sg.security_group_id
  #ipv6_cidr_blocks  = [aws_vpc.example.ipv6_cidr_block]
  security_group_id = module.web_sg.security_group_id
}
resource "aws_security_group_rule" "web_vpn_ssh" {
  type        = "ingress"
  description = "allowing 22 port number from vpn"
  from_port   = 6
  to_port     = 22
  protocol    = "tcp"
  #cidr_blocks              = ["${chomp(data.http.myip.response_body)}/32"]
  source_security_group_id = module.vpn_sg.security_group_id
  #ipv6_cidr_blocks  = [aws_vpc.example.ipv6_cidr_block]
  security_group_id = module.web_sg.security_group_id
}
resource "aws_security_group_rule" "web_web_alb" {
  type        = "ingress"
  description = "allowing 22 port number from vpn"
  from_port   = 80
  to_port     = 80
  protocol    = "tcp"
  #cidr_blocks              = ["${chomp(data.http.myip.response_body)}/32"]
  source_security_group_id = module.web_alb_sg.security_group_id
  #ipv6_cidr_blocks  = [aws_vpc.example.ipv6_cidr_block]
  security_group_id = module.web_sg.security_group_id
}
resource "aws_security_group_rule" "web_alb_internet" {
  type        = "ingress"
  description = "allowing 22 port number from vpn"
  from_port   = 80
  to_port     = 80
  protocol    = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
  #cidr_blocks              = ["${chomp(data.http.myip.response_body)}/32"]
  #source_security_group_id = module.web_alb_sg.security_group_id
  #ipv6_cidr_blocks  = [aws_vpc.example.ipv6_cidr_block]
  security_group_id = module.web_alb_sg.security_group_id
}
resource "aws_security_group_rule" "web_alb_internet_https" {
  type        = "ingress"
  description = "allowing 22 port number from vpn"
  from_port   = 443
  to_port     = 443
  protocol    = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
  #cidr_blocks              = ["${chomp(data.http.myip.response_body)}/32"]
  #source_security_group_id = module.web_alb_sg.security_group_id
  #ipv6_cidr_blocks  = [aws_vpc.example.ipv6_cidr_block]
  security_group_id = module.web_alb_sg.security_group_id
}
resource "aws_security_group_rule" "redis_user" {
  type        = "ingress"
  description = "allowing 6379 port number from user"
  from_port   = 6379
  to_port     = 6379
  protocol    = "tcp"
  #cidr_blocks = ["0.0.0.0/0"]
  #cidr_blocks              = ["${chomp(data.http.myip.response_body)}/32"]
  source_security_group_id = module.user_sg.security_group_id
  #ipv6_cidr_blocks  = [aws_vpc.example.ipv6_cidr_block]
  security_group_id = module.redis_sg.security_group_id
}
resource "aws_security_group_rule" "redis_catalogue" {
  type        = "ingress"
  description = "allowing 6379 port number from user"
  from_port   = 6379
  to_port     = 6379
  protocol    = "tcp"
  #cidr_blocks = ["0.0.0.0/0"]
  #cidr_blocks              = ["${chomp(data.http.myip.response_body)}/32"]
  source_security_group_id = module.catalogue_sg.security_group_id
  #ipv6_cidr_blocks  = [aws_vpc.example.ipv6_cidr_block]
  security_group_id = module.redis_sg.security_group_id
}
resource "aws_security_group_rule" "redis_vpn" {
  type        = "ingress"
  description = "allowing 22 port number from vpn"
  from_port   = 22
  to_port     = 22
  protocol    = "tcp"
  #cidr_blocks = ["0.0.0.0/0"]
  #cidr_blocks              = ["${chomp(data.http.myip.response_body)}/32"]
  source_security_group_id = module.vpn_sg.security_group_id
  #ipv6_cidr_blocks  = [aws_vpc.example.ipv6_cidr_block]
  security_group_id = module.redis_sg.security_group_id
}

resource "aws_security_group_rule" "user_app_alb" {
  type        = "ingress"
  description = "allowing 80808 port number from app_alb"
  from_port   = 8080
  to_port     = 8080
  protocol    = "tcp"
  #cidr_blocks = ["0.0.0.0/0"]
  #cidr_blocks              = ["${chomp(data.http.myip.response_body)}/32"]
  source_security_group_id = module.app_alb_sg.security_group_id
  #ipv6_cidr_blocks  = [aws_vpc.example.ipv6_cidr_block]
  security_group_id = module.user_sg.security_group_id
}
resource "aws_security_group_rule" "user_vpn" {
  type        = "ingress"
  description = "allowing 22 port number from app_alb"
  from_port   = 22
  to_port     = 22
  protocol    = "tcp"
  #cidr_blocks = ["0.0.0.0/0"]
  #cidr_blocks              = ["${chomp(data.http.myip.response_body)}/32"]
  source_security_group_id = module.vpn_sg.security_group_id
  #ipv6_cidr_blocks  = [aws_vpc.example.ipv6_cidr_block]
  security_group_id = module.user_sg.security_group_id
}
resource "aws_security_group_rule" "cart_app_alb" {
  type        = "ingress"
  description = "allowing 8080 port number from app_alb"
  from_port   = 8080
  to_port     = 8080
  protocol    = "tcp"
  #cidr_blocks              = ["${chomp(data.http.myip.response_body)}/32"]
  source_security_group_id = module.app_alb_sg.security_group_id
  #ipv6_cidr_blocks  = [aws_vpc.example.ipv6_cidr_block]
  security_group_id = module.cart_sg.security_group_id
}

resource "aws_security_group_rule" "cart_vpn" {
  type        = "ingress"
  description = "allowing 22 port number from vpn"
  from_port   = 22
  to_port     = 22
  protocol    = "tcp"
  #cidr_blocks              = ["${chomp(data.http.myip.response_body)}/32"]
  source_security_group_id = module.vpn_sg.security_group_id
  #ipv6_cidr_blocks  = [aws_vpc.example.ipv6_cidr_block]
  security_group_id = module.cart_sg.security_group_id
}
resource "aws_security_group_rule" "redis_cart" {
  type        = "ingress"
  description = "allowing 6379 port number from cart"
  from_port   = 6379
  to_port     = 6379
  protocol    = "tcp"
  #cidr_blocks              = ["${chomp(data.http.myip.response_body)}/32"]
  source_security_group_id = module.cart_sg.security_group_id
  #ipv6_cidr_blocks  = [aws_vpc.example.ipv6_cidr_block]
  security_group_id = module.redis_sg.security_group_id
}
resource "aws_security_group_rule" "mysql_shipping" {
  type        = "ingress"
  description = "allowing 3306 port number from vpn"
  from_port   = 3306
  to_port     = 3306
  protocol    = "tcp"
  #cidr_blocks              = ["${chomp(data.http.myip.response_body)}/32"]
  source_security_group_id = module.mysql_sg.security_group_id
  #ipv6_cidr_blocks  = [aws_vpc.example.ipv6_cidr_block]
  security_group_id = module.shipping_sg.security_group_id
}
resource "aws_security_group_rule" "shipping_app_alb" {
  type        = "ingress"
  description = "allowing 8080 port number from app_alb"
  from_port   = 8080
  to_port     = 8080
  protocol    = "tcp"
  #cidr_blocks              = ["${chomp(data.http.myip.response_body)}/32"]
  source_security_group_id = module.app_alb_sg.security_group_id
  #ipv6_cidr_blocks  = [aws_vpc.example.ipv6_cidr_block]
  security_group_id = module.shipping_sg.security_group_id
}
resource "aws_security_group_rule" "payment_rabbitmq" {
  type        = "ingress"
  description = "allowing 5672 port number from payemt"
  from_port   = 5672
  to_port     = 5672
  protocol    = "tcp"
  #cidr_blocks              = ["${chomp(data.http.myip.response_body)}/32"]
  source_security_group_id = module.payment_sg.security_group_id
  #ipv6_cidr_blocks  = [aws_vpc.example.ipv6_cidr_block]
  security_group_id = module.rabbitmq_sg.security_group_id
}
resource "aws_security_group_rule" "payment_app_alb" {
  type        = "ingress"
  description = "allowing 8080 port number from app_alb"
  from_port   = 8080
  to_port     = 8080
  protocol    = "tcp"
  #cidr_blocks              = ["${chomp(data.http.myip.response_body)}/32"]
  source_security_group_id = module.app_alb_sg.security_group_id
  #ipv6_cidr_blocks  = [aws_vpc.example.ipv6_cidr_block]
  security_group_id = module.payment_sg.security_group_id
}
resource "aws_security_group_rule" "mysql_vpn" {
  type        = "ingress"
  description = "allowing 22 port number from vpn"
  from_port   = 22
  to_port     = 22
  protocol    = "tcp"
  #cidr_blocks              = ["${chomp(data.http.myip.response_body)}/32"]
  source_security_group_id = module.vpn_sg.security_group_id
  #ipv6_cidr_blocks  = [aws_vpc.example.ipv6_cidr_block]
  security_group_id = module.mysql_sg.security_group_id
}
resource "aws_security_group_rule" "shipping_vpn" {
  type        = "ingress"
  description = "allowing 22 port number from vpn"
  from_port   = 22
  to_port     = 22
  protocol    = "tcp"
  #cidr_blocks              = ["${chomp(data.http.myip.response_body)}/32"]
  source_security_group_id = module.vpn_sg.security_group_id
  #ipv6_cidr_blocks  = [aws_vpc.example.ipv6_cidr_block]
  security_group_id = module.shipping_sg.security_group_id
}
resource "aws_security_group_rule" "rabbitmq_vpn" {
  type        = "ingress"
  description = "allowing 22 port number from vpn"
  from_port   = 22
  to_port     = 22
  protocol    = "tcp"
  #cidr_blocks              = ["${chomp(data.http.myip.response_body)}/32"]
  source_security_group_id = module.vpn_sg.security_group_id
  #ipv6_cidr_blocks  = [aws_vpc.example.ipv6_cidr_block]
  security_group_id = module.rabbitmq_sg.security_group_id
}
resource "aws_security_group_rule" "paymemt_vpn" {
  type        = "ingress"
  description = "allowing 22 port number from vpn"
  from_port   = 22
  to_port     = 22
  protocol    = "tcp"
  #cidr_blocks              = ["${chomp(data.http.myip.response_body)}/32"]
  source_security_group_id = module.vpn_sg.security_group_id
  #ipv6_cidr_blocks  = [aws_vpc.example.ipv6_cidr_block]
  security_group_id = module.payment_sg.security_group_id
}
