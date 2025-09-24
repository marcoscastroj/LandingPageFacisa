terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0"
    }
  }
}

provider "docker" {}

variable "image_name" {
  default = "landing-page"
}

resource "docker_image" "app" {
  name = "${var.image_name}:latest"
  build {
    context    = "../"
    dockerfile = "Dockerfile"
  }
}

resource "docker_container" "app" {
  name  = "landing-page"
  image = docker_image.app.name
  ports {
    internal = 80
    external = 8080
  }
}
