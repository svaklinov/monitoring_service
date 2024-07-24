########## web server host ################
resource "aws_instance" "this" {
  ami             = var.ami
  instance_type   = "t3.medium"
  subnet_id       = module.vpc.public_subnets[0]
  security_groups = [aws_security_group.http_access.id]

  tags = {
    Name = var.vm_name
  }

  depends_on = [module.vpc]
  user_data  = file("install.sh")
}