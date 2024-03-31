resource "aws_s3_bucket_website_configuration" "website_config" {
    bucket = data.aws_s3_bucket.selected_bucket.bucket
    index_document {
      suffix = "index.html"
    }
    error_document {
      key = "404.jpg"
    }
}