/* 
 * This module is used to create Lambda function prod environment
 *
 * This function call the Bubble script for delete Bubble backup older than 30 days
 *
 *
 * The Lambda functions can be found at [this url](https://eu-west-1.console.aws.amazon.com/lambda/home?region=eu-west-1#/functions)
*/

// Zip the nodejs script for later to be pushed on Lambda
data "archive_file" "lambda_zip" {
  type        = "zip"
  source_dir  = "${path.module}/script"
  output_path = "${path.module}/script/deleteBubbleBackup.zip"
}

// Create Lambda Function
resource "aws_lambda_function" "deploy_lambda_script" {
  filename         = "${path.module}/script/deleteBubbleBackup.zip"
  function_name    = "Bubble_Backup_Deletion_Script"
  role             = "arn:aws:iam::848481299679:role/${var.lambda_role_delete_bubble_backup}"
  handler          = "index.handler"
  source_code_hash = data.archive_file.lambda_zip.output_base64sha256
  runtime          = "nodejs14.x"
  timeout          = 45

  lifecycle {
    ignore_changes = [
      filename,
      last_modified,
      qualified_arn,
      version,
    ]
  }

  tracing_config {
    mode = "Active"
  }
}

// Create a cloudwatch event rule for lambda function
resource "aws_cloudwatch_event_rule" "scheduled_event_lambda" {
  depends_on          = [aws_lambda_function.deploy_lambda_script]
  name                = "DeleteBubbleBackupScriptInvoker"
  description         = "Schedule Lambda trigger for delete Bubble Backup "
  schedule_expression = "cron(0 2 * * ? *)"
}

// Set the previous scheduled event to the lambda function
resource "aws_cloudwatch_event_target" "lambda" {
  depends_on = [aws_lambda_function.deploy_lambda_script, aws_cloudwatch_event_rule.scheduled_event_lambda]

  target_id = aws_lambda_function.deploy_lambda_script.id
  rule      = aws_cloudwatch_event_rule.scheduled_event_lambda.name
  arn       = aws_lambda_function.deploy_lambda_script.arn
}

# This is to manage the CloudWatch Log Group for the Lambda Function.
#tfsec:ignore:aws-cloudwatch-log-group-customer-key
resource "aws_cloudwatch_log_group" "logs_for_lambda_execution" {
  name              = "/aws/lambda/Bubble_Backup_Deletion_Script"
  retention_in_days = 5
}

// Add trigger for the lambda function
resource "aws_lambda_permission" "allow_cloudwatch" {
  statement_id  = "AllowExecutionFromCloudWatch"
  action        = "lambda:InvokeFunction"
  principal     = "events.amazonaws.com"
  function_name = "Bubble_Backup_Deletion_Script"
  source_arn    = "arn:aws:events:eu-west-1:848481299679:rule/${aws_cloudwatch_event_rule.scheduled_event_lambda.name}"
}

# See also the following AWS managed policy: AWSLambdaBasicExecutionRole
#tfsec:ignore:aws-iam-no-policy-wildcards
resource "aws_iam_policy" "lambda_logging" {
  name        = "lambda_logging_delete_backup"
  path        = "/"
  description = "IAM policy for logging from a lambda"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "logs:CreateLogGroup",
        "logs:CreateLogStream",
        "logs:PutLogEvents"
      ],
      "Resource": "arn:aws:logs:eu-west-1:848481299679:log-group:/aws/lambda/Delete_Bubble_Backup_Script:*",
      "Effect": "Allow"
    }
  ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "lambda_logs" {
  depends_on = [aws_iam_policy.lambda_logging]
  role       = "lambdaRoleDeleteBubbleBackup"
  policy_arn = aws_iam_policy.lambda_logging.arn
}
