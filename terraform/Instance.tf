resource "aws_instance" "web" {
  ami                    = data.aws_ami.amiID.id
  instance_type          = "t3.micro"
  key_name               = "dove-key"
  vpc_security_group_ids = [aws_security_group.dove-sg.id]
  availability_zone      = "us-east-1a"

  tags = {
    Name    = "Dove-web"
    Project = "Dove"
  }

  provisioner "file" {
    source      = "web.sh"
    destination = "/tmp/web.sh"
  }

  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/web.sh",
      "sudo /tmp/web.sh"
    ]
  }

  provisioner "local-exec" {
    command = "echo 'Private IP: ${self.private_ip}, Public IP: ${self.public_ip}' >> instance_info.txt"
  }

  connection {
    type        = "ssh"
    user        = var.webuser
    private_key = file("dove-key")
    host        = self.public_ip
  }

}

resource "aws_ec2_instance_state" "web-state" {
  instance_id = aws_instance.web.id
  state       = "running"
}

output "WebPublicIP" {
  description = "value of the public IP of the web instance"
  value       = aws_instance.web.public_ip
}

output "WebPrivateIP" {
  description = "value of the private IP of the web instance"
  value       = aws_instance.web.private_ip
}