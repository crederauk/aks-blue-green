# crederauk/aks_blue_green

## Description 
A repo that deploys AKS using a blue green deployment method

## Deployment

The order of deployment is as follows
1. `./terraform/base_infra`
2. `./terraform/aks/blue` and/or  `./terraform/aks/green`
3. `./terraform/agw`

Deployment is set up to be local at the moment so, `cd` into the dirs and run `terraform init`, `terraform plan` and, when happy with any changes, `terraform apply`

## Notes
* There is currently a manual step to assign a role to the AKS cluster, as the CI SPN does not have permissions to do this - this command will need running when the aks deploy pipeline times out/fails to run helm: `az role assignment create --assignee-object-id <AKS_MANAGED_IDENTITY_OBJECT_ID> --role "Network Contributor" --scope <AKS_SUBNET_ID>`
