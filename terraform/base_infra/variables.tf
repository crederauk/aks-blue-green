variable "location" {
  type    = string
  default = "centralus"
}

variable "address_space" {
  type    = string
  default = "10.0.0.0/20"
}

variable "maintainer" {
  type        = string
  description = "Name of the user deploying the terraform"
}

variable "subscription_id" {
  type = string
}
