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

resource "aws_launch_configuration" "as_conf" {
   image_id = "${var.ami_id}"
   instance_type = "t2.micro"
   security_groups = ["${aws_security_group.web-sec.id}"]
   key_name = "sks"
   user_data = "${data.template_file.init.rendered}"
   associate_public_ip_address = true
   lifecycle {
     create_before_destroy = true
   }
}

resource "aws_autoscaling_group" "hello_AIG" {
   name = "helloAG"
   max_size = "${var.max_num}"
   min_size = "${var.min_num}"
   min_elb_capacity = "3"
   health_check_grace_period = "300"
   health_check_type = "ELB" 
   default_cooldown = "60"
   termination_policies = ["OldestInstance"]
   launch_configuration = "${aws_launch_configuration.as_conf.name}"
   tags = [
     {
      key = "application"
      value = "hello-server"
      propagate_at_launch = true 
     }  
   ]
   vpc_zone_identifier = "${compact(aws_subnet.hello_subnet.*.id)}"
   lifecycle {
     create_before_destroy = true
   }
   target_group_arns = ["${aws_lb_target_group.targ.arn}"]
}

resource "aws_autoscaling_attachment" "asg_attachment" {
   autoscaling_group_name = "${aws_autoscaling_group.hello_AIG.id}"
   alb_target_group_arn = "${aws_lb_target_group.targ.arn}"
}
