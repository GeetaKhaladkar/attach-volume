
resource "aws_security_group" "SG_Devops" {
  vpc_id = aws_vpc.my-vpc.id
  name   = "SG_Devops"

  ingress {
    from_port   = 22
    to_port     = 22
    cidr_blocks = ["0.0.0.0/0"]
    protocol    = "tcp"
  }
  ingress {
    from_port   = 80
    to_port     = 80
    cidr_blocks = ["0.0.0.0/0"]
    protocol    = "tcp"
  }
  ingress {
    from_port   = 8080
    to_port     = 8080
    cidr_blocks = ["0.0.0.0/0"]
    protocol    = "tcp"
  }
  egress {
    from_port   = 0
    protocol    = "-1"
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }


}




resource "aws_instance" "EC2-public" {
  ami             = var.ami
  instance_type   = var.instance_type
  security_groups = [aws_security_group.SG_Devops.id]
  subnet_id       = aws_subnet.pubsub.id
  key_name        = var.aws_key
  tags = {
    "Name" = "EC2-public"
  }


}


resource "aws_instance" "EC2-private" {
  ami             = var.ami
  instance_type   = var.instance_type
  security_groups = [aws_security_group.SG_Devops.id]
  subnet_id       = aws_subnet.prisub.id
  key_name        = var.aws_key
  #volume_size     = "8 GiB"
  tags = {
    "Name" = "EC2-private"
  }

  resource "aws_ebs_volume" "example" {
    instance_type = var.instance_type
    size          = 8
    type          = "gp2"
  }

  resource "aws_volume_attachment" "ebs_att" {
    device_name = "/dev/xvdh"
    volume_id   = aws_ebs_volume.example.id
    instance_id = aws_instance.EC2-private.id
  }



}