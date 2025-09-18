.PHONY: exec cop rspec suit logs web up down migrate rollback console bash _ensure_up

SERVICE = backend

_ensure_up:
	@if [ -z "$$(docker compose ps -q --status=running $(SERVICE))" ]; then \
		echo "🚀 Starting $(SERVICE) service..."; \
		docker compose up -d --no-build $(SERVICE); \
	fi

exec: _ensure_up
	docker compose exec $(SERVICE) $(CMD)

cop: _ensure_up
	docker compose exec $(SERVICE) bundle exec rubocop

rspec: _ensure_up
	docker compose exec $(SERVICE) bundle exec rspec

suit: cop rspec

logs:
	@echo "📜  Acompanhando os logs do backend..."
	@docker compose logs -f $(SERVICE)

web:
	@$(MAKE) logs

up:
	@docker compose up -d --build

down:
	docker compose down

start: up logs

migrate: _ensure_up
	docker compose exec $(SERVICE) bin/rails db:migrate

rollback: _ensure_up
	docker compose exec $(SERVICE) bin/rails db:rollback

console: _ensure_up
	docker compose exec $(SERVICE) bin/rails console

bash: _ensure_up
	docker compose exec $(SERVICE) bash
