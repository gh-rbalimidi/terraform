# locals {
#   redrive_policy = jsonencode({
#     deadLetterTargetArn = var.dead_letter_queue
#     maxReceiveCount     = var.max_receive_count
#   })
# }

resource "aws_sqs_queue" "queue" {
  name = var.queue_name
  tags = var.tags

  visibility_timeout_seconds = var.visibility_timeout_seconds
  message_retention_seconds  = var.message_retention_seconds
  max_message_size           = var.max_message_size
  delay_seconds              = var.delay_seconds
  receive_wait_time_seconds  = var.receive_wait_time_seconds
  fifo_queue                  = var.fifo_queue
  fifo_throughput_limit       = var.fifo_throughput_limit
  content_based_deduplication = var.content_based_deduplication
  deduplication_scope         = var.deduplication_scope
}


   
resource "aws_iam_role" "apig-sqs-send-msg-role" {
  name = "${var.queue_name}-apig-sqs-send-msg-role"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "apigateway.amazonaws.com"
      },
      "Effect": "Allow"
    }
  ]
}
EOF
}

resource "aws_iam_policy" "apig-sqs-send-msg-policy" {
  name        = "${var.queue_name}-apig-sqs-send-msg-policy"
  description = "Policy allowing APIG to write to SQS for ${var.queue_name}"

  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
           "Effect": "Allow",
           "Resource": [
               "*"
           ],
           "Action": [
               "logs:CreateLogGroup",
               "logs:CreateLogStream",
               "logs:PutLogEvents"
           ]
       },
       {
          "Effect": "Allow",
          "Action": "sqs:SendMessage",
          "Resource": "${aws_sqs_queue.queue.arn}"
       }
    ]
}
EOF
}

## IAM Role Policies
resource "aws_iam_role_policy_attachment" "terraform_apig_sqs_policy_attach" {
  role       = "${aws_iam_role.apig-sqs-send-msg-role.id}"
  policy_arn = "${aws_iam_policy.apig-sqs-send-msg-policy.arn}"
}
