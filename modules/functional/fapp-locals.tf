locals {
    prefix = "fun"
    name = "${local.prefix}-${module.azure_region.location_short}-${var.environment}-${var.main_project}-${var.sub_project}"
}
