variable "vpc_cidr" {

  default = "10.0.0.0/16"
}

variable "ami" {

  default = "ami-0aa7d40eeae50c9a9"
}

variable "instance_type" {

  default = "t2.micro"
}

variable "aws_key" {

  default = "Jenkin_Key"
}

variable "azs" {

  default = "us-east-1e"

}