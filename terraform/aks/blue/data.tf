data "terraform_remote_state" "base_infra" {
  backend = "local"

  config = {
    path = "../../base_infra"
  }
}
