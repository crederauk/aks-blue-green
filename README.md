# crederauk/aks_blue_green

## Description 
A repo that deploys AKS using a blue green deployment method

## Deployment

The order of deployment is as follows
1. `./terraform/base_infra`
2. `./terraform/aks/blue` and/or `./terraform/aks/green`
3. `./terraform/agw`

Deployment can be done locally in your terminal:
- `cd` into the dirs and run `terraform init`, `terraform plan` and, when happy with any changes, `terraform apply`

Or, via the GithubActions Pipeline defined at `.github/workflows/deploy.yaml`. this relies on inputs passed into the pipeline at runtime and some github secrets seen in the pipeline file

## Notes
* There is currently a manual step to assign a role to the AKS cluster, as the CI SPN does not have permissions to do this - this command will need running when the aks deploy pipeline times out/fails to run helm: `az role assignment create --assignee-object-id <AKS_MANAGED_IDENTITY_OBJECT_ID> --role "Network Contributor" --scope <AKS_SUBNET_ID>`
This can be achived in one line withthe following command: 
`az role assignment create --assignee-object-id $(az aks show --name aks-cluster-<CLUSTER_COLOUR> --resource-group aks-rg | jq -r '.identity.principalId') --role "Network Contributor" --scope $(az network vnet subnet list -g aks-rg --vnet-name aks-vnet | jq -r '.[] | select( .id | contains("<CLUSTER_COLOUR>")) | .id')`
