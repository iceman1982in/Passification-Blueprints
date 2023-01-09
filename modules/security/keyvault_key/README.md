<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_key_vault_key.key](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_key) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_global_settings"></a> [global\_settings](#input\_global\_settings) | Global settings object | `any` | n/a | yes |
| <a name="input_keyvault"></a> [keyvault](#input\_keyvault) | Keyvault module object | `any` | n/a | yes |
| <a name="input_settings"></a> [settings](#input\_settings) | Configuration settings object for the Keyvault Key resource | `any` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_id"></a> [id](#output\_id) | The ID of the Key Vault Key |
| <a name="output_name"></a> [name](#output\_name) | The Name of the Key Vault Key |
<!-- END_TF_DOCS -->