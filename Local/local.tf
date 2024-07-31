terraform {
  required_providers {
    local = {
      source  = "hashicorp/local"
      version = "~> 2.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.4.0"
    }
  }
}

resource "local_file" "write" {
  filename        = "/home/sushi/Desktop/work/Linkedin/terraform/Local/file.txt"
  content         = var.content
  file_permission = "0700"
}

resource "random_pet" "my_pet" {
  prefix    = "Mrs"
  separator = "."
  length    = 1
}
