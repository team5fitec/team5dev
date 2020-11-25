

#subnet public et privé
data "aws_subnet_ids" "vpc_public_subnets_ids" {
    vpc_id = aws_vpc.farid_vpc.id
    filter {
        name   = "tag:Name"
        values = ["farid-public-sub-*"]
    }
}
data "aws_subnet_ids" "vpc_private_subnets_ids" {
    vpc_id = aws_vpc.farid_vpc.id
    filter {
        name   = "tag:Name"
        values = ["farid-private-sub-*"]
    }
}

output "list_subnet_public_ids" {
    value = data.aws_subnet_ids.vpc_public_subnets_ids
}

output "list_subnet_private_ids" {
    value = data.aws_subnet_ids.vpc_private_subnets_ids
}

#test###########
data "aws_subnet" "vpc_private_subnets" {
    vpc_id = aws_vpc.farid_vpc.id
    filter {
        name   = "tag:Name"
        values = ["farid-private-sub-01"]
    }
}

output "list_subnet_private_cidr" {
    value = data.aws_subnet.vpc_private_subnets.cidr_block
}###############