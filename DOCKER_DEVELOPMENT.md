# Docker Development Setup

Este projeto está configurado para rodar com Docker e Foreman.

## Pré-requisitos

- Docker
- Docker Compose

## Configuração Inicial

### Master Key

O projeto requer o arquivo `config/master.key` para descriptografar credenciais. Este arquivo:
- **NÃO** deve ser commitado no Git
- Deve ser compartilhado com segurança entre membros da equipe
- É usado para descriptografar `config/credentials.yml.enc`

Se você não tem o `config/master.key`, peça ao líder do projeto ou gere um novo com:

```bash
bin/rails credentials:edit
```

### Tailwind CSS

O projeto usa Tailwind CSS que precisa ser compilado. O build é feito automaticamente quando você:
- Roda `bin/dev` (via Procfile.dev que inclui o processo `css`)
- Roda `bin/setup` (inclui `bin/rails tailwindcss:build`)
- Roda `docker-compose up` (o comando executa `bundle install && bin/dev`)

Os arquivos CSS compilados ficam em `app/assets/builds/` e são ignorados pelo Git.

## Estrutura de Desenvolvimento

O projeto usa **Foreman** para gerenciar processos em desenvolvimento:

- **web**: Rails server (porta 3000)

## Arquivos de Configuração

### Procfile.dev

```
web: bin/rails server -b 0.0.0.0
```

O servidor Rails está configurado para bind em `0.0.0.0` para permitir acesso de fora do container.

### docker-compose.yml

O Docker Compose está configurado para:

- Montar o código local como volume (hot reload)
- Persistir gems em um volume nomeado
- Persistir banco de dados SQLite
- Executar Foreman automaticamente ao iniciar

## Como Usar

### Iniciar o ambiente de desenvolvimento

```bash
docker-compose up
```

Isso iniciará:
- Redis
- Rails server na porta 3000

A aplicação estará disponível em: http://localhost:3000

### Reconstruir o container

Se você adicionar novas gems ou mudar dependências:

```bash
docker-compose up --build
```

### Parar os containers

```bash
docker-compose down
```

### Ver logs

```bash
# Todos os logs
docker-compose logs -f

# Apenas do web
docker-compose logs -f web
```

### Executar comandos no container

```bash
# Rails console
docker-compose exec web bundle exec rails console

# Migrations
docker-compose exec web bundle exec rails db:migrate

# Testes
docker-compose exec web bundle exec rspec
```

### Desenvolvimento Local (sem Docker)

Se preferir rodar localmente:

```bash
# Instalar dependências
bundle install

# Iniciar com Foreman
bin/dev
```

## Volumes

- **gem_cache**: Persiste gems instaladas
- **node_modules**: Persiste dependências Node.js (se houver)
- **sqlite_data**: Persiste o banco de dados SQLite
- **redis_data**: Persiste dados do Redis

## Troubleshooting

### Erro: "The asset 'tailwind.css' was not found"

O Tailwind CSS precisa ser compilado antes de usar. Isso acontece automaticamente quando você roda `bin/dev`, mas se encontrar este erro:

### Erro: "uninitialized constant Annotate"

Este erro pode ocorrer se as gems de desenvolvimento não foram instaladas. O projeto já está configurado para lidar com isso gracefully, mas se persistir:

```bash
# Reconstrua o container
docker-compose down
docker-compose up --build
```

### Erro: "key must be 16 bytes"

Problema com o `config/master.key`. Verifique se:
1. O arquivo `config/master.key` existe
2. O arquivo tem exatamente 32 caracteres hexadecimais
3. Não há espaços ou quebras de linha extras

Se necessário, regenere as credenciais:

```bash
rm config/credentials.yml.enc config/master.key
bin/rails credentials:edit
```

**Importante:** Guarde o novo `master.key` em um local seguro e compartilhe com a equipe!

### Container não inicia

```bash
# Limpe todos os volumes e reconstrua
docker-compose down -v
docker-compose up --build
```
- **sqlite_data**: Persiste banco de dados SQLite
- **redis_data**: Persiste dados do Redis

## Troubleshooting

### Porta 3000 já em uso

```bash
# Parar containers existentes
docker-compose down

# Ou mudar a porta no docker-compose.yml
ports:
  - "3001:3000"
```

### Gems não instaladas

```bash
docker-compose exec web bundle install
```

### Resetar ambiente

```bash
docker-compose down -v
docker-compose up --build
```

Isso irá remover todos os volumes e reconstruir do zero.

## Credenciais

O projeto usa Rails encrypted credentials. O arquivo `config/master.key` deve estar presente para descriptografar `config/credentials.yml.enc`.

Em desenvolvimento no Docker, uma `SECRET_KEY_BASE` é configurada via variável de ambiente no `docker-compose.yml`.

