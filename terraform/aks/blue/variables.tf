variable "ingress_replicas" {
  type        = number
  default     = 1
  description = "number of ingress replicas to create"
}

variable "maintainer" {
  type        = string
  description = "Name of the user deploying the terraform"
}
