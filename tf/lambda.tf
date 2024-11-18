resource "aws_lambda_function" "euromillions" {
  filename         = data.archive_file.euromillions.output_path
  function_name    = var.project_name
  role             = aws_iam_role.euromillions.arn
  handler          = "euromillions.main"
  source_code_hash = data.archive_file.euromillions.output_base64sha256
  runtime          = var.runtime
  layers           = [data.aws_lambda_layer_version.requests.arn, data.aws_lambda_layer_version.bs4.arn]
  architectures    = ["arm64"]
  timeout          = "60"

  environment {
    variables = {
      SNS_TOPIC             = "arn:aws:sns:${var.region}:${data.aws_caller_identity.current.account_id}:${var.sns_topic_name}"
      NOTIFICATIONS_ENABLED = var.notifications_enabled
    }
  }
}