# Specify the Terraform provider for Docker
terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 2.0"
    }
  }
}

# Configure the Docker provider
provider "docker" {}


# Define the PostgreSQL Docker image
resource "docker_image" "postgres_image" {
  name         = "postgres:latest"
  keep_locally = false
}

# Create a PostgreSQL Docker container
resource "docker_container" "postgres_container" {
  name  = "postgres_server"
  image = docker_image.postgres_image.name
  ports {
    internal = 5432
    external = 5432
  }

  # Set environment variables for the PostgreSQL database
 env = [
    "POSTGRES_USER=admin",
    "POSTGRES_PASSWORD=secret",
    "POSTGRES_DB=mydatabase"
  ]
}
