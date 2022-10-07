variable "maintainer" {
  type        = string
  description = "Name of the user deploying the terraform"
}

variable "subscription_id" {
  type = string
}

variable "current_active_cluster" {
  type = string
  description = "Either \"blue\" or \"green\""
  default = "blue"

  validation {
    condition = var.current_active_cluster == "blue" || var.current_active_cluster == "green"
    error_message = "The current_active_cluster variable must be set to either \"blue\" or \"green\""
  }
}
