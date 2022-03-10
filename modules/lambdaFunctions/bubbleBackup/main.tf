/* 
 * This module is used to create Lambda function prod environment
 *
 * This function call the Bubble script for make the backup of the following
 *
 * - Bubble DB 
 * - Landing infos
 * - Users
 * - Installers
 * - Companies  
 *
 *
 * The Lambda functions can be found at [this url](https://eu-west-1.console.aws.amazon.com/lambda/home?region=eu-west-1#/functions)
*/

// Zip the nodejs script for later to be pushed on Lambda
data "archive_file" "lambda_zip" {
  count       = length(var.lambdaFunctionsEnvironmets)
  type        = "zip"
  source_dir  = "${path.module}/script/${element(var.lambdaFunctionsEnvironmets, count.index)}"
  output_path = "${path.module}/script/bubble_backup_lambda_function-${element(var.lambdaFunctionsEnvironmets, count.index)}.zip"
}

// Create Lambda Function
resource "aws_lambda_function" "deploy_lambda_backup_script" {
  count            = length(var.lambdaFunctionsEnvironmets)
  filename         = "${path.module}/script/bubble_backup_lambda_function-${element(var.lambdaFunctionsEnvironmets, count.index)}.zip"
  function_name    = "Call_Bubble_Backup_Script_${element(var.lambdaFunctionsEnvironmets, count.index)}"
  role             = "arn:aws:iam::848481299679:role/${var.lambda_role_bubble_backup}"
  handler          = "index.handler"
  source_code_hash = data.archive_file.lambda_zip["${count.index}"].output_base64sha256
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
}

// Create a cloudwatch event rule for lambda function
resource "aws_cloudwatch_event_rule" "scheduled_event_lambda" {
  count               = length(var.lambdaFunctionsEnvironmets)
  depends_on          = [aws_lambda_function.deploy_lambda_backup_script]
  name                = "BubbleBackupScriptInvoker${element(var.lambdaFunctionsEnvironmets, count.index)}"
  description         = "Schedule Lambda trigger for ${element(var.lambdaFunctionsEnvironmets, count.index)} Backup "
  schedule_expression = "cron(0 1 * * ? *)"
}

// Set the previous scheduled event to the lambda function
resource "aws_cloudwatch_event_target" "lambda" {
  depends_on = [aws_lambda_function.deploy_lambda_backup_script, aws_cloudwatch_event_rule.scheduled_event_lambda]

  count     = length(var.lambdaFunctionsEnvironmets)
  target_id = aws_lambda_function.deploy_lambda_backup_script["${count.index}"].id
  rule      = aws_cloudwatch_event_rule.scheduled_event_lambda["${count.index}"].name
  arn       = aws_lambda_function.deploy_lambda_backup_script["${count.index}"].arn
}

# This is to manage the CloudWatch Log Group for the Lambda Function.
resource "aws_cloudwatch_log_group" "logs_for_labda_execution" {
  count             = length(var.lambdaFunctionsEnvironmets)
  name              = "/aws/lambda/Call_Bubble_Backup_Script_${element(var.lambdaFunctionsEnvironmets, count.index)}"
  retention_in_days = 5
}

// Add trigger for the lambda function
resource "aws_lambda_permission" "allow_cloudwatch" {
  statement_id  = "AllowExecutionFromCloudWatch"
  count         = length(var.lambdaFunctionsEnvironmets)
  action        = "lambda:InvokeFunction"
  principal     = "events.amazonaws.com"
  function_name = "Call_Bubble_Backup_Script_${element(var.lambdaFunctionsEnvironmets, count.index)}"
  source_arn    = "arn:aws:events:eu-west-1:848481299679:rule/${aws_cloudwatch_event_rule.scheduled_event_lambda["${count.index}"].name}"
}


# See also the following AWS managed policy: AWSLambdaBasicExecutionRole
resource "aws_iam_policy" "lambda_logging" {
  name        = "lambda_logging"
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
      "Resource": "arn:aws:logs:*:*:*",
      "Effect": "Allow"
    }
  ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "lambda_logs" {
  role       = "lambdaRoleBubbleBackupprodEnv"
  policy_arn = aws_iam_policy.lambda_logging.arn
}
