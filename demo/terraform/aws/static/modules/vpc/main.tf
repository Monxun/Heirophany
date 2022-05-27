data "aws_region" "current" {}

data "aws_availability_zones" "available" {
  state = "available"
}

resource "aws_vpc" "main" {
  count      = var.vpc_flag ? 1 : 0
  cidr_block = var.vpc_cidr
  tags = {
    Name = "aline-main-vpc"
  }
}

resource "aws_internet_gateway" "main" {
  count  = var.vpc_flag ? 1 : 0
  vpc_id = aws_vpc.main[0].id
}

# ////////////////////////////////////////////////////
# SUBNETS
# ////////////////////////////////////////////////////
resource "aws_subnet" "public" {
  # Create X amount of public subnets
  count = length(compact([for az in data.aws_availability_zones.available.names : az if var.vpc_flag]))
  
  vpc_id            = aws_vpc.main[0].id
  cidr_block        = "10.44.${count.index}.0/24"
  availability_zone = element(data.aws_availability_zones.available.names, count.index)
  tags = {
    Name        = "public-${element(data.aws_availability_zones.available.names, count.index)}"
    Environment = var.environment_name
  }
}

resource "aws_subnet" "private" {

  # Create X amount of private subnets
  count = length(compact([for az in data.aws_availability_zones.available.names : az if var.vpc_flag]))

  vpc_id            = aws_vpc.main[0].id
  cidr_block        = "10.44.${count.index + 20}.0/24"
  availability_zone = element(data.aws_availability_zones.available.names, count.index)
  tags = {
    Name        = "private-${element(data.aws_availability_zones.available.names, count.index)}"
    Environment = var.environment_name
  }
}

resource "aws_subnet" "rds" {
  count             = length(compact([for az in data.aws_availability_zones.available.names : az if var.vpc_flag && var.rds_flag]))
  vpc_id            = aws_vpc.main[0].id
  cidr_block        = "10.44.${count.index + 40}.0/24"
  availability_zone = element(data.aws_availability_zones.available.names, count.index)
  tags = {
    Name        = "rds-${element(data.aws_availability_zones.available.names, count.index)}"
    Environment = var.environment_name
  }
}

resource "aws_db_subnet_group" "default" {
  count       = var.vpc_flag && var.rds_flag ? 1 : 0
  name        = "${var.db_name}-subnet-group"
  description = "Aline RDS subnet group"
  subnet_ids  = aws_subnet.rds[*].id
}

# ////////////////////////////////////////////////////
# ROUTING TABLES
# ////////////////////////////////////////////////////

# PUBLIC ROUTE TABLES
resource "aws_route_table" "public" {
  count  = var.vpc_flag ? 1 : 0
  vpc_id = aws_vpc.main[0].id
}

resource "aws_route" "public" {
  count                  = var.vpc_flag ? 1 : 0
  route_table_id         = aws_route_table.public[count.index].id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.main[count.index].id
}

resource "aws_route_table_association" "public" {
  count          = length(aws_subnet.public[*].id)
  subnet_id      = element(aws_subnet.public[*].id, count.index)
  route_table_id = aws_route_table.public[0].id
}

# PRIVATE ROUTE TABLES
resource "aws_route_table" "private" {
  count  = length(aws_subnet.private[*].id)
  vpc_id = aws_vpc.main[0].id
}

resource "aws_route" "private" {
  count                  = length(aws_subnet.private[*].id)
  route_table_id         = element(aws_route_table.private[*].id, count.index)
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = element(aws_nat_gateway.main.*.id, count.index)
}

resource "aws_route_table_association" "private" {
  count          = length(aws_subnet.private[*].id)
  subnet_id      = element(aws_subnet.private[*].id, count.index)
  route_table_id = element(aws_route_table.private[*].id, count.index)
}

# ////////////////////////////////////////////////////
# NAT 
# ////////////////////////////////////////////////////
resource "aws_nat_gateway" "main" {
  count         = length(aws_subnet.private[*].id)
  allocation_id = element(aws_eip.nat[*].id, count.index)
  subnet_id     = element(aws_subnet.public[*].id, count.index)
  depends_on    = [aws_internet_gateway.main]
}

resource "aws_eip" "nat" {
  count = length(aws_subnet.private.*.id)
  vpc   = true
}