# AGENTS.md - Regeddit Web

> Ruby on Rails 8.1.1 development instructions for AI agents

## Technology Stack

- **Ruby**: 3.4.7
- **Rails**: 8.1.1
- **Database**: PostgreSQL
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

**Current Layout Approach:**
- Using **inline HAML** in views for layout structure
- Components for **reusable UI elements**
- Main chat layout in `app/views/home/index.html.haml`

**Existing Components:**
- **ChannelLink**: Renders a channel link with icon and name
- **DirectMessageLink**: Renders a DM link with online status and unread count
- **SidebarLink**: Renders sidebar navigation links
- **ChatMessage**: Renders a chat message with reactions
- **MessageInput**: Renders the message input area with toolbar

**When to Create Components:**
- ✅ Reusable UI elements (buttons, badges, cards)
- ✅ Independent widgets (notifications, modals)
- ✅ Repeated patterns (links, messages, inputs)
- ❌ Main layout structure (use inline HAML)
- ❌ Page-specific layouts

**Component Organization:**
- Each component MUST have its own directory under `app/components/`
- Use descriptive names based on functionality (e.g., `message_card`, `reaction_button`)
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

## Icons with Font Awesome

**Library:**
- Using Font Awesome 7.0.1 (via CDN)
- Loaded in `app/views/layouts/application.html.haml`

**Usage:**
```haml
/ Solid icons (most common)
%i.fa-solid.fa-plus
%i.fa-solid.fa-message
%i.fa-solid.fa-chevron-down

/ With sizing
%i.fa-solid.fa-plus.text-xl
%i.h-4.w-4.fa-solid.fa-hashtag

/ In buttons
%button
  %i.fa-solid.fa-bars
```

**Common Icons Used:**
- `fa-plus` - Add/Create
- `fa-hashtag` - Channel
- `fa-lock` - Private/Locked
- `fa-message` - Messages
- `fa-comments` - Multiple messages
- `fa-bookmark` - Saved items
- `fa-chevron-down` - Dropdown
- `fa-ellipsis-vertical` - More options
- `fa-bolt` - Quick actions
- `fa-at` - Mentions
- `fa-face-smile` - Emojis
- `fa-paperclip` - Attachments
- `fa-paper-plane` - Send

**Best Practices:**
- ✅ Use `fa-solid` for filled icons
- ✅ Add Tailwind size classes: `h-4 w-4`
- ✅ Use semantic icon names
- ❌ Don't use inline SVG when Font Awesome has the icon
- ❌ Don't mix icon libraries

## Assets Management

**Development Environment:**
- Assets are compiled dynamically (no precompilation needed)
- Changes appear instantly without server restart
- Files served directly from `app/assets/`

**Production Environment:**
- Assets are precompiled during deploy (automatic)
- Fingerprinting enabled for cache busting
- Minification and compression enabled

**Rules:**
- ❌ **NEVER** run `rails assets:precompile` in development
- ✅ Precompilation happens automatically in Docker build
- ✅ `public/assets` is git-ignored and should be empty in development
- ✅ Use Tailwind's watch mode: `bin/rails tailwindcss:watch`

**Configuration:**
```ruby
# config/environments/development.rb
config.assets.debug = true      # Readable, unminified assets
config.assets.compile = true    # Compile on-demand
config.assets.digest = false    # No fingerprinting in dev

# config/environments/production.rb
config.assets.compile = false   # Use precompiled assets only
config.assets.digest = true     # Fingerprinting enabled
config.assets.compress = true   # Minification enabled
```

## Stimulus Controllers

**Purpose:**
- Handle client-side interactivity
- Keep JavaScript organized and maintainable
- Follow conventions over configuration

**File Location:**
- All controllers in `app/javascript/controllers/`
- Use snake_case naming: `toggle_controller.js`, `dropdown_controller.js`

**Current Controllers:**
- **toggle_controller.js**: Shows/hides content (used for channels/messages lists)

**Creating New Controllers:**
```javascript
// app/javascript/controllers/example_controller.js
import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["content"]
  
  connect() {
    // Called when controller is connected to DOM
  }
  
  toggle() {
    this.contentTarget.classList.toggle("hidden")
  }
}
```

**Usage in HAML:**
```haml
%div{data: {controller: "example"}}
  %button{data: {action: "click->example#toggle"}} Toggle
  %div{data: {example_target: "content"}} Content here
```

**Best Practices:**
- ✅ Keep controllers small and focused
- ✅ Use data attributes for configuration
- ✅ Clean up in `disconnect()` if needed
- ❌ Don't manipulate distant DOM elements
- ❌ Avoid jQuery - use vanilla JS

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

