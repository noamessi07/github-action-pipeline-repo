 resource "aws_vpc" "myvpc" {
  cidr_block         = var.cidr1
}
 

resource "aws_subnet" "mysubnet" {
  vpc_id              = aws_vpc.myvpc.id
  cidr_block          = var.cidr2

  tags = {
    Name = var.tags1 
  }
}



resource "aws_internet_gateway" "mygw" {
  vpc_id = aws_vpc.myvpc.id

  tags = {
    Name = var.tags2  
  }
}
resource "aws_security_group" "mysg" {
  vpc_id                 = aws_vpc.myvpc.id
  name                   =  var.name 

  ingress {
    from_port            = var.from_port1
    protocol             = var.protocol 
    to_port              = var.to_port1 
    cidr_blocks          = var.blocks 
  }

  ingress {
    from_port            = var.from_port2
    protocol             = var.protocol 
    to_port              = var.to_port2 
    cidr_blocks          = var.blocks 
  }
  tags = {
    name = var.tags3 
  }
}

resource "aws_instance" "myserver1" {
  count                        = "2" 
  ami                          = var.ami
  instance_type                = var.type
  subnet_id                    = aws_subnet.mysubnet.id
  vpc_security_group_ids       = [aws_security_group.mysg.id]

  tags = {
    name = var.tags4 
  }
}