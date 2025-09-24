terraform {
  required_providers {
    vercel = {
      source  = "vercel/vercel"
      version = "1.0.0" # Versão específica para consistência
    }
  }
}

# O token da API será passado por variável de ambiente na pipeline
provider "vercel" {}