# AGENTS.md - Regeddit Web

> Ruby on Rails 8.1.1 development instructions for AI agents

## Technology Stack

- **Ruby**: 3.4.7
- **Rails**: 8.1.1
- **Database**: Sqlite
- **Cache**: Redis
- **Container**: Docker + Dev Containers (preferred)
- **Testing**: RSpec + FactoryBot
- **Encoding**: UTF-8

**Role**: This application manages the database for the entire ecosystem (web)

## Essential Commands

```bash
# Setup
bin/setup                      # Initial setup
bin/ci                         # Full CI validation

# Development
bin/rails server               # Start server

# Database
bin/rails db:migrate           # Migrate tenant schemas

# Quality
bin/rubocop                    # Ruby linting
bin/rspec                      # Run tests
```

## Code Quality

**Testing:**
- 100% SimpleCov coverage REQUIRED
- RSpec + FactoryBot
- Write tests before implementation

**Linting:**
- RuboCop: Ruby style
- Haml: Templates
- Standard: JavaScript

**AI Development:**
- Study existing patterns before implementing
- Use AI for boilerplate and tests
- Validate with automated tools

## Architecture

## Security

**Enforce:**
- NO secrets in code (use environment variables)
- Use Rails built-in protections (SQL injection, XSS, CSRF)
- Encrypt sensitive data at rest
- RBAC for authorization
- Audit significant actions

## Performance

**Optimize:**
- Use Redis for caching
- Prevent N+1 queries
- Index multi-tenant queries
- Use GoodJob for background jobs

## CI/CD

**Requirements:**
- All linters must pass
- 100% test coverage required
- Docker container validation

