// # VPC
// output "vpc_id" {
//   description = "The ID of the VPC"
//   value       = module.vpc.vpc_id
// }

// # CIDR blocks
// output "vpc_cidr_block" {
//   description = "The CIDR block of the VPC"
//   value       = module.vpc.vpc_cidr_block
// }

// //output "vpc_ipv6_cidr_block" {
// //  description = "The IPv6 CIDR block"
// //  value       = ["${module.vpc.vpc_ipv6_cidr_block}"]
// //}

// # Subnets
// output "private_subnets" {
//   description = "List of IDs of private subnets"
//   value       = module.vpc.private_subnets
// }

// output "public_subnets" {
//   description = "List of IDs of public subnets"
//   value       = module.vpc.public_subnets
// }

// # NAT gateways
// output "nat_public_ips" {
//   description = "List of public Elastic IPs created for AWS NAT Gateway"
//   value       = module.vpc.nat_public_ips
// }

// # AZs
// output "azs" {
//   description = "A list of availability zones spefified as argument to this module"
//   value       = module.vpc.azs
// }

// output "public_subnets" {
//    // value = [aws_subnet.public_01,aws_subnet.public_02]
//     value = [aws_subnet.public_subnets]
// }



// output "custom_vpc" {
//     value = aws_vpc.farid_vpc
// }

// output "public_subnets" {
//     value = [aws_subnet.public_01,aws_subnet.public_02]
//    // value =  aws_subnet.subnets.id
// }
// output "private_subnets" {
//     value = [aws_subnet.private_01,aws_subnet.private_02]
//     //value = aws_subnet.private_subnets
// }
// output "custom_vpc" {
//     value = aws_vpc.farid_vpc
// }

// #subnet public
// data "aws_subnet_ids" "vpc_public_subnets_ids" {
//   vpc_id = aws_vpc.farid_vpc.id
//   filter {
//     name   = "tag:Name"
//     values = ["farid-public-*"]
//   }
// }

// output "list_subnet_public" {
//   value = data.aws_subnet_ids.vpc_public_subnets_ids
// }



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