resource "aws_instance" "terrafrom_demo" {
    ami = "ami-0220d79f3f480ecf5"
    instance_type = "t3.micro"
    vpc_security_group_ids = [aws_security_group.allow-terraform.id]

    tags = {
    Name = "allow-terraform-1"
    Project = "roboshop"
    Environment = "dev"
  }

  provisioner "local-exec" {
    command = " echo ${self.private_ip} > inventory.ini"

  }

  provisioner "local-exec" {
    command = "echo instance created"
  }

  provisioner "local-exec" {
    when = destroy
    command = "echo > inventory.ini"

  }

  connection {
      type        = "ssh"
      user        = "ec2-user"
      password = "DevOps321"
      host        = self.public_ip
    }
  
  provisioner "remote-exec" {
    inline = [ 
      "sudo dnf install nginx -y",
      "sudo systemctl start nginx"
     ]
  }

  provisioner "file" {
    source = "script.sh"
    destination = "/tmp/script.sh"

  }
}





#Security Groups Creation, it creates default VPC
resource "aws_security_group" "allow-terraform" {
  name        = "allow-terraform_provisioners"
  description = "Allow TLS inbound traffic and all outbound traffic"
  
  #Outbound rules creation
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1" # means, allows all traffic
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  ingress {
    from_port        = 22
    to_port          = 22
    protocol         = "tcp" # all traffic
    cidr_blocks      = ["0.0.0.0/0"]
  }


  tags = {
    Name = "allow-terraform"
    Project = "roboshop"
    Environment = "dev"
  }
}