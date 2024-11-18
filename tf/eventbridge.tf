#Create Eventbridge rule to invoke Lambda function each day at specific time
resource "aws_cloudwatch_event_rule" "euromillions" {
  name        = "${var.project_name}_invoke"
  description = "Rule to invoke euromillions function"

  schedule_expression = var.invoke_cron
}

#Link Eventbridge rule to Lambda function
resource "aws_cloudwatch_event_target" "euromillions" {
  rule      = aws_cloudwatch_event_rule.euromillions.name
  target_id = "${var.project_name}_invoke"
  arn       = aws_lambda_function.euromillions.arn
}
