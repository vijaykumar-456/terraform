resource "aws_instance" "terrafrom_demo" {
    ami = var.ami_id
    instance_type = var.environment == "dev" ? "t3.micro" : "t3.small"
    vpc_security_group_ids = [aws_security_group.allow-terraform.id]

    tags = var.ec2-tags
}

#Security Groups Creation, it creates default VPC
resource "aws_security_group" "allow-terraform" {
  name        = var.sg_name
  description = "Allow TLS inbound traffic and all outbound traffic"
  
  #Outbound rules creation
  egress {
    from_port        = var.port
    to_port          = var.port
    protocol         = "-1" # means, allows all traffic
    cidr_blocks      = var.cidr
  }

  tags = {
    Name = "allow-terraform"
    Project = "roboshop"
    Environment = "dev"
  }
}