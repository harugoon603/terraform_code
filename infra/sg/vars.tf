variable "region" {
  type    = string
  default = "ap-northeast-2"
}

variable "cidr_block" {
  type    = string
  default = "10.9.0.0/16"
}

variable "public_subnet_cidr" {
  type    = list(any)
  default = ["10.9.0.0/20", "10.9.16.0/20"]
}

variable "private_subnet_cidr" {
  type    = list(any)
  default = ["10.9.64.0/20", "10.9.80.0/20"]
}

variable "azs" {
  type    = list(any)
  default = ["ap-northeast-2a", "ap-northeast-2c"]
}
variable "vpc_id" {
  type    = string
  default = "vpc-07589df872b19ed12"
}