variable "region" {
  type    = string
  default = "ap-northeast-2"
}

variable "vpc_id" {
  type    = string
  default = "vpc-07589df872b19ed12"
}

variable "public_subnet_id" {
  type    = list(any)
  default = ["subnet-06a7d7b6555fa4edc", "subnet-038712326c23716f3"]
}

variable "private_subnet_id" {
  type    = list(any)
  default = ["subnet-01d7dc5f3914d1cb3", "subnet-0a4861f82c5f90d8c"]
}
