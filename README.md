# AWS VPC Endpoints Terraform module

Terraform module which creates VPC endpoints for AWS SSM in an existing VPC on AWS.

## Terraform versions

Terraform 0.12 and newer. 

## Usage

```hcl
module "vpce" {
  source          = "/path/to/module/terraform-aws-vpce-ssm"
  name            = var.name
  region          = var.region
  vpc_id          = var.vpc
  private_subnets = var.private_subnets
  
  tags = {
    Environment = var.environment,
    Project     = var.project
  }
}
```

## Requirements

| Name | Version |
|------|---------|
| terraform | >= 0.12.6 |
| aws | >= 2.65 |

## Providers

| Name | Version |
|------|---------|
| aws | >= 2.65 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| enable\_ssm\_related\_endpoints | Should be true if you want to provision VPC endpoints used for AWS SSM | `bool` | `false` | no |
| name | Name to be used on all resources as prefix | `string` | n/a | yes |
| private\_subnets | A list of private subnets inside the VPC | `list(string)` | `[]` | no |
| public\_subnets | A list of public subnets inside the VPC | `list(string)` | `[]` | no |
| region | Name of region | `string` | n/a | yes |
| tags | A map of tags to add to all resources | `map(string)` | `{}` | no |
| vpc\_id | String of vpc id | `string` | n/a | yes |

## Outputs

No output.

## Authors

Module managed by [Marcel Emmert](https://github.com/echomike80).

## License

Apache 2 Licensed. See LICENSE for full details.
