resource "aws_vpc" "this" {
  cidr_block = var.cidr_block

  enable_dns_support   = var.enable_dns_support
  enable_dns_hostnames = var.enable_dns_hostnames

  tags = local.cluster_tags

}

resource "aws_subnet" "public" {
  count             = var.public_subnet_count
  availability_zone = data.aws_availability_zones.available.names[count.index]
  cidr_block        = cidrsubnet(var.cidr_block, 6, count.index)
  vpc_id            = aws_vpc.this.id

  tags = local.cluster_tags

}

resource "aws_subnet" "private" {
  count             = var.private_subnet_count
  availability_zone = data.aws_availability_zones.available.names[count.index]
  cidr_block        = cidrsubnet(var.cidr_block, 6, count.index + var.public_subnet_count)
  vpc_id            = aws_vpc.this.id

  tags = local.cluster_tags

}

resource "aws_internet_gateway" "this" {
  vpc_id = aws_vpc.this.id
  tags = {
    Name = var.name
  }

}


resource "aws_eip" "public" {
  count = var.public_subnet_count
  vpc   = true
  tags = {
    Name = var.name
  }

}

resource "aws_nat_gateway" "public" {
  count         = var.public_subnet_count
  subnet_id     = aws_subnet.public[count.index].id
  allocation_id = aws_eip.public[count.index].id

  tags = {
    Name = var.name
  }
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.this.id
  count  = var.public_subnet_count
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.this.id
  }

  tags = {
    Name = var.name
  }

}

resource "aws_route_table_association" "public" {
  count          = var.public_subnet_count
  subnet_id      = aws_subnet.public[count.index].id
  route_table_id = aws_route_table.public[count.index].id
}


resource "aws_route_table" "private" {
  vpc_id = aws_vpc.this.id
  count  = var.private_subnet_count

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.public[count.index].id
  }
  tags = {
    Name = var.name
  }

}

resource "aws_route_table_association" "private" {
  count          = var.private_subnet_count
  subnet_id      = aws_subnet.private[count.index].id
  route_table_id = aws_route_table.private[count.index].id
}
