provider "aws" {
  region = "us-east-1"  
}

# IAM User
resource "aws_iam_user" "my_user" {
  name = "RutvikD"
}

# Attach a policy to the user 
resource "aws_iam_user_policy_attachment" "my_user_policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonS3FullAccess" 
  user = aws_iam_user.my_user.name
}

# Policy that revokes permissions
resource "aws_iam_policy" "user_revoke_policy" {
  name = "user-revoke-policy"

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = ["*"],
        Effect = "Deny",
        Resource = "*",
      },
    ],
  })
}

# Revoke policy to the user
resource "aws_iam_user_policy_attachment" "my_user_revoke_policy" {
  policy_arn = aws_iam_policy.user_revoke_policy.arn
  user = aws_iam_user.my_user.name
}

# Delete the IAM user
resource "aws_iam_user_policy_attachment" "my_user_delete" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonS3FullAccess"  # Attach an administrative policy
  user = aws_iam_user.my_user.name
}
# Clean up and delete the IAM user
resource "null_resource" "delete_user" {
  triggers = {
    user_name = aws_iam_user.my_user.name
  }
 }

 #second user

resource "aws_iam_user" "my_user_2" {
  name = "DabhiR"
}

resource "aws_iam_policy" "my_2_policy" {
  name        = "user_EC2"
  description = "Gives access to EC2instance"

  # Define your policy document here using the policy JSON format.
  # Replace with your desired policy.
  policy = jsonencode(
  {
    "Version": "2012-10-17",
    "Statement": [
      {
        "Effect": "Allow",
        "Action": "*",
        "Resource": "*"
      }
    ]
  })
  

}

resource "aws_iam_user_policy_attachment" "user_EC2_attachment" {
  policy_arn = "arn:aws:iam::129919981991:policy/user_EC2"
  user       = aws_iam_user.my_user_2.name
}

resource "null_resource" "delete_user_2" {
  triggers = {
    user_name = aws_iam_user.my_user_2.name
  }
}
