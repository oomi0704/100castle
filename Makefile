# Docker関連のコマンドを簡単に実行するためのMakefile

.PHONY: help build up down logs shell db-shell clean

help: ## 利用可能なコマンドを表示
	@echo "利用可能なコマンド:"
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-20s\033[0m %s\n", $$1, $$2}'

# 開発環境
build: ## Dockerイメージをビルド
	docker-compose build

up: ## 開発環境を起動
	docker-compose up -d

down: ## 開発環境を停止
	docker-compose down

logs: ## ログを表示
	docker-compose logs -f

shell: ## Railsコンテナにシェルで接続
	docker-compose exec web sh

db-shell: ## データベースコンテナにシェルで接続
	docker-compose exec db psql -U castle_app -d castle_app_development

# データベース関連
db-create: ## データベースを作成
	docker-compose exec web bundle exec rails db:create

db-migrate: ## データベースマイグレーションを実行
	docker-compose exec web bundle exec rails db:migrate

db-seed: ## シードデータを投入
	docker-compose exec web bundle exec rails db:seed

db-reset: ## データベースをリセット
	docker-compose exec web bundle exec rails db:drop db:create db:migrate db:seed

# 本番環境
build-prod: ## 本番用Dockerイメージをビルド
	docker-compose -f docker-compose.prod.yml build

up-prod: ## 本番環境を起動
	docker-compose -f docker-compose.prod.yml up -d

down-prod: ## 本番環境を停止
	docker-compose -f docker-compose.prod.yml down

logs-prod: ## 本番環境のログを表示
	docker-compose -f docker-compose.prod.yml logs -f

# クリーンアップ
clean: ## コンテナ、イメージ、ボリュームを削除
	docker-compose down -v --rmi all
	docker system prune -f

clean-prod: ## 本番環境のクリーンアップ
	docker-compose -f docker-compose.prod.yml down -v --rmi all
	docker system prune -f 