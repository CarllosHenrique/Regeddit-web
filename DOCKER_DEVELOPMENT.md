# Docker Development Setup

Este projeto está configurado para rodar com Docker e Foreman.

## Pré-requisitos

- Docker
- Docker Compose

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

