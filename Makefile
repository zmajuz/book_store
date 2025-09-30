.PHONY: exec cop rspec suit logs web up build down migrate rollback console bash _ensure_up help clean

SERVICE = backend

_ensure_up: ## Garante que o serviço $(SERVICE) esteja em execução
	@if [ -z "$$(docker compose ps -q --status=running $(SERVICE))" ]; then \
		echo "🚀 Starting $(SERVICE) service..."; \
		docker compose up -d $(SERVICE); \
	fi

exec: _ensure_up ## Executa um comando dentro do container backend (use CMD="seu comando")
	@docker compose exec $(SERVICE) $(CMD)

cop: _ensure_up ## Executa o RuboCop dentro do container
	@docker compose exec $(SERVICE) bundle exec rubocop

rspec: _ensure_up ## Executa os testes RSpec (use SPEC="spec/path" para executar testes específicos)
	@docker compose exec $(SERVICE) bin/rails db:prepare RAILS_ENV=test && docker compose exec $(SERVICE) bundle exec rspec $(filter-out $@,$(MAKECMDGOALS))


suit: _ensure_up ## Executa RuboCop e RSpec em sequência
	@docker compose exec $(SERVICE) bundle exec rubocop && docker compose exec $(SERVICE) bin/rails db:prepare RAILS_ENV=test && docker compose exec $(SERVICE) bundle exec rspec $(filter-out $@,$(MAKECMDGOALS))

logs: ## Mostra os logs em tempo real do backend
	@echo "📜 Acompanhando os logs do backend..."
	@docker compose logs -f $(SERVICE)

web: ## Sobe o backend com portas expostas em modo interativo
	@docker compose run --service-ports backend

up: ## Inicia todos os serviços em segundo plano
	@docker compose up -d

build: ## Reconstrói as imagens Docker
	@docker compose build

down: ## Encerra e remove volumes e containers órfãos
	@docker compose down -v --remove-orphans

start: up logs ## Inicia todos os serviços e exibe os logs

migrate: _ensure_up ## Executa as migrações do banco de dados
	@docker compose exec $(SERVICE) bin/rails db:migrate

rollback: _ensure_up ## Reverte a última migração do banco de dados
	@docker compose exec $(SERVICE) bin/rails db:rollback

console: _ensure_up ## Abre um console Rails dentro do container
	@docker compose exec $(SERVICE) bin/rails console

bash: _ensure_up ## Abre um terminal bash dentro do container
	@docker compose exec $(SERVICE) bash

clean: ## Remove containers, volumes e imagens não utilizados
	@docker system prune -a --volumes -f

help: ## Exibe esta lista de comandos
	@echo "Comandos disponíveis:"
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) \
		| sort \
		| awk 'BEGIN {FS = ":.*?## "}; {printf "  \033[36m%-15s\033[0m %s\n", $$1, $$2}'

%:
	@: