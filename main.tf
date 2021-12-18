 resource "aws_vpc" "myvpc" {
  cidr_block         = "10.0.0.0/16"
}
 

resource "aws_subnet" "mysubnet" {
  vpc_id              = aws_vpc.myvpc.id
  cidr_block          = "10.0.1.0/24"

  tags = {
    Name = "mysubnet"
  }
}



resource "aws_internet_gateway" "mygw" {
  vpc_id = aws_vpc.myvpc.id

  tags = {
    Name = "myigw"
  }
}
resource "aws_security_group" "mysg" {
  vpc_id                 = aws_vpc.myvpc.id
  name                   = "mysg"

  ingress {
    from_port            = 22
    protocol             = "tcp"
    to_port              = 22
    cidr_blocks          = ["0.0.0.0/0"]
  }

  ingress {
    from_port            = 80
    protocol             = "tcp"
    to_port              = 80
    cidr_blocks          = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "myserver1" {
  count                        = "1"
  ami                          = "ami-002068ed284fb165b"
  instance_type                = "t2.micro"
  subnet_id                    = aws_subnet.mysubnet.id
  vpc_security_group_ids       = [aws_security_group.mysg.id]

  tags = {
    name = "testserver"
  }
}