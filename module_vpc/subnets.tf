#SUBNETS PRIVATE & PUBLIC
resource "aws_subnet" "private_01" {
    vpc_id            = aws_vpc.farid_vpc.id
    //cidr_block        = "55.0.1.0/24"
    cidr_block          = var.subnet_private_1_cidr
    availability_zone = "ap-southeast-1a"
    tags = {
            Name = var.subnet_private_1_tag
    }
}
resource "aws_subnet" "private_02" {
    vpc_id            = aws_vpc.farid_vpc.id
    //cidr_block        = "55.0.2.0/24"
    cidr_block          = var.subnet_private_2_cidr
    availability_zone = "ap-southeast-1b"
    tags = {
        Name = var.subnet_private_2_tag
    }
}
resource "aws_subnet" "public_01" {
    vpc_id                  = aws_vpc.farid_vpc.id
    //cidr_block              = "55.0.3.0/24"
    cidr_block              = var.subnet_public_1_cidr
    availability_zone       = "ap-southeast-1a"
    map_public_ip_on_launch = true
    tags = {
        Name = var.subnet_public_1_tag
    }
}
resource "aws_subnet" "public_02" {
    vpc_id                  = aws_vpc.farid_vpc.id
    //cidr_block              = "55.0.4.0/24"
    cidr_block              = var.subnet_public_2_cidr
    availability_zone       = "ap-southeast-1b"
    map_public_ip_on_launch = true
    tags = {
        Name = var.subnet_public_2_tag
    }
}

#Association with Route tables
resource "aws_route_table_association" "farid_a" {
    subnet_id      = aws_subnet.private_01.id
    route_table_id = aws_default_route_table.farid_private_route.id
}
resource "aws_route_table_association" "farid_b" {
    subnet_id      = aws_subnet.private_02.id
    route_table_id = aws_default_route_table.farid_private_route.id
}
resource "aws_route_table_association" "farid_c" {
    subnet_id      = aws_subnet.public_01.id
    route_table_id = aws_route_table.farid_public_route.id
}
resource "aws_route_table_association" "farid_d" {
    subnet_id      = aws_subnet.public_02.id
    route_table_id = aws_route_table.farid_public_route.id
}