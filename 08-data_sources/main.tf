resource "aws_instance" "terrafrom_demo" {
    ami = data.aws_ami.learndevopskills.id
    instance_type = "t3.micro"
    vpc_security_group_ids = [aws_security_group.allow-terraform.id]

    tags = {
    Name = "allow-terraform-1"
    Project = "roboshop"
    Environment = "dev"
  }
}

#Security Groups Creation, it creates default VPC
resource "aws_security_group" "allow-terraform" {
  name        = "allow-terraform-1"
  description = "Allow TLS inbound traffic and all outbound traffic"
  
  #Outbound rules creation
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1" # means, allows all traffic
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }


  tags = {
    Name = "allow-terraform"
    Project = "roboshop"
    Environment = "dev"
  }
}