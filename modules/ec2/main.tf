#Create EC2 instances in public subnet 1
resource "aws_instance" "demo_instance_1" {
  ami                         = var.ami_id
  instance_type               = var.instance_type
  associate_public_ip_address = false
  subnet_id                   = var.subnet_id_az1
  security_groups             = [var.security_group]
  availability_zone           = data.aws_availability_zones.az.names[0]
  key_name                    = "dojo_assign_key"

  user_data = <<-EOF
    #!/bin/bash
    apt-get update -y
    apt-get install -y nginx curl  # Install Nginx and curl
    systemctl start nginx
    systemctl enable nginx
    echo "<h1>Code finally Worked. EC2 instance launched</h1>" > /var/www/html/index.html
    PRIVATE_IP=$(curl -s http://169.254.169.254/latest/meta-data/local-ipv4)
    echo "<h2>Demo Instance 1</h2>" >> /var/www/html/index.html
    EOF

  tags = {
    Name = "${var.project_name}-demo-instance-1"
  }
}

#Create EC2 instances in public subnet 2
resource "aws_instance" "demo_instance_2" {
  ami                         = var.ami_id
  instance_type               = var.instance_type
  associate_public_ip_address = false
  subnet_id                   = var.subnet_id_az2
  security_groups             = [var.security_group]
  availability_zone           = data.aws_availability_zones.az.names[1]
  key_name                    = "dojo_assign_key"

  user_data = <<-EOF
    #!/bin/bash
    apt-get update -y
    apt-get install -y nginx curl  # Install Nginx and curl
    systemctl start nginx
    systemctl enable nginx
    echo "<h1>Code finally Worked. EC2 instance launched" > /var/www/html/index.html
    PRIVATE_IP=$(curl -s http://169.254.169.254/latest/meta-data/local-ipv4)
    echo "<h2>Demo Instance 2" >> /var/www/html/index.html
    EOF

  tags = {
    Name = "${var.project_name}-demo-instance-2"
  }
}

# AZ
data "aws_availability_zones" "az" {}
