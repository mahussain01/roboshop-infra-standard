

variable "project_name" {
  default = "roboshop"
}
variable "env" {
  default = "Dev"
}
variable "tags" {
  default = {
    Project   = "roboshop"
    Component = "user"
  }
}
variable "target_group_port" {
  default = 8080
}
variable "launch_template_tags" {
  default = [
    {
      resource_type = "instance"

      tags = {
      Name = "user" }
    },
    {
      resource_type = "volume"

      tags = {
      Name = "user" }
    }
  ]
}
variable "autoscaling_tags" {
  default = [
    {
      key                 = "Name"
      value               = "user"
      propagate_at_launch = true
    },
    {
      key                 = "Project"
      value               = "Roboshop"
      propagate_at_launch = true
    }
  ]
}
