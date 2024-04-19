resource "aws_vpc" "demo" {
  cidr_block = "10.0.0.0/16"

 enable_dns_support   = true
  enable_dns_hostnames = true


  tags = {
    Name = "terraform-eks-demo-vpc"
  }
}

resource "aws_subnet" "demo" {
  count = 2

  availability_zone = data.aws_availability_zones.available.names[count.index]
  cidr_block        = "10.0.${count.index}.0/24"
  vpc_id            = aws_vpc.demo.id
  map_public_ip_on_launch = true

  tags = {
    Name = "terraform-eks-demo-subnet-${count.index}"
  }
}

resource "aws_internet_gateway" "demo" {
  vpc_id = aws_vpc.demo.id

  tags = {
    Name = "terraform-eks-demo-igw"
  }
}

resource "aws_route_table" "demo" {
  vpc_id = aws_vpc.demo.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.demo.id
  }
}

resource "aws_route_table_association" "demo" {
  count = 2

  subnet_id      = aws_subnet.demo.*.id[count.index]
  route_table_id = aws_route_table.demo.id
}

resource "aws_vpc_dhcp_options" "demo" {
  domain_name_servers  = ["AmazonProvidedDNS"]  # Use AmazonProvidedDNS for AWS-provided DNS resolution
}

# Associate the DHCP options set with your VPC
resource "aws_vpc_dhcp_options_association" "demo" {
  vpc_id          = aws_vpc.demo.id
  dhcp_options_id = aws_vpc_dhcp_options.demo.id
}

