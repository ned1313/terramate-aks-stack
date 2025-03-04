# Onboarding to Terramate Cloud

## Commands to run

Create the stacks for Terramate

```bash
terramate create --all-terraform
```

Create a `terraform.tm.hcl` file with the following content:

```hcl
terramate {
    config {
        cloud {
            organization = "ORG_NAME"
        }
    }
}
```

```bash
git add .
git commit -m "Terramate onboarding"
git push
```

```bash
terramate run --sync-drift-status --terraform-plan-file="drift.tfplan" --continue-on-error -- terraform plan -detailed-exitcode -out="drift.tfplan"
```

That will load the current infra info into Terramate Cloud.

Now we will introduce some drift by changing the AKS cluster minimum count from 1 to 2 via the CLI or UI:

```powershell
# Get the resource group, cluster, and nodepool name
$aks = az aks list -g dev-aks-env-out | ConvertFrom-Json

az aks nodepool update --update-cluster-autoscaler --min-count 2 --max-count 4 -g dev-aks-env-out --cluster-name $aks.name -n $aks.agentPoolProfiles.name[1]
```

Now rerun the command and we should see the AKS drift present in Terramate cloud.

```bash
terramate run --sync-drift-status --terraform-plan-file="drift.tfplan" --continue-on-error -- terraform plan -detailed-exitcode -out="drift.tfplan"
```

To resolve only stacks with drift, we can run a new command:

```bash
terramate run --status=drifted --sync-deployment -- terraform apply drift.tfplan
```

Now that we have this basic setup done, we can automate the process through GitHub Actions.

What we need to do:

* Update the repository with an OIDC config for Azure (use [this module](https://registry.terraform.io/modules/ned1313/github_oidc/azuread/latest) for creating a federated identity if you need one)
  `gh secret set AZURE_CLIENT_ID --body`
  `gh secret set AZURE_TENANT_ID --body`
  `gh secret set AZURE_SUBSCRIPTION_ID --body`

Now we can automate the PR and merge for the stack.
