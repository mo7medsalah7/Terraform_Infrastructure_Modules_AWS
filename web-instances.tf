resource "aws_instance" "MoSalah_Instance" {
  for_each               = aws_subnet.public_subnet
  subnet_id              = each.value.id
  ami                    = var.ec2_instance_ami
  instance_type          = var.ec2_instance_type
  availability_zone      = each.value.availability_zone
  vpc_security_group_ids = [aws_security_group.allow_http_https_ssh-sg.id]
  user_data              = <<EOF
       #!/bin/bash
       yum update -y
       yum install -y httpd
       systemctl start httpd
       systemctl enable httpd
       echo '<center><h1>This is <strong>Mohamed Salah</strong> Instance. </h1></center>' > /var/www/html/index.txt
       EOF

  tags = {
    Name = "MoSalah_Instance"
  }
}
