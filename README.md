# Landing Page Equipe Facisa - README PROJETO JS

## Sobre o projeto 
- Landing page responsiva com o propósito de servir como um portfólio para os integrantes da equipe (Kaio Moreira e Miguel Farias). O projeto consiste em divulgação profissional dos integrantes contendo suas especialidades na área bem como casos de destaque.
- Projeto responsivo
- Deploy realizado no Vercel

## Seções
- Hero (nome da equipe, slogan)
- Sobre a equipe (descrição, foto, nome, posição)
- Skills/Stacks (tecnologias dominadas)
- Projetos/Trabalhos (cards com título, descrição e links)
- Contato (formulário e redes profissionais)


## Estrutura de Pastas
- `/assets` - arquivos estáticos (favicon, etc)
- `/css` - estilos
- `/js` - scripts
- `/img` - imagens 

---

<img width="1906" height="983" alt="image" src="https://github.com/user-attachments/assets/cb9d58d6-b460-460b-93b1-d6cf37dafd28" />


Desenvolvido por Kaio e Miguel. Obs ao professor Pierre: há integrantes além dos atuantes da landing page pois aproveitamos este projeto em outra disciplina de CI/CD, porém não se preocupe pois todos os commits voltados a Landing Page em si, foram feitos por Kaio Moreira e Miguel Farias. Se por ventura ver algum commit de outro integrante, pode analisar o que foi alterado e verá que é da Pipeline em Github Actions que fizemos para essa outra disciplina.

## Link do site no ar

https://landing-page-facisa.vercel.app/

# Documentação projeto CI/CD

- O projeto selecionado foi uma simples Landing Page que está sendo desenvolvida e aprimorada ao longo da disciplina 'Programar em linguagem Interpretada', consiste em um portfólio simples com intenção de divulgar de forma profissional a mão de obra dos integrantes Kaio Moreira e Miguel Farias

## Integrantes

- Kaio Moreira
- Miguel Coelho Farias
- Nivea Souza
- Marcos Aurélio
- Gabriel Brito

## Sobre a construçãO da PIPELINE

- A construção da pipeline foi de acordo com o nível de complexidade do projeto. Por se tratar de um site estático, a escolha da pipe foi para:
- Analisar Merges na branch main;
- Rodar a pipe sempre que houver merge;
- Analisar a build do projeto em uma VM;
- Conseguindo prosseguir sem erros, a pipe irá pegar as secrets voltadas a conta Vercel que estão disponibilizadas ao Actions
- A pipe irá realizar o deploy na Vercel e atualizar o site com as alterações.

## Para executar a pipe

Realize um commit diretamente na main ou um merge de qualquer branch para a Main

## Link do site no ar

https://landing-page-facisa.vercel.app/

