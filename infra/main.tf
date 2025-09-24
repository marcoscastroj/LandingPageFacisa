# Define uma variável para o nome do projeto, facilitando a customização
variable "project_name" {
  description = "O nome que o projeto terá na Vercel (deve ser único na sua conta)."
  type        = string
  default     = "landingpage-facisa" # Você pode mudar este nome se quiser
}

# 1. Cria um novo projeto na Vercel
# Pense nisso como a "casca" ou o "contêiner" para o seu site.
resource "vercel_project" "landing_page" {
  name      = var.project_name
}

# 2. Lê os arquivos do diretório gerado pela pipeline
# Esse data source converte os arquivos em um mapa de strings compatível com a Vercel
data "vercel_project_directory" "site" {
  path = "../site-content"
}

# 3. Cria o deploy (a publicação) do site dentro do projeto
# Este recurso pega os arquivos locais e os envia para a Vercel.
resource "vercel_deployment" "production" {
  project_id  = vercel_project.landing_page.id
  files       = data.vercel_project_directory.site.files
  path_prefix = "../site-content"

  production = true
}

# 4. Define uma saída (output) para mostrar a URL final
# Isso é útil para ver o resultado no final da execução da pipeline.
output "website_url" {
  description = "A URL final do site publicado na Vercel."
  value       = vercel_deployment.production.url
}