################################################################################
# Subnets — duas públicas e duas privadas, uma por zona
################################################################################
resource "aws_subnet" "public" {
  count                   = length(var.azs)
  vpc_id                  = aws_vpc.this.id
  cidr_block              = cidrsubnet(local.vpc_cidr, 8, count.index)
  availability_zone       = var.azs[count.index]
  map_public_ip_on_launch = true

  tags = {
    Name     = "${local.prefixo}-subnet-public-${count.index + 1}"
    tier     = "public"
    resource = "network"
  }
}

resource "aws_subnet" "private" {
  count             = length(var.azs)
  vpc_id            = aws_vpc.this.id
  cidr_block        = cidrsubnet(local.vpc_cidr, 8, count.index + 10)
  availability_zone = var.azs[count.index]

  tags = {
    Name     = "${local.prefixo}-subnet-private-${count.index + 1}"
    tier     = "private"
    resource = "network"
  }
}
