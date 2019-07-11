variable vpc_cidr {
   default = "192.168.0.0/16"
}

variable hello_subnets {
   default = ["192.168.1.0/24", "192.168.2.0/24", "192.168.3.0/24"]
}

variable hello_azone {
  default = ["us-east-2a", "us-east-2b", "us-east-2c"]
}

variable ami_id {
  default = "ami-0d8f6eb4f641ef691"
}

variable instance_number {
  default = "3"
}

variable instance_name {
  default = "hello"
} 

variable region {
  default = "us-east-2"
}

variable access {
  default = "AKIAUGZ6US2C2ANGM6KO"
}

variable secret {
  default = "6XjSX5We7BxS7aMkY2glCeLEQ2Ve9Mpe7qdwIHia"
}

