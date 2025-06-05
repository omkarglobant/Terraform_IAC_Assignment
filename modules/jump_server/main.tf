#Create EC2 instances in public subnet 1
resource "aws_instance" "jump_server" {
  ami                         = var.ami_id
  instance_type               = var.instance_type
  associate_public_ip_address = true
  subnet_id                   = var.subnet_id_az1
  security_groups             = [var.security_group]
  availability_zone           = data.aws_availability_zones.az.names[0]
  key_name                    = "dojo_assign_key"

  tags = {
    Name = "${var.project_name}-jump-server"
  }
}


# AZ
data "aws_availability_zones" "az" {}