# Specify the AWS provider and region
provider "aws" {
  region = "eu-north-1"  # Change this to your desired AWS region
}

# Create an AWS EC2 instance
resource "aws_instance" "example" {
  ami           = "ami-040d60c831d02d41c"  # Replace with your desired AMI ID
  instance_type = "t3.micro"  # Change this to the instance type you want
  key_name      = "shaked"
  vpc_security_group_ids = [
    "sg-0ecb2905c7930c2d3"  # Replace with the ID of your security group
  ]

  tags = {
    Name = "MyInstance"  # Replace with a name for your instance
  }

  connection {
    type        = "ssh"
    user        = "ec2-user"  # Change this to the appropriate user for your AMI
    private_key = file("/home/shaked/.ssh/shaked.pem")  # Replace with the path to your private key file
    host        = aws_instance.example.public_dns  # Use public DNS name (FQDN) of the instance
  }

  provisioner "remote-exec" {
    inline = [
      "sudo yum update -y",   # For Amazon Linux or CentOS
      "sudo yum install -y git",
      "sudo yum install -y docker",
      "sudo systemctl start docker",
      "sudo systemctl enable docker",
      "sudo yum install -y python3-pip",  # Install pip for Python 3
      "pip3 install docker-compose",  # Install Docker Compose using pip3
      "sudo usermod -aG docker ec2-user",  # Add ec2-user to the docker group
      "sudo systemctl restart docker",  # Restart Docker to apply changes
      "git clone https://github.com/shaked0703/flask.git /home/ec2-user/flask",  # Clone the repository
    ]
  }
}


# Run Docker Compose on the EC2 instance
resource "null_resource" "run_docker_compose" {
  depends_on = [aws_instance.example]

  connection {
    # Reusing the same connection block as the EC2 instance
    type        = "ssh"
    user        = "ec2-user"
    private_key = file("/home/shaked/.ssh/shaked.pem")
    host        = aws_instance.example.public_ip
  }

  provisioner "remote-exec" {
    inline = [
      "cd /home/ec2-user/flask",  # Navigate to the Flask app directory
      "docker-compose up -d",  # Run Docker Compose to start the Flask app
    ]
  }
}
