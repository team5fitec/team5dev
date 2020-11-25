// variable "region_name" {
//   description = "ap-southeast-1"
// }
#VPC CIDR
variable "vpc_cidr" {
    description = "The vpc CIDR"
    default     = "55.0.0.0/16"
}
#SUBNETS CIDRs
variable "subnet_private_1_cidr" {
    default     = "55.0.1.0/24"
}
variable "subnet_private_2_cidr" {
    default     = "55.0.2.0/24"
}
variable "subnet_public_1_cidr" {
    default     = "55.0.3.0/24"
}
variable "subnet_public_2_cidr" {
    default     = "55.0.4.0/24"
}
#Name TAGs Subnets
variable "subnet_private_1_tag" {
    default     = "farid-private-sub-01"
}
variable "subnet_private_2_tag" {
    default     = "farid-private-sub-02"
}
variable "subnet_public_1_tag" {
    default     = "farid-public-sub-01"
}
variable "subnet_public_2_tag" {
    default     = "farid-public-sub-02"
}