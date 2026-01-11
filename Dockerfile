# syntax=docker/dockerfile:1
# check=error=true

ARG RUBY_VERSION=3.4.7
ARG NODE_VERSION=24.11.0

# ---- Node stage (para build de assets JS/CSS quando usar esbuild, tailwind, etc.)
FROM node:${NODE_VERSION}-bookworm-slim AS node

# ---- Base Ruby
FROM docker.io/library/ruby:${RUBY_VERSION}-slim AS base
WORKDIR /rails

RUN apt-get update -qq && \
    apt-get install --no-install-recommends -y curl libjemalloc2 libvips libpq5 zsh git && \
    ln -s /usr/lib/$(uname -m)-linux-gnu/libjemalloc.so.2 /usr/local/lib/libjemalloc.so && \
    rm -rf /var/lib/apt/lists /var/cache/apt/archives

# Se quiser Node também em runtime (p/ runtime JS, ActionCable, etc.), copie do stage node:
# (opcional; obrigatório se seu app precisa de node/npm em runtime)
COPY --from=node /usr/local /usr/local

ENV RAILS_ENV=production \
    BUNDLE_DEPLOYMENT=1 \
    BUNDLE_PATH=/usr/local/bundle \
    BUNDLE_WITHOUT=development \
    LD_PRELOAD=/usr/local/lib/libjemalloc.so

# ---- Build
FROM base AS build
RUN apt-get update -qq && \
    apt-get install --no-install-recommends -y build-essential git libyaml-dev libpq-dev pkg-config && \
    rm -rf /var/lib/apt/lists /var/cache/apt/archives

# Dependências para bundle
COPY Gemfile Gemfile.lock vendor ./
RUN bundle install && \
    rm -rf ~/.bundle/ "${BUNDLE_PATH}"/ruby/*/cache "${BUNDLE_PATH}"/ruby/*/bundler/gems/*/.git && \
    bundle exec bootsnap precompile -j 1 --gemfile

# Código
COPY . .

# Precompile bootsnap
RUN bundle exec bootsnap precompile -j 1 app/ lib/

# Precompile de assets (para esbuild/tailwind funciona porque temos Node no PATH)
RUN SECRET_KEY_BASE_DUMMY=1 ./bin/rails assets:precompile

# ---- Development (with build tools)
FROM base AS development

RUN apt-get update -qq && \
    apt-get install --no-install-recommends -y build-essential git libyaml-dev libpq-dev pkg-config && \
    rm -rf /var/lib/apt/lists /var/cache/apt/archives

ENV RAILS_ENV=development \
    BUNDLE_DEPLOYMENT=0 \
    BUNDLE_PATH=/usr/local/bundle \
    BUNDLE_WITHOUT=""

WORKDIR /rails

# ---- Final (production)
CMD ["./bin/thrust", "./bin/rails", "server"]
