resource "aws_instance" "my_instance" {
  ami             = "${data.aws_ami.ubuntu.id}"
  instance_type   = "t2.micro"
  key_name        = "${aws_key_pair.my_key.key_name}"
  security_groups = ["${aws_security_group.my_security_group.name}"]

  tags {
    Name = "FOO"
  }
}

resource "aws_key_pair" "my_key" {
  key_name   = "FOO"
  public_key = "${file("~/.ssh/id_rsa.pub")}"
}

resource "aws_security_group" "my_security_group" {
  name_prefix = "my_security_group_"

  // SSH inbound
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  // inbound all within security group
  ingress {
    from_port = 0
    to_port   = 0
    protocol  = "-1"
    self      = true
  }

  // outbound all
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags {
    Name = "FOO"
  }
}
