resource "aws_instance" "terrafrom_demo" {
    ami = local.ami_id
    instance_type = local.instance_type
    vpc_security_group_ids = [aws_security_group.allow-terraform.id]

    tags = local.ec2_tags
}

#Security Groups Creation, it creates default VPC
resource "aws_security_group" "allow-terraform" {
  name        = "${local.name}-common"
  description = "Allow TLS inbound traffic and all outbound traffic"
  
  #Outbound rules creation
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1" # means, allows all traffic
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }


  tags = local.sg_tags
}