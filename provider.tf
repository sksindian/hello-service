provider "aws" {
  region     = "${var.region}"
  access_key = "${var.access}"
  secret_key = "${var.secret}"
}

data "template_file" "init" {
  template = "${file("userdata.sh")}"

  vars = {
    access = "${var.access}"
    secret = "${var.secret}"
    region = "${var.region}"
  }
}

provider "aws" {
  region     = "us-east-2"
  access_key = "${var.access}"
  secret_key = "${var.secret}"
  alias = "east-2"
}
