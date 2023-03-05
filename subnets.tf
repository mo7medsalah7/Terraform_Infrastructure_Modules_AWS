data "aws_vpc" "our_vpc" {
  id = var.vpc_id
}
# Public Subnet Creation
resource "aws_subnet" "public_subnet" {
  vpc_id   = data.aws_vpc.our_vpc.id
  for_each = var.public_subnet_mapping
  # Defining Availability Zones
  availability_zone = each.value["az"]


  # availability_zone = "us-east-2a"
  # cidr_block        = "10.200.0.0/24"

  # Defining Cidr Blocks
  cidr_block              = each.value["cidr"]
  map_public_ip_on_launch = true

  tags = {
    Name = "MoSalah-Public-Subnet"
  }
}

# Private Subnet Creation
resource "aws_subnet" "private_subnet" {
  vpc_id = data.aws_vpc.our_vpc.id

  for_each = var.private_subnet_mapping
  # Defining Availability Zones
  availability_zone = each.value["az"]
  # Defining Cidr Blocks
  cidr_block = each.value["cidr"]

  tags = {
    Name = "MoSalah-Private-subnet-${each.key}"
  }
}



# Public Route Table
resource "aws_route_table" "Public_Route_Table" {
  vpc_id = data.aws_vpc.our_vpc.id

  # IPv4
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "igw-01bd995ed435b1188	"
  }


  tags = {
    Name = "Public_Route_Table"
  }
}

# Associate The Public Routing Table
resource "aws_route_table_association" "public_associate" {
  # count = var.subnet_count.public

  # associate route table to the public subnet 


  for_each       = aws_subnet.public_subnet
  subnet_id      = each.value.id
  route_table_id = aws_route_table.Public_Route_Table.id
}


# Private Route Table
# resource "aws_route_table" "Private_Route_Table" {
#   vpc_id = data.aws_vpc.our_vpc.id

#   tags = {
#     Name = "Private_Route_Table"
#   }
# }

# # Associate The Private ROuting Table
# resource "aws_route_table_association" "private_associate" {
#   depends_on = [aws_subnet.public_subnets]

#   count = var.subnet_count.private

#   route_table_id = aws_route_table.Private_Route_Table.id
#   subnet_id      = aws_subnet.private_subnet.id

# }

# Creating RDS Subnet Group
resource "aws_db_subnet_group" "db_subnet_group" {
  name        = "rds subnet group_mosalah"
  description = "DB Subnet Group"

  subnet_ids = [for subnet in aws_subnet.private_subnet : subnet.id]
}
