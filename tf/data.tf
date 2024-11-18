data "aws_caller_identity" "current" {}

data "aws_lambda_layer_version" "requests" {
  layer_name = "requests"
}

data "aws_lambda_layer_version" "bs4" {
  layer_name = "bs4"
}

data "archive_file" "euromillions" {
  type        = "zip"
  source_dir  = "../src/euromillions"
  output_path = "../src/euromillions.zip"
}