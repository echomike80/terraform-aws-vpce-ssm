variable "name" {
  description = "Name to be used on all the resources as identifier"
  type        = string
}

variable "vpc_id" {
  description = "ID of vpc"
  type        = string
}

variable "public_subnets" {
  description = "A list of public subnets inside the VPC"
  type        = list(string)
  default     = []
}

variable "private_subnets" {
  description = "A list of private subnets inside the VPC"
  type        = list(string)
  default     = []
}

variable "tags" {
  description = "A map of tags to add to all resources"
  type        = map(string)
  default     = {}
}

variable "enable_ssm_related_endpoints" {
  description = "Should be true if you want to provision VPC endpoints used for AWS SSM"
  type        = bool
  default     = false
}

variable "region" {
  description = "Name of region for VPC Endpoint"
  type        = string
}