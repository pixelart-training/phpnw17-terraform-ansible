resource "aws_instance" "my_instance" {
  ami           = "${var.aws_ami}"
  instance_type = "t2.micro"

  tags {
    Name = "FOO"
  }
}
