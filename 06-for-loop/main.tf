resource "aws_instance" "roboshop" {
    for_each = var.instances
    ami = var.ami_id
    instance_type = each.value.instance_type
    vpc_security_group_ids = [aws_security_group.roboshop[each.key].id,
                              aws_security_group.common.id
    ]

    tags = merge (
      var.common-tags,
      {
        Name = "terraform-demo"
        Component = "demo"
      }
    )
    
}

#Security Groups Creation, it creates default VPC
resource "aws_security_group" "roboshop" {
  for_each = var.instances
  name        = "${var.project}-${var.environment}-${each.key}"
  description = "Allow TLS inbound traffic and all outbound traffic"
  
  #Outbound rules creation
  egress {
    from_port        = var.port
    to_port          = var.port
    protocol         = "-1" # means, allows all traffic
    cidr_blocks      = var.cidr
  }

  tags = merge (
      var.common-tags,
      {
        Name = "terraform-demo"
        Component = "demo"
      }
    )
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

  tags = merge (
      var.common-tags,
      {
        Name = "terraform-demo"
        Component = "demo"
      }
    )
}