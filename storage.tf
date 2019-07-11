resource "aws_s3_bucket_object" "object_service" {
  bucket = "hello-network-assignment"
  key    = "hello.service"
  source = "hello.service"
  etag = "${filemd5("hello.service")}"
}

resource "aws_s3_bucket_object" "object_sh" {
  bucket = "hello-network-assignment"
  key    = "hello.sh"
  source = "hello.sh"
  etag = "${filemd5("hello.sh")}"
}

resource "aws_s3_bucket_object" "object_py" {
  bucket = "hello-network-assignment"
  key    = "hello.py"
  source = "hello.py"
  etag = "${filemd5("hello.py")}"
}
