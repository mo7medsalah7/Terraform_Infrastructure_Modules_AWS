#  Security Group Creation
# Allows HTTPS/HTTP/SSH
resource "aws_security_group" "allow_http_https_ssh-sg" {
  name        = "allow_http_https_ssh"
  description = "Allow inbound HTTP, HTTPS and SSH traffic"

  vpc_id = var.vpc_id

  #  Allow inbound HTTP, HTTPS and SSH traffic
  ingress {
    description = "HTTPS_Rule"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTP_Rule"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]

  }
  ingress {
    description = "SSH_Rule"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  #  allow all outbound traffic from the ec2 instance
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "allow_http_https_ssh"
  }
}
