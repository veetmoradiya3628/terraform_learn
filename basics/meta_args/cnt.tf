# Create 3 identical web server instances
resource "aws_instance" "web" {
  # count determines the total number of resources to create
  count = 3

  ami           = "ami-12345678"
  instance_type = "t2.micro"

  tags = {
    # Use count.index to make each resource unique
    Name = "web-server-${count.index}"
  }
}

# Conditional creation: create resource only if variable is true
resource "aws_instance" "optional" {
  count = var.enable_optional_resource ? 1 : 0

  ami           = "ami-12345678"
  instance_type = "t2.micro"
}   