.PHONY: exec cop rspec suit logs web up build down migrate rollback console bash _ensure_up help

SERVICE = backend

_ensure_up: ## Garante que o serviço $(SERVICE) está rodando
	@if [ -z "$$(docker compose ps -q --status=running $(SERVICE))" ]; then \
		echo "🚀 Starting $(SERVICE) service..."; \
		docker compose up -d --no-build $(SERVICE); \
	fi

exec: _ensure_up ## Executa um comando dentro do container backend (use CMD="seu comando")
	docker compose exec $(SERVICE) $(CMD)

cop: _ensure_up ## Roda o RuboCop dentro do container
	docker compose exec $(SERVICE) bundle exec rubocop

rspec: _ensure_up ## Roda os testes RSpec (use SPEC="spec/path" para rodar testes específicos)
	docker compose exec $(SERVICE) bundle exec rspec $(SPEC)

suit: cop rspec ## Roda RuboCop e RSpec em sequência

logs: ## Mostra os logs em tempo real do backend
	@echo "📜  Acompanhando os logs do backend..."
	@docker compose logs -f $(SERVICE)

web: ## Sobe o backend com portas expostas em modo interativo
	docker compose run --service-ports backend

up: ## Sobe todos os serviços em background
	@docker compose up -d

build: ## Rebuilda as imagens Docker
	docker compose build

down: ## Para e remove containers, volumes e órfãos
	docker compose down -v --remove-orphans

start: up logs ## Sobe os serviços e exibe os logs

migrate: _ensure_up ## Executa as migrações do banco
	docker compose exec $(SERVICE) bin/rails db:migrate

rollback: _ensure_up ## Faz rollback da última migração
	docker compose exec $(SERVICE) bin/rails db:rollback

console: _ensure_up ## Abre um console Rails dentro do container
	docker compose exec $(SERVICE) bin/rails console

bash: _ensure_up ## Abre um bash dentro do container
	docker compose exec $(SERVICE) bash

clean: ## Remove containers parados
	docker container prune -f

help: ## Mostra esta ajuda
	@echo "Comandos disponíveis:"
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) \
		| sort \
		| awk 'BEGIN {FS = ":.*?## "}; {printf "  \033[36m%-15s\033[0m %s\n", $$1, $$2}'
