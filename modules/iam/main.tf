# IAM role for ec2
resource "aws_iam_role" "ec2_role" {
  name = var.iam_role_name

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = "sts:AssumeRole",
        Effect = "Allow",
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      }
    ]
  })
}


# defining IAM policy to attach to the role
resource "aws_iam_role_policy_attachment" "attach_policies" {
  for_each   = toset(var.policy_arns)
  role       = aws_iam_role.ec2_role.name
  policy_arn = each.value
}

# defining instance ec2 profile
resource "aws_iam_instance_profile" "ec2_profile" {
  name = var.iam_role_name
  role = aws_iam_role.ec2_role.name
}
