#################
# Security Groups
#################
resource "aws_security_group" "vpc-endpoints" {
  count       = var.enable_ssm_related_endpoints ? 1 : 0
  name        = "${var.name}-vpc-endpoints"
  description = "Rules for VPC endpoints"
  vpc_id      = var.vpc_id

  tags = merge(
    {
      "Name" = format("%s-vpc-endpoints", var.name)
    },
    var.tags,
  )
}

resource "aws_security_group_rule" "in-https-vpc-endpoints" {
  count             = var.enable_ssm_related_endpoints ? 1 : 0
  type              = "ingress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  cidr_blocks       = ["10.0.0.0/8"]
  security_group_id = aws_security_group.vpc-endpoints[count.index].id
}

###############
# VPC Endpoints
###############

resource "aws_vpc_endpoint" "vpc_endpoint_ssm_public" {
  count             = var.enable_ssm_related_endpoints && length(var.public_subnets) > 0 ? 1 : 0
  vpc_id            = var.vpc_id
  service_name      = "com.amazonaws.${var.region}.ssm"
  vpc_endpoint_type = "Interface"

  security_group_ids = [
    aws_security_group.vpc-endpoints[count.index].id,
  ]

  private_dns_enabled = true

  tags = merge(
    {
      "Name" = format("%s-ssm-public", var.name)
    },
    var.tags,
  )
}

resource "aws_vpc_endpoint" "vpc_endpoint_ssmmessages_public" {
  count             = var.enable_ssm_related_endpoints && length(var.public_subnets) > 0 ? 1 : 0
  vpc_id            = var.vpc_id
  service_name      = "com.amazonaws.${var.region}.ssmmessages"
  vpc_endpoint_type = "Interface"

  security_group_ids = [
    aws_security_group.vpc-endpoints[count.index].id,
  ]

  private_dns_enabled = true

  tags = merge(
    {
      "Name" = format("%s-ssmmessages-public", var.name)
    },
    var.tags,
  )
}

resource "aws_vpc_endpoint" "vpc_endpoint_ec2messages_public" {
  count             = var.enable_ssm_related_endpoints && length(var.public_subnets) > 0 ? 1 : 0
  vpc_id            = var.vpc_id
  service_name      = "com.amazonaws.${var.region}.ec2messages"
  vpc_endpoint_type = "Interface"

  security_group_ids = [
    aws_security_group.vpc-endpoints[count.index].id,
  ]

  private_dns_enabled = true

  tags = merge(
    {
      "Name" = format("%s-ec2messages-public", var.name)
    },
    var.tags,
  )
}

resource "aws_vpc_endpoint" "vpc_endpoint_ssm_private" {
  count             = var.enable_ssm_related_endpoints && length(var.private_subnets) > 0 ? 1 : 0
  vpc_id            = var.vpc_id
  service_name      = "com.amazonaws.${var.region}.ssm"
  vpc_endpoint_type = "Interface"

  security_group_ids = [
    aws_security_group.vpc-endpoints[count.index].id,
  ]

  private_dns_enabled = true

  tags = merge(
    {
      "Name" = format("%s-ssm-private", var.name)
    },
    var.tags,
  )
}

resource "aws_vpc_endpoint" "vpc_endpoint_ssmmessages_private" {
  count             = var.enable_ssm_related_endpoints && length(var.private_subnets) > 0 ? 1 : 0
  vpc_id            = var.vpc_id
  service_name      = "com.amazonaws.${var.region}.ssmmessages"
  vpc_endpoint_type = "Interface"

  security_group_ids = [
    aws_security_group.vpc-endpoints[count.index].id,
  ]

  private_dns_enabled = true

  tags = merge(
    {
      "Name" = format("%s-ssmmessages-private", var.name)
    },
    var.tags,
  )
}

resource "aws_vpc_endpoint" "vpc_endpoint_ec2messages_private" {
  count             = var.enable_ssm_related_endpoints && length(var.private_subnets) > 0 ? 1 : 0
  vpc_id            = var.vpc_id
  service_name      = "com.amazonaws.${var.region}.ec2messages"
  vpc_endpoint_type = "Interface"

  security_group_ids = [
    aws_security_group.vpc-endpoints[count.index].id,
  ]

  private_dns_enabled = true

  tags = merge(
    {
      "Name" = format("%s-ec2messages-private", var.name)
    },
    var.tags,
  )
}

#####################################
# VPC Endpoint <-> Subnet association
#####################################
# this takes some time! 2 - 5 minutes
resource "aws_vpc_endpoint_subnet_association" "vpc_endpoint_ssm_public" {
  count           = var.enable_ssm_related_endpoints && length(var.public_subnets) > 0 ? length(var.public_subnets) : 0
  vpc_endpoint_id = element(aws_vpc_endpoint.vpc_endpoint_ssm_public.*.id, count.index)
  subnet_id       = element(var.public_subnets, count.index)
}

resource "aws_vpc_endpoint_subnet_association" "vpc_endpoint_ssmmessages_public" {
  count           = var.enable_ssm_related_endpoints && length(var.public_subnets) > 0 ? length(var.public_subnets) : 0
  vpc_endpoint_id = element(aws_vpc_endpoint.vpc_endpoint_ssmmessages_public.*.id, count.index)
  subnet_id       = element(var.public_subnets, count.index)
}

resource "aws_vpc_endpoint_subnet_association" "vpc_endpoint_ec2messages_public" {
  count           = var.enable_ssm_related_endpoints && length(var.public_subnets) > 0 ? length(var.public_subnets) : 0
  vpc_endpoint_id = element(aws_vpc_endpoint.vpc_endpoint_ec2messages_public.*.id, count.index)
  subnet_id       = element(var.public_subnets, count.index)
}

resource "aws_vpc_endpoint_subnet_association" "vpc_endpoint_ssm_private" {
  count           = var.enable_ssm_related_endpoints && length(var.private_subnets) > 0 ? length(var.private_subnets) : 0
  vpc_endpoint_id = element(aws_vpc_endpoint.vpc_endpoint_ssm_private.*.id, count.index)
  subnet_id       = element(var.private_subnets, count.index)
}

resource "aws_vpc_endpoint_subnet_association" "vpc_endpoint_ssmmessages_private" {
  count           = var.enable_ssm_related_endpoints && length(var.private_subnets) > 0 ? length(var.private_subnets) : 0
  vpc_endpoint_id = element(aws_vpc_endpoint.vpc_endpoint_ssmmessages_private.*.id, count.index)
  subnet_id       = element(var.private_subnets, count.index)
}

resource "aws_vpc_endpoint_subnet_association" "vpc_endpoint_ec2messages_private" {
  count           = var.enable_ssm_related_endpoints && length(var.private_subnets) > 0 ? length(var.private_subnets) : 0
  vpc_endpoint_id = element(aws_vpc_endpoint.vpc_endpoint_ec2messages_private.*.id, count.index)
  subnet_id       = element(var.private_subnets, count.index)
}