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
  framework = "other" # Informa à Vercel que é um site estático simples, sem frameworks.
}

# 2. Cria o deploy (a publicação) do site dentro do projeto
# Este recurso pega os arquivos locais e os envia para a Vercel.
resource "vercel_deployment" "production" {
  project_id = vercel_project.landing_page.id

  # Aponta para a pasta onde a pipeline extraiu os arquivos da imagem Docker.
  # O Terraform está na pasta 'infra', então '../site-content' significa
  # "volte um diretório e entre em 'site-content'".
  files       = fileset("../site-content", "**")
  path_prefix = "../site-content"

  # Bloco especial que força o Terraform a criar um novo deploy
  # sempre que o conteúdo dos arquivos na pasta mudar. Essencial!
  lifecycle {
    replace_triggered_by = [
      fileset("../site-content", "**"),
    ]
  }

  # Define que este deploy deve ser o de "produção", ou seja,
  # ele será o que aparecerá na URL principal do seu projeto.
  production = true
}

# 3. Define uma saída (output) para mostrar a URL final
# Isso é útil para ver o resultado no final da execução da pipeline.
output "website_url" {
  description = "A URL final do site publicado na Vercel."
  value       = "https://${vercel_project.landing_page.name}.vercel.app"
}