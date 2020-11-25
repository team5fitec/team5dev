provider "aws" {
    region = "ap-southeast-1"
}

# creation VPV
resource "aws_vpc" "farid_vpc" {
    cidr_block           = var.vpc_cidr
    instance_tenancy     = "default"
    enable_dns_support   = true
    enable_dns_hostnames = true
    tags = {
        Name = "farid-terraform"
    }
}

#Activation DHCP
resource "aws_vpc_dhcp_options" "dns_options" {
    domain_name_servers = ["8.8.8.8", "8.8.4.4"]
}
resource "aws_vpc_dhcp_options_association" "dns_resolver" {
    vpc_id          = aws_vpc.farid_vpc.id
    dhcp_options_id = aws_vpc_dhcp_options.dns_options.id
}

#Default Security group
resource "aws_security_group" "farid_vpc_default_sg" {
    name        = "farid_vpc_default_sg"
    description = "Allow ALL inbound traffic"
    vpc_id      = aws_vpc.farid_vpc.id
    ingress {
        description = "Allow all Traffic"
        from_port   = 0
        to_port     = 65535
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    } 
    egress {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
    tags = {
        Name = "farid-vpc-default-sg"
    }
}

#Public NACL
resource "aws_network_acl" "farid_public_acl" {
    vpc_id = aws_vpc.farid_vpc.id
    subnet_ids= [aws_subnet.public_01.id ,aws_subnet.public_02.id]
    egress {
    protocol   = "tcp"
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 65535
    }
    ingress {
        protocol   = "tcp"
        rule_no    = 100
        action     = "allow"
        cidr_block = "0.0.0.0/0"
        from_port  = 0
        to_port    = 65535
        }
    tags = {
        Name = "farid_public_acl"
    }
}

#Private NACL
resource "aws_default_network_acl" "farid_private_acl" {
    default_network_acl_id = aws_vpc.farid_vpc.default_network_acl_id
    subnet_ids= [aws_subnet.private_01.id ,aws_subnet.private_02.id]
    egress {
    protocol   = "tcp"
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 65535
    }
    ingress {
        protocol   = "tcp"
        rule_no    = 100
        action     = "allow"
        cidr_block = "0.0.0.0/0"
        from_port  = 0
        to_port    = 65535
        }
    tags = {
        Name = "farid_private_acl"
    }
}

#Private Route Table
resource "aws_default_route_table" "farid_private_route" {
    default_route_table_id = aws_vpc.farid_vpc.default_route_table_id
    route {
        cidr_block     = "0.0.0.0/0"
        nat_gateway_id = aws_nat_gateway.farid_ngw.id
    }
    tags = {
        Name = "farid-private-route"
    }
}
#Public Route Table
resource "aws_route_table" "farid_public_route" {
    vpc_id = aws_vpc.farid_vpc.id
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.farid_ig.id
    }
    tags = {
        Name = "farid-public-route"
    }
}

#NAT GATEWAY (Public 01)
resource "aws_nat_gateway" "farid_ngw" {
    allocation_id = aws_eip.farid_eip_ngw.id
    subnet_id     = aws_subnet.public_01.id
    tags = {
        Name = "farid-nat-gateway"
    }
}

resource "aws_eip" "farid_eip_ngw" {
    vpc = true
}


#INTERNET GATEWAY
resource "aws_internet_gateway" "farid_ig" {
    vpc_id = aws_vpc.farid_vpc.id
    tags = {
        Name = "farid-vpc-ig"
    }
}