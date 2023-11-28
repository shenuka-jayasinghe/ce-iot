resource "aws_instance" "app_server" {
  count         = 3
  ami           = "ami-0505148b3591e4c07"
  instance_type = "t2.micro"
  subnet_id     = var.public_subnets[count.index]

  tags = {
    Name = "microservice_00${count.index + 1}"
  }
  associate_public_ip_address = true
  vpc_security_group_ids      = [var.security_group_id]
  key_name                    = "terraform-key"
}
