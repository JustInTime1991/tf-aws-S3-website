resource "aws_s3_bucket_ownership_controls" "s3_bucket_acl_ownership" {
    bucket = data.aws_s3_bucket.selected_bucket.id
    rule {
        object_ownership = "BucketOwnerPreferred"
    }
    depends_on = [ aws_s3_bucket_public_access_block.access ]
}

resource "aws_s3_bucket_public_access_block" "access" {
    bucket = data.aws_s3_bucket.selected_bucket.id

    block_public_acls = false
    block_public_policy = false
    ignore_public_acls = false
    restrict_public_buckets = false
}

resource "aws_s3_bucket_policy" "bucket_policy" {
    bucket = data.aws_s3_bucket.selected_bucket.id
    policy = data.aws_iam_policy_document.iam-policy-1.json
}

data "aws_iam_policy_document" "iam-policy-1" {
    statement {
        sid = "AllowPublicRead"
        effect = "Allow"
    resources = [
        "arn:aws:s3:::www.${bucket_name}",
        "arn:aws:s3:::www.${bucket_name}/*",
    ]
    actions = ["S3:GetObject"]
    principals {
        type = "*"
        identifiers = ["*"]
    }
    }
    depends_on = [ aws_s3_bucket_public_access_block.access ]
}