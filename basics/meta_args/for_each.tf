# Define a map of subnet configurations
variable "subnets" {
  type = map(object({
    cidr_block        = string
    availability_zone = string
  }))
  default = {
    "public-1" = {
      cidr_block        = "10.0.1.0/24"
      availability_zone = "us-east-1a"
    }
    "public-2" = {
      cidr_block        = "10.0.2.0/24"
      availability_zone = "us-east-1b"
    }
  }
}

# Create subnets based on map keys
resource "aws_subnet" "main" {
  # for_each iterates over the map; each key becomes the resource's index in state
  for_each = var.subnets

  vpc_id            = aws_vpc.main.id
  cidr_block        = each.value.cidr_block
  availability_zone = each.value.availability_zone

  tags = {
    # Use each.key for the resource name
    Name = "subnet-${each.key}"
  }
}   