data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["099720109477"]

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }
}

resource "aws_eip" "frontend" {
  domain = "vpc"
  tags = {
    Name = "${var.application_name}-${var.environment}-frontend-eip"
  }
}

resource "aws_eip" "backend" {
  domain = "vpc"
  tags = {
    Name = "${var.application_name}-${var.environment}-backend-eip"
  }
}

resource "aws_network_interface" "frontend" {
  subnet_id         = var.subnet_id
  private_ips_count = 1

  tags = {
    Name = "${var.application_name}-${var.environment}-frontend-nic"
  }
}

resource "aws_network_interface" "backend" {
  subnet_id         = var.subnet_id
  private_ips_count = 1

  tags = {
    Name = "${var.application_name}-${var.environment}-backend-nic"
  }
}

resource "aws_eip_association" "frontend" {
  network_interface_id = aws_network_interface.frontend.id
  allocation_id        = aws_eip.frontend.id
}

resource "aws_eip_association" "backend" {
  network_interface_id = aws_network_interface.backend.id
  allocation_id        = aws_eip.backend.id
}

resource "aws_network_interface_sg_attachment" "frontend_sg_attachment" {
  security_group_id    = var.security_group_id
  network_interface_id = aws_network_interface.frontend.id
}

resource "aws_network_interface_sg_attachment" "backend_sg_attachment" {
  security_group_id    = var.security_group_id
  network_interface_id = aws_network_interface.backend.id
}

resource "aws_instance" "frontend" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = var.instance_type
  key_name      = var.ssh_key_name

  network_interface {
    network_interface_id = aws_network_interface.frontend.id
    device_index         = 0
  }

  tags = {
    Name = "${var.application_name}-${var.environment}-frontend-vm"
  }
}

resource "aws_instance" "backend" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = var.instance_type
  key_name      = var.ssh_key_name

  network_interface {
    network_interface_id = aws_network_interface.backend.id
    device_index         = 0
  }

  tags = {
    Name = "${var.application_name}-${var.environment}-backend-vm"
  }
}
