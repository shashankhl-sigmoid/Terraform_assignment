resource "aws_instance" "public_vm" {
  ami                    = "ami-0c02fb55956c7d316"
  instance_type          = "t2.micro"
  subnet_id              = aws_subnet.public_subnet.id
  key_name               = aws_key_pair.generated_key_pair.key_name
  vpc_security_group_ids = [aws_security_group.default.id]

  tags = {
    Name = "Public-VM"
  }

  user_data = <<-EOF
                #!/bin/bash
                yum update -y
                amazon-linux-extras enable nginx1
                yum install nginx -y
                systemctl start nginx
  EOF
}

resource "aws_instance" "private_vm" {
  ami                    = "ami-0c02fb55956c7d316"
  instance_type          = "t2.micro"
  subnet_id              = aws_subnet.private_subnet.id
  key_name               = aws_key_pair.generated_key_pair.key_name
  vpc_security_group_ids = [aws_security_group.default.id]

  tags = {
    Name = "Private-VM"
  }
}
