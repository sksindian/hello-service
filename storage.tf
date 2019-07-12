resource "aws_s3_bucket_object" "object_service" {
  bucket = "hello-network-assignment"
  key    = "hello.service"
  source = "hello.service"
  etag = "${filemd5("hello.service")}"
  provider = "aws.east-2"
}

resource "aws_s3_bucket_object" "object_sh" {
  bucket = "hello-network-assignment"
  key    = "hello.sh"
  source = "hello.sh"
  etag = "${filemd5("hello.sh")}"
  provider = "aws.east-2"
}

resource "aws_s3_bucket_object" "object_py" {
  bucket = "hello-network-assignment"
  key    = "hello.py"
  source = "hello.py"
  etag = "${filemd5("hello.py")}"
  provider = "aws.east-2"
}
