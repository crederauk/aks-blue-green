variable "ingress_replicas" {
  type        = number
  default     = 1
  description = "number of ingress replicas to create"
}

variable "maintainer" {
  type        = string
  description = "Name of the user deploying the terraform"
}

variable "subscription_id" {
  type = string
}

variable "k8s_version" {
  type        = string
  default     = "1.24.6"
  description = "the version of kubernetes to use"
}

variable "nginx_chart_version" {
  type        = string
  default     = "4.3.0"
  description = "The version of the Nginx Helm chart to use to deploy the ingress controller"
}
