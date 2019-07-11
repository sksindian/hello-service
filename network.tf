## VPC Creation in Region
resource "aws_vpc" "hello_vpc" {
   cidr_block = "${var.vpc_cidr}"
   assign_generated_ipv6_cidr_block = false
   tags = {
     Name = "hello-VPC"
   }
}

## IGW for outside connectivity
resource "aws_internet_gateway" "hello_igw" {
   vpc_id = "${aws_vpc.hello_vpc.id}"
   tags = {
      Name = "hello-igw"
   }
}

## Subnet for Application server {
resource "aws_subnet" "hello_subnet"{
   count = "${length(var.hello_subnets)}"
   vpc_id = "${aws_vpc.hello_vpc.id}"
   cidr_block = "${var.hello_subnets[count.index]}"
   availability_zone = "${var.hello_azone[count.index]}"
   tags = { 
      Name = "hello-Subnet_${count.index}"
   }
}

## setting route to the IGW
resource "aws_route_table" "main" {
   vpc_id = "${aws_vpc.hello_vpc.id}"
   route {
      cidr_block = "0.0.0.0/0"
      gateway_id = "${aws_internet_gateway.hello_igw.id}"
   }
   tags = {
      Name = "hello-route"
   }   
}

##Associating the routable with the subnets
resource "aws_route_table_association" "subnet_to_routable" {
   count = "${length(var.hello_subnets)}"
   subnet_id = "${element(aws_subnet.hello_subnet.*.id, count.index)}"
   route_table_id = "${aws_route_table.main.id}"
}
