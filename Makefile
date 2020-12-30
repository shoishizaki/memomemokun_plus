.DEFAULT_GOAL := help

# コンテナ操作コマンド等
build: ## Docker build
	docker-compose build

up: ## Docker up
	docker-compose up

build_and_up: ## Docker build and up
	docker-compose build
	docker-compose up

down: ## Docker down
	docker-compose down

restart: ## Docker stop and start
	docker-compose stop
	docker-compose start

enter_web_container: ## enter Docker web container
	docker-compose exec web /bin/bash

enter_db_container: ## enter Docker db container
	docker-compose exec db /bin/bash

# rails操作コマンドのコマンド
migration: ## reset DB and make seed
	docker-compose exec web rails db:migrate:reset
	docker-compose exec web rails db:seed

rails_console: ## enter rails console
	docker-compose exec web rails c

help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'