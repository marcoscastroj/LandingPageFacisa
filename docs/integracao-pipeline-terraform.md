# Integração da Pipeline CI/CD com Terraform

Este documento detalha como a pipeline de integração contínua (CI/CD) está integrada ao Terraform para provisionamento de infraestrutura na Google Cloud Platform (GCP), explicando também os arquivos `main.tf` e `provider.tf` e cada etapa do deploy.

## Visão Geral

A pipeline CI/CD automatiza o processo de build, teste e deploy da aplicação. O Terraform é utilizado para gerenciar e provisionar a infraestrutura necessária para o ambiente de hospedagem.

## Estrutura dos Arquivos Terraform

- **provider.tf**: Define o provedor do Terraform, neste caso o Google Cloud (`hashicorp/google`). Permite que o Terraform se comunique com a GCP. A configuração do projeto e região é feita dinamicamente pela pipeline, usando variáveis e segredos.

- **main.tf**:
  - Declara variáveis como `project_id` (ID do projeto GCP) e `bucket_name` (nome do bucket).
  - Cria um bucket no Google Cloud Storage para hospedar o site estático.
  - Configura o bucket para servir o arquivo `index.html` como página principal.
  - Libera acesso público ao bucket para que qualquer usuário possa acessar o site.
  - Define uma saída (`output`) com a URL pública do site provisionado.

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
  - Constrói e publica a imagem Docker da aplicação, versionando com o hash do commit.
4. **Job de Deploy no GCP**:
  - Realiza checkout do código.
  - Autentica na Google Cloud usando uma chave de serviço.
  - Instala o Terraform.
  - Configura o projeto GCP via `gcloud` CLI.
  - Executa `terraform init` para inicializar o diretório de infraestrutura.
  - Executa `terraform apply` passando o ID do projeto como variável, provisionando o bucket e permissões.
  - Sincroniza os arquivos do projeto com o bucket GCS usando `gsutil rsync`, excluindo pastas desnecessárias.
  - Obtém a URL pública do site gerada pelo Terraform e a disponibiliza como output.

## Resumo dos Comandos Terraform na Pipeline
- `terraform -chdir=infra init`: Inicializa o Terraform na pasta `infra`.
- `terraform -chdir=infra apply -auto-approve -var="project_id=..."`: Aplica as mudanças, criando/atualizando recursos na GCP.
- `terraform -chdir=infra output -raw website_url`: Obtém a URL pública do site provisionado.


## Recomendações
- Sempre revisar o plano (`terraform plan`) antes de aplicar mudanças.
- Manter os arquivos Terraform atualizados conforme a evolução da aplicação.

- Utilizar nomes de bucket únicos para evitar conflitos.

---

Consulte o arquivo `ci.yml` para detalhes sobre os jobs e etapas da pipeline.