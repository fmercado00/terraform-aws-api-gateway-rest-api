# IAM
resource "aws_iam_role" "role" {
  name = "usmis-protocols-role"

  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
POLICY
}

# resource "aws_iam_policy" "usmis-list-s3-buckets-policy" {
#   name        = "usmis-list-s3-buckets-policy"
#   description = "Policy to list S3 buckets"

#   policy = <<EOF
#   {
#     "Version": "2012-10-17",
#     "Statement": [
#         {
#             "Sid": "VisualEditor0",
#             "Effect": "Allow",
#             "Action": "s3:ListAllMyBuckets",
#             "Resource": "*"
#         }
#     ]
#   }
#   EOF
# }

resource "aws_iam_role_policy_attachment" "usmis-attach-s3-list-buckets-policy" {
  role       = aws_iam_role.role.name
  policy_arn = "arn:aws:iam::154499352692:policy/S3ListAllMyBuckets" #  aws_iam_policy.usmis-list-s3-buckets-policy.arn
}