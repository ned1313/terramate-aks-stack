# Onboarding to Terramate Cloud

## Commands to run

Create the stacks for Terramate

```bash
terramate create --all-terraform
```

Create a `terraform.tm.hcl

```bash
git add .
git commit -m "Terramate onboarding"
git push
```

```
terramate run --sync-drift-status --terraform-plan-file=drift.tfplan --continue-on-error -- terraform plan -detailed-exitcode -out drift.tfplan
```

