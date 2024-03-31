resource "aws_s3_bucket_versioning" "bucket_versioning" {
    bucket = data.aws_s3_bucket.selected_bucket.id
    versioning_configuration {
        status = "Enabled"
    }
}