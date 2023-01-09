# Key Vault Access Policy

## Example Settings
```yaml
keyvault_access_policies:
  policy1:
    keyvault_key: "kv1"
    enabled: true
    object_id_policy: true
    object_id: "SUBSCRIPTION_ID"
    key_permissions: ["get"]
    secret_permissions: ["get"]
    storage_permissions: ["get"]
```

## Example Module Reference

```yaml
module "keyvault_access_policies" {
  depends_on = [module.keyvault]
  source     = "[[git_ssh_url]]/[[devOps_org_name]]/[[devOps_project_name]]/[[devOps_repo_name]]//modules/security/keyvault_access_policies"
  count      = try(local.settings.keyvault_access_policies, null) == null ? 0 : 1

  keyvaults       = module.keyvault
  tenant_id       = var.tenant_id
  subscription_id = var.subscription_id
  access_policies = try(local.settings.keyvault_access_policies, null)
}
```

<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_logged_in_user"></a> [logged\_in\_user](#module\_logged\_in\_user) | ./access_policy | n/a |
| <a name="module_object_id"></a> [object\_id](#module\_object\_id) | ./access_policy | n/a |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_access_policies"></a> [access\_policies](#input\_access\_policies) | Access Policy map object | `any` | n/a | yes |
| <a name="input_keyvault_id"></a> [keyvault\_id](#input\_keyvault\_id) | Key Vault resource ID used if ommitting var.keyvault\_key and var.keyvaults | `string` | `null` | no |
| <a name="input_keyvault_key"></a> [keyvault\_key](#input\_keyvault\_key) | Key Vault map key used to retrieve resource from var.keyvaults if omitting var.keyvault\_id | `string` | `null` | no |
| <a name="input_keyvaults"></a> [keyvaults](#input\_keyvaults) | Key Vault module object used if omitting var.keyvault\_id | `map` | `{}` | no |
| <a name="input_object_id"></a> [object\_id](#input\_object\_id) | Object ID used to provide access to a specific Azure resource | `string` | `null` | no |
| <a name="input_subscription_id"></a> [subscription\_id](#input\_subscription\_id) | The Azure Subscription ID used to explicitly provide access at the subscription level | `string` | `null` | no |
| <a name="input_tenant_id"></a> [tenant\_id](#input\_tenant\_id) | The Azure Active Directory tenant ID that should be used for authenticating requests to the key vault | `string` | `null` | no |

## Outputs

No outputs.
<!-- END_TF_DOCS -->