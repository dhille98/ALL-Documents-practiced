variable "region" {
  type        = string
  description = "aws regions"
  default     = "ap-south-1"
}
variable "cidr_block" {
  type        = string
  description = "cidir block"
  default     = "10.200.0.0/16"

}

variable "subnet_names" {
  type        = list(string)
  description = "add the subnetes"
  default     = ["public-subnet-1", "public_subnet-2", "app-subnet-1", "app-subnet-2", ]

}

variable "azs" {
  type        = list(string)
  description = "add the az"
  default     = ["ap-south-1a", "ap-south-1b", "ap-south-1c"]

}
variable "ssh_key_name" {
  description = "The name of the SSH key pair to use for instances"
  type        = string
  default     = "Docker"
}