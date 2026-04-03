resource "random_id" "rand" {
  byte_length = 4
}

resource "aws_s3_bucket" "logs_bucket" {
  bucket = "terraweek-logs-${random_id.rand.hex}"
}