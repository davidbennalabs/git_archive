# Define Local Values in Terraform
locals {
  owners              = var.business_divsion
  environment         = var.environment
  base_name           = "${var.business_divsion}-${var.environment}"
  resource_group_name = "${var.business_divsion}-${var.environment}-rg"
  vnet_name           = "${local.base_name}-vnet"
  #name = "${local.owners}-${local.environment}"
  common_tags = {
    owners      = local.owners
    environment = local.environment
  }
}
