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

## ViewComponent Structure

**Component Organization:**
- Each component MUST have its own directory under `app/components/`
- Use descriptive names based on functionality (e.g., `layout`, `sidebar`, `server_list`)
- AVOID generic or feature-specific namespaces (e.g., `discord`, `app_name`)

**File Naming Convention:**
```
app/components/
├── component_name/
│   ├── component.rb           # Main component class
│   └── component.html.haml    # Template
```

**Class Structure:**
```ruby
# app/components/component_name/component.rb
module ComponentName
  class Component < ViewComponent::Base
    def initialize(params)
      @params = params
    end

    private

    attr_reader :params
  end
end
```

**Usage:**
```haml
= render ComponentName::Component.new(params: value)
```

**Best Practices:**
- Components should be organized by UI function (layout, sidebar, navbar, etc.)
- Use module namespacing matching the directory name
- Keep components focused and single-purpose
- Prefer composition over inheritance

**Real Example:**
```ruby
# app/components/sidebar/component.rb
module Sidebar
  class Component < ViewComponent::Base
    def initialize(server_name:, username:, discriminator:, avatar_url: nil)
      @server_name = server_name
      @username = username
      @discriminator = discriminator
      @avatar_url = avatar_url || "https://example.com/default.png"
    end

    private

    attr_reader :server_name, :username, :discriminator, :avatar_url
  end
end
```

```haml
-# app/components/sidebar/component.html.haml
.side-bar
  .nav
    %h4.guildSelectorName= server_name
  .userBox
    %img.userAvatar{alt: "avatar", src: avatar_url}/
    %h4.username= username
```

```haml
-# app/views/home/index.html.haml
= render Sidebar::Component.new(server_name: "My Server", username: "User", discriminator: "#1234")
```

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

