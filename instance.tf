resource "aws_security_group" "web-sec"{
   name = "web-secgroup"
   vpc_id = "${aws_vpc.hello_vpc.id}"
   
   # Internal Full access with in the VPC
   ingress {
      from_port = 0
	  to_port = 0
	  protocol = "-1"
	  cidr_blocks = ["192.168.0.0/16"]
   }
   # Access to internal metadata for collecting the metadata
   ingress {
      from_port = 0
	  to_port = 0
	  protocol = "tcp"
	  cidr_blocks = ["169.254.169.254/32"]
   }   
   # Full Egress to download the software
   egress {
      from_port = 0
	  to_port = 0
	  protocol = "-1"
	  cidr_blocks = ["0.0.0.0/0"]
   }
}

resource "aws_instance" "hello_server"{
  ami = "${var.ami_id}"
  instance_type = "t2.micro"
  subnet_id = "${element(aws_subnet.hello_subnet.*.id, count.index)}"
  vpc_security_group_ids = ["${aws_security_group.web-sec.id}"]
  key_name = "sks"
  user_data = "${data.template_file.init.rendered}"
  count = "${var.instance_number}"
  tags = {
     Name = "${var.instance_name}_${terraform.workspace}_${count.index}"
	 Environment = "${terraform.workspace}"
	 Application = "Hello_Server"
  }
  depends_on = ["aws_route_table_association.subnet_to_routable"]
}
