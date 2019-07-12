# Create an application Load balance
resource "aws_alb" "alb" {
   name = "hello-lb"
   internal = "false"
   load_balancer_type = "application"
   security_groups    = ["${aws_security_group.lb-sec.id}"]
   subnets            = "${aws_subnet.hello_subnet.*.id}"
}

# Create the target group
resource "aws_lb_target_group" "targ" {
   name     = "hello-tg"
   port     = 8080
   protocol = "HTTP"
   vpc_id = "${aws_vpc.hello_vpc.id}"
}

#Attah the instances to the target 
resource "aws_lb_target_group_attachment" "attach_web" {
   target_group_arn = "${aws_lb_target_group.targ.arn}"
   target_id = "${element(aws_instance.hello_server.*.id, count.index)}"
   port = 8080
   count = "${var.instance_number}"
}

#Load Balancer Listener resource.
resource "aws_lb_listener" "list" {
   default_action {
       target_group_arn = "${aws_lb_target_group.targ.arn}"
       type = "forward"
   }
   load_balancer_arn = "${aws_alb.alb.arn}"
   port = 8080
   depends_on = ["aws_eip_association.ec2_eip"]
}

##security group allow 8080 from outside world and inside private vlan full connectiivty
resource "aws_security_group" "lb-sec"{
   name = "lb-secgroup"
   vpc_id = "${aws_vpc.hello_vpc.id}"
   #8080 Acess from anywhere
   ingress {
      from_port = 8080
	  to_port = 8080
	  protocol = "tcp"
	  cidr_blocks = ["0.0.0.0/0"]
   }
   ingress {
      from_port = 0
	  to_port = 0
	  protocol = "-1"
	  cidr_blocks = ["192.168.0.0/16"]
   }
   egress {
      from_port = 0
	  to_port = 0
	  protocol = "-1"
	  cidr_blocks = ["0.0.0.0/0"]
   }
}

output "lb_address" {
   value = "${aws_alb.alb.dns_name}"
}
