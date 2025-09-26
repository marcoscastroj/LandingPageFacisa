# Integração da Pipeline CI/CD com Terraform

Este documento detalha como a pipeline de integração contínua (CI/CD) está integrada ao Terraform para provisionamento e deploy do site na Vercel, explicando também os arquivos `main.tf` e `provider.tf` e cada etapa do deploy.

## Visão Geral

A pipeline CI/CD automatiza o processo de build, teste e deploy da aplicação. O Terraform é utilizado para gerenciar e provisionar o deploy do site estático diretamente na Vercel.

## Estrutura dos Arquivos Terraform

- **provider.tf**: Define o provedor do Terraform, neste caso o Vercel (`vercel/vercel`). Permite que o Terraform se comunique com a plataforma Vercel para criar projetos e realizar deploys.

- **main.tf**:
  - Declara a variável `project_name` para definir o nome do projeto na Vercel.
  - Cria o projeto na Vercel com o recurso `vercel_project`.
  - Lê os arquivos do diretório gerado pela pipeline (`site-content`) usando o data source `vercel_project_directory`.
  - Realiza o deploy do site com o recurso `vercel_deployment`, enviando os arquivos para produção.
  - Define uma saída (`output`) com a URL final do site publicado na Vercel.

## Fluxo de Execução da Pipeline

1. **Disparo da Pipeline**: O processo inicia automaticamente em cada push na branch principal ou manualmente.
2. **Job de Testes**:
  - Realiza checkout do código.
  - Configura o Node.js.
  - Instala dependências (`npm install`).
  - Executa testes (`npm test`).
3. **Job de Build e Push Docker**:
  - Realiza checkout do código.
  - Faz login no Docker Hub usando segredos.
  - Constrói e publica a imagem Docker da aplicação, versionando com o número do run.
4. **Job de Deploy na Vercel**:
  - Realiza checkout do código.
  - Faz login no Docker Hub para puxar a imagem gerada.
  - Puxa a imagem Docker e extrai o conteúdo estático do site para a pasta `site-content`.
  - Instala o Terraform.
  - Executa `terraform init` para inicializar o diretório de infraestrutura.
  - Executa `terraform apply` para criar o projeto e realizar o deploy na Vercel, usando o token de API.
  - Obtém a URL final do site publicado na Vercel e disponibiliza como output.

## Resumo dos Comandos Terraform na Pipeline
- `terraform -chdir=infra init`: Inicializa o Terraform na pasta `infra`.
- `terraform -chdir=infra apply -auto-approve`: Cria o projeto e realiza o deploy do site na Vercel.
- `terraform -chdir=infra output -raw website_url`: Obtém a URL final do site publicado na Vercel.


## Recomendações
- Sempre revisar o plano (`terraform plan`) antes de aplicar mudanças.
- Manter os arquivos Terraform atualizados conforme a evolução da aplicação.

- Utilizar nomes de projeto únicos na Vercel para evitar conflitos.

---

Consulte o arquivo `ci.yml` para detalhes sobre os jobs e etapas da pipeline.