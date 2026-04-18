output "frontend_public_ip" {
  value = aws_eip.frontend.public_ip
}

output "backend_public_ip" {
  value = aws_eip.backend.public_ip
}

output "backend_private_ip" {
  value = aws_network_interface.backend.private_ip
}
