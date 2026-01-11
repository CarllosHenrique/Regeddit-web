# 🚀 Regeddit Web

<div align="center">

Uma plataforma de comunidades e discussões inspirada no Reddit, construída com Ruby on Rails.

[![Rails](https://img.shields.io/badge/Rails-8.1.1-red.svg)](https://rubyonrails.org/)
[![Ruby](https://img.shields.io/badge/Ruby-3.4.7-red.svg)](https://www.ruby-lang.org/)
[![License](https://img.shields.io/badge/license-MIT-blue.svg)](LICENSE)

[Features](#features) • [Instalação](#instalação) • [Desenvolvimento](#desenvolvimento) • [Tecnologias](#tecnologias) • [Contribuindo](#contribuindo)

</div>

---

## 📋 Sobre o Projeto

**Regeddit** é uma aplicação web moderna que permite usuários criarem e participarem de comunidades, compartilharem conteúdo e interagirem através de threads e discussões. O projeto oferece uma interface intuitiva e responsiva, focada na experiência do usuário.

### 🎯 Problema que Resolve

Em um mundo onde a comunicação digital é essencial, muitas plataformas são complexas ou não atendem às necessidades de comunidades brasileiras. O Regeddit oferece:

- ✅ **Interface Limpa e Moderna**: Design focado em usabilidade
- ✅ **Comunidades Organizadas**: Sistema de threads e posts bem estruturado
- ✅ **Performance**: Construído com tecnologias modernas e eficientes
- ✅ **Código Aberto**: Transparente e modificável pela comunidade

### ✨ Features

- 🔐 **Autenticação de Usuários**: Sistema completo com Devise
- 📝 **Criação de Posts**: Compartilhe conteúdo com imagens
- 💬 **Sistema de Comentários**: Interaja com outros usuários
- 👍 **Reações**: Like e outras interações sociais
- 🏷️ **Comunidades**: Organize conteúdo por tópicos
- 🔍 **Busca**: Encontre conteúdo relevante rapidamente
- 📱 **Responsivo**: Interface adaptada para mobile e desktop

---

## 🛠️ Tecnologias

### Backend
- **[Ruby](https://www.ruby-lang.org/)** `3.4.7` - Linguagem de programação
- **[Rails](https://rubyonrails.org/)** `8.1.1` - Framework web
- **[PostgreSQL](https://www.postgresql.org/)** - Banco de dados
- **[Redis](https://redis.io/)** - Cache e gerenciamento de filas

### Frontend
- **[Tailwind CSS](https://tailwindcss.com/)** - Framework CSS utilitário
- **[ViewComponent](https://viewcomponent.org/)** - Componentes reutilizáveis
- **[HAML](https://haml.info/)** - Template engine
- **[Stimulus](https://stimulus.hotwired.dev/)** - JavaScript framework
- **[Turbo](https://turbo.hotwired.dev/)** - SPA-like experience
- **[Font Awesome](https://fontawesome.com/)** `7.0.1` - Biblioteca de ícones

### Infraestrutura & DevOps
- **[Docker](https://www.docker.com/)** - Containerização
- **[Foreman](https://github.com/ddollar/foreman)** - Gerenciamento de processos
- **[Kamal](https://kamal-deploy.org/)** - Deploy automatizado
- **[Solid Queue](https://github.com/rails/solid_queue)** - Background jobs

### Qualidade & Testes
- **[RSpec](https://rspec.info/)** - Framework de testes
- **[FactoryBot](https://github.com/thoughtbot/factory_bot)** - Test fixtures
- **[Faker](https://github.com/faker-ruby/faker)** - Dados de teste
- **[SimpleCov](https://github.com/simplecov-ruby/simplecov)** - Cobertura de código
- **[RuboCop](https://rubocop.org/)** - Linter Ruby
- **[Brakeman](https://brakemanscanner.org/)** - Análise de segurança
- **[Bundler Audit](https://github.com/rubysec/bundler-audit)** - Auditoria de gems

---

## 📦 Instalação

### Pré-requisitos

Antes de começar, você precisa ter instalado:

- **Ruby** `3.4.7` ([rbenv](https://github.com/rbenv/rbenv) ou [rvm](https://rvm.io/) recomendado)
- **Rails** `8.1.1`
- **Docker** e **Docker Compose** (para desenvolvimento containerizado)
- **Git**
- **Redis** (para desenvolvimento local sem Docker)

### Opção 1: Desenvolvimento com Docker (Recomendado) 🐳

O método mais simples e consistente para iniciar o desenvolvimento:

```bash
# 1. Clone o repositório
git clone https://github.com/CarllosHenrique/Regeddit-web.git
cd Regeddit-web

# 2. Configure as variáveis de ambiente
cp .env.exemple .env
# Edite .env e adicione suas credenciais

# 3. Inicie os containers
docker-compose up

# A aplicação estará disponível em http://localhost:3000
```

**O que o Docker Compose faz:**
- ✅ Instala todas as dependências automaticamente
- ✅ Configura Redis
- ✅ Prepara o banco de dados
- ✅ Inicia o servidor Rails
- ✅ Hot reload - suas mudanças aparecem instantaneamente

📚 **Documentação completa**: Veja [DOCKER_DEVELOPMENT.md](DOCKER_DEVELOPMENT.md) para troubleshooting e comandos avançados.

### Opção 2: Desenvolvimento Local

Se preferir rodar sem Docker:

```bash
# 1. Clone o repositório
git clone https://github.com/CarllosHenrique/Regeddit-web.git
cd Regeddit-web

# 2. Instale as dependências
bundle install

# 3. Configure o banco de dados
bin/rails db:prepare

# 4. Inicie o servidor com Foreman (gerencia Rails + outros processos)
bin/dev

# Ou apenas o Rails server
bin/rails server
```

A aplicação estará disponível em `http://localhost:3000`

---

## 🚀 Desenvolvimento

### Comandos Essenciais

```bash
# Setup inicial (primeira vez)
bin/setup                      # Instala deps, prepara DB, limpa logs

# Desenvolvimento
bin/dev                        # Inicia todos os serviços (Rails, etc)
bin/rails server              # Apenas Rails server
bin/rails console             # Console interativo

# Banco de Dados
bin/rails db:migrate          # Executa migrações pendentes
bin/rails db:seed             # Popular dados de exemplo
bin/rails db:reset            # Dropa, cria, migra e popula DB

# Testes
bin/rspec                     # Roda todos os testes
bin/rspec spec/models         # Testa apenas models
bin/rspec spec/path/to/file_spec.rb  # Testa arquivo específico

# Qualidade de Código
bin/rubocop                   # Linter Ruby
bin/rubocop -a                # Auto-corrige problemas simples
bin/brakeman                  # Análise de segurança
bin/bundler-audit             # Auditoria de vulnerabilidades em gems

# CI Completo (testes + linters + segurança)
bin/ci                        # Roda todo o pipeline de CI localmente
```

### Comandos Docker

```bash
# Gerenciamento de Containers
docker-compose up             # Inicia em foreground (vê logs)
docker-compose up -d          # Inicia em background
docker-compose down           # Para containers
docker-compose down -v        # Para e remove volumes (limpa tudo)
docker-compose up --build     # Reconstrói imagens

# Logs
docker-compose logs -f        # Todos os logs em tempo real
docker-compose logs -f web    # Apenas logs do Rails

# Executar comandos no container
docker-compose exec web bash                      # Abre shell no container
docker-compose exec web bin/rails console         # Rails console
docker-compose exec web bin/rails db:migrate      # Migrations
docker-compose exec web bin/rspec                 # Testes
docker-compose exec web bin/rubocop               # Linter
```

### Estrutura do Projeto

```
Regeddit-web/
├── app/
│   ├── assets/           # CSS, imagens, etc
│   ├── components/       # ViewComponents reutilizáveis
│   ├── controllers/      # Controllers Rails
│   ├── helpers/          # View helpers
│   ├── javascript/       # JavaScript/Stimulus controllers
│   ├── jobs/            # Background jobs
│   ├── mailers/         # Mailers
│   ├── models/          # Models ActiveRecord
│   └── views/           # Templates HAML
├── bin/                 # Scripts executáveis
├── config/              # Configurações da aplicação
├── db/                  # Schema e migrations
├── spec/                # Testes RSpec
├── docker-compose.yml   # Configuração Docker Compose
├── Dockerfile           # Imagem Docker
├── Gemfile              # Dependências Ruby
└── README.md           # Este arquivo
```

### ViewComponents

O projeto usa ViewComponent para criar componentes UI reutilizáveis:

```ruby
# app/components/sidebar/component.rb
module Sidebar
  class Component < ViewComponent::Base
    def initialize(title:)
      @title = title
    end
  end
end

# app/components/sidebar/component.html.haml
.sidebar
  %h3= @title
```

Uso:
```haml
= render Sidebar::Component.new(title: "Menu")
```

📚 **Mais detalhes**: Veja [AGENTS.md](AGENTS.md) para guia completo de ViewComponents e padrões de código.

### Stimulus Controllers

Para interatividade client-side:

```javascript
// app/javascript/controllers/toggle_controller.js
import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["content"]
  
  toggle() {
    this.contentTarget.classList.toggle("hidden")
  }
}
```

Uso em HAML:
```haml
%div{data: {controller: "toggle"}}
  %button{data: {action: "click->toggle#toggle"}} Alternar
  %div{data: {toggle_target: "content"}} Conteúdo
```

---

## 🧪 Testes e Qualidade

### Executando Testes

```bash
# Todos os testes
bin/rspec

# Com cobertura (SimpleCov)
COVERAGE=true bin/rspec

# Testes específicos
bin/rspec spec/models/user_spec.rb
bin/rspec spec/models/user_spec.rb:10  # Linha específica
```

### Cobertura de Código

O projeto exige **100% de cobertura** com SimpleCov. Após rodar os testes com `COVERAGE=true`, abra:

```bash
open coverage/index.html  # macOS
xdg-open coverage/index.html  # Linux
```

### Linting e Segurança

```bash
# Ruby style
bin/rubocop
bin/rubocop -a  # Auto-corrige

# Análise de segurança
bin/brakeman                # Vulnerabilidades de código
bin/bundler-audit           # Vulnerabilidades em gems
bin/importmap audit         # Vulnerabilidades em importmaps
```

### Pipeline CI Completo

Execute todo o pipeline localmente antes de fazer push:

```bash
bin/ci
```

Isso executa:
1. ✅ Setup do ambiente
2. ✅ Todos os testes RSpec
3. ✅ RuboCop (linting)
4. ✅ Bundler Audit (segurança de gems)
5. ✅ Importmap Audit (segurança de JS)
6. ✅ Brakeman (análise estática de segurança)

---

## 🎓 Onboarding para Novos Desenvolvedores

Bem-vindo ao time! 👋 Siga este guia para começar:

### Dia 1: Setup do Ambiente

1. **Configure seu ambiente de desenvolvimento**
   ```bash
   # Clone o repo
   git clone https://github.com/CarllosHenrique/Regeddit-web.git
   cd Regeddit-web
   
   # Opção A: Com Docker (mais fácil)
   docker-compose up
   
   # Opção B: Local
   bin/setup
   ```

2. **Familiarize-se com a aplicação**
   - Acesse `http://localhost:3000`
   - Crie uma conta e explore as features
   - Navegue pelo código em `app/`

3. **Leia a documentação**
   - [README.md](README.md) - Este arquivo (overview geral)
   - [AGENTS.md](AGENTS.md) - Padrões de código e convenções
   - [DOCKER_DEVELOPMENT.md](DOCKER_DEVELOPMENT.md) - Docker detalhado

### Semana 1: Compreensão do Código

1. **Arquitetura**
   - Estude a estrutura MVC em `app/`
   - Entenda o sistema de rotas em `config/routes.rb`
   - Revise os models em `app/models/`

2. **Testes**
   ```bash
   # Rode os testes
   bin/rspec
   
   # Veja exemplos em spec/
   ls spec/models/
   ```

3. **Primeira contribuição (fácil)**
   - Procure issues com label `good-first-issue`
   - Fixe um bug simples ou melhore documentação
   - Abra seu primeiro Pull Request

### Convenções e Boas Práticas

#### Git Workflow

```bash
# 1. Crie uma branch para sua feature
git checkout -b feature/minha-feature

# 2. Faça commits pequenos e descritivos
git commit -m "feat: adiciona autenticação OAuth"

# 3. Rode testes antes de push
bin/ci

# 4. Push e abra PR
git push origin feature/minha-feature
```

#### Padrões de Código

- ✅ **TDD**: Escreva testes ANTES do código
- ✅ **100% Coverage**: Todo código deve ter testes
- ✅ **RuboCop**: Siga as regras do linter
- ✅ **ViewComponents**: Use para UI reutilizável
- ✅ **Commits Semânticos**: `feat:`, `fix:`, `docs:`, etc
- ✅ **HAML**: Use HAML para views (não ERB)
- ✅ **Tailwind**: Use classes utilitárias (evite CSS customizado)

#### Code Review

Quando seu PR estiver pronto:
- ✅ Todos os testes passam (`bin/ci`)
- ✅ Sem conflitos com main
- ✅ Descrição clara do que foi feito
- ✅ Screenshots para mudanças visuais
- ✅ Documentação atualizada se necessário

### Recursos de Aprendizado

- **Ruby on Rails Guides**: https://guides.rubyonrails.org/
- **RSpec Documentation**: https://rspec.info/documentation/
- **Tailwind CSS**: https://tailwindcss.com/docs
- **ViewComponent**: https://viewcomponent.org/guide/
- **Stimulus**: https://stimulus.hotwired.dev/handbook/introduction

### Precisa de Ajuda?

- 💬 Abra uma discussão no GitHub
- 🐛 Reporte bugs com detalhes
- 📖 Consulte [AGENTS.md](AGENTS.md) para padrões específicos
- 🤝 Peça ajuda no code review

---

## 🌍 Ambiente e Configuração

### Variáveis de Ambiente

Crie um arquivo `.env` baseado em `.env.exemple`:

```bash
RAILS_MASTER_KEY=sua-master-key-aqui
# Adicione outras variáveis conforme necessário
```

⚠️ **IMPORTANTE**: Nunca commite arquivos com secrets! O `.env` está no `.gitignore`.

### Master Key

O projeto usa Rails encrypted credentials. Você precisa do arquivo `config/master.key`:

```bash
# Para criar/editar credentials
bin/rails credentials:edit
```

O `master.key` é compartilhado com segurança entre membros da equipe (não vai no Git).

---

## 🚢 Deploy

O projeto está configurado para deploy com **Kamal**:

```bash
# Deploy para produção
kamal deploy

# Ver logs de produção
kamal app logs

# Executar comandos remotos
kamal app exec 'bin/rails console'
```

📚 Consulte a [documentação do Kamal](https://kamal-deploy.org/) para detalhes.

---

## 🤝 Contribuindo

Contribuições são bem-vindas! 🎉

### Como Contribuir

1. **Fork o projeto**
2. **Crie uma branch** (`git checkout -b feature/MinhaFeature`)
3. **Faça seus commits** (`git commit -m 'feat: adiciona nova feature'`)
4. **Rode os testes** (`bin/ci`)
5. **Push para a branch** (`git push origin feature/MinhaFeature`)
6. **Abra um Pull Request**

### Tipos de Contribuição

- 🐛 **Bug fixes**: Corrija problemas existentes
- ✨ **Features**: Adicione novas funcionalidades
- 📝 **Documentação**: Melhore docs e exemplos
- 🎨 **UI/UX**: Aprimore a interface
- ⚡ **Performance**: Otimize código e queries
- ✅ **Testes**: Adicione ou melhore cobertura
- 🔒 **Segurança**: Reporte ou fixe vulnerabilidades

### Guidelines

- Siga os padrões de código definidos em [AGENTS.md](AGENTS.md)
- Escreva testes para novas features
- Mantenha 100% de cobertura de código
- Use commits semânticos
- Adicione documentação quando necessário
- Seja respeitoso em discussões e code reviews

---

## 📄 Licença

Este projeto está sob a licença MIT. Veja o arquivo [LICENSE](LICENSE) para mais detalhes.

---

## 👥 Autores

- **Carlos Henrique** - [@CarllosHenrique](https://github.com/CarllosHenrique)

---

## 🙏 Agradecimentos

- Comunidade Ruby on Rails
- Contribuidores open source
- Todos que ajudam a melhorar este projeto

---

<div align="center">

**[⬆ Voltar ao topo](#-regeddit-web)**

Feito com ❤️ usando Ruby on Rails

</div>
