resource "aws_instance" "roboshop" {
    count = length(var.instances)
    ami = var.ami_id
    instance_type = var.instance_type
    vpc_security_group_ids = [aws_security_group.roboshop[count.index].id,
                              aws_security_group.common.id
    ]

    tags = {
      Name = "${var.project}-${var.environment}-${var.instances[count.index]}"
    }
}

#Security Groups Creation, it creates default VPC
resource "aws_security_group" "roboshop" {
  count = length(var.instances)
  name        = "${var.project}-${var.environment}-${var.instances[count.index]}"
  description = "Allow TLS inbound traffic and all outbound traffic"
  
  #Outbound rules creation
  egress {
    from_port        = var.port
    to_port          = var.port
    protocol         = "-1" # means, allows all traffic
    cidr_blocks      = var.cidr
  }

  tags = {
    Name = "${var.project}-${var.environment}-${var.instances[count.index]}"
  }
}

#common
resource "aws_security_group" "common" {
  name        = "${var.project}-${var.environment}-common" # roboshop-t3.micro-common
  description = "Allow TLS inbound traffic and all outbound traffic"
  
  #Outbound rules creation
  egress {
    from_port        = var.port
    to_port          = var.port
    protocol         = "-1" # means, allows all traffic
    cidr_blocks      = var.cidr
  }

  tags = {
    Name = "${var.project}-${var.environment}-common"
  }
}