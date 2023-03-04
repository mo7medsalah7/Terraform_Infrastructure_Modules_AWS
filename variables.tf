variable "aws_region" {
  default = "us-east-2"
}
variable "vpc_id" {
  default = "vpc-0e32209aa932597cc"
}

#map of maps for create subnets
variable "public_subnet_mapping" {
  type = map(any)
  default = {
    subnet-public = {
      name = "Public_Subnet"
      az   = "us-east-2a"
      cidr = "10.200.30.0/24"

    }
  }
}

#map of maps for create subnets
variable "private_subnet_mapping" {
  type = map(any)
  default = {
    subnet-private-1 = {
      name = "Private_Subnet_1"
      az   = "us-east-2b"
      cidr = "10.200.40.0/24"
    }
    subnet-private-2 = {
      name = "Private_Subnet_2"
      az   = "us-east-2a"
      cidr = "10.200.50.0/24"
    }
  }
}

variable "subnet_count" {
  description = "Count The Subnets"
  type        = map(number)
  default = {
    public  = 2
    private = 1
  }
}


variable "db_username" {
  description = "Database User Name"
  type        = string
  sensitive   = true
}

variable "db_password" {
  description = "Database Password"
  type        = string
  sensitive   = true
}
