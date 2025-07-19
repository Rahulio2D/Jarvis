# Jarvis Rails Application Makefile
# Common commands for development and deployment

.PHONY: help start stop restart bash console logs deploy migrate test clean

# Default target
help: ## Show this help message
	@echo "Jarvis Rails Application - Available Commands:"
	@echo ""
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-20s\033[0m %s\n", $$1, $$2}'

# Development Commands
start: ## Start the Rails development server
	@echo "Starting Rails development server on port 3000..."
	bin/rails server

stop: ## Stop the Rails development server (Ctrl+C)
	@echo "Use Ctrl+C to stop the Rails server"

restart: stop start ## Restart the Rails development server

console: ## Open Rails console
	@echo "Opening Rails console..."
	bin/rails console

bash: ## Open bash shell in the application directory
	@echo "Opening bash shell..."
	bash

# Database Commands
migrate: ## Run database migrations
	@echo "Running database migrations..."
	bin/rails db:migrate

migrate-reset: ## Reset and migrate database (WARNING: destroys data)
	@echo "WARNING: This will destroy all data!"
	@read -p "Are you sure? (y/N): " confirm && [ "$$confirm" = "y" ] || exit 1
	bin/rails db:drop db:create db:migrate db:seed

seed: ## Seed the database with sample data
	@echo "Seeding database..."
	bin/rails db:seed

# Testing Commands
test: ## Run all RSpec tests
	@echo "Running RSpec tests..."
	bundle exec rspec

test-watch: ## Run RSpec tests in watch mode
	@echo "Running RSpec tests in watch mode..."
	bundle exec rspec --watch

test-coverage: ## Run tests with coverage
	@echo "Running tests with coverage..."
	COVERAGE=true bundle exec rspec

# Docker Commands
docker-build: ## Build Docker image
	@echo "Building Docker image..."
	docker build -t jarvis .

docker-run: ## Run Docker container locally
	@echo "Running Docker container..."
	docker run -d -p 3000:80 -e RAILS_MASTER_KEY=$$(cat config/master.key) --name jarvis jarvis

docker-stop: ## Stop Docker container
	@echo "Stopping Docker container..."
	docker stop jarvis || true
	docker rm jarvis || true

docker-logs: ## View Docker container logs
	@echo "Viewing Docker logs..."
	docker logs -f jarvis

# Kamal Deployment Commands
deploy: ## Deploy to production using Kamal
	@echo "Deploying to production..."
	bin/kamal deploy

deploy-rollback: ## Rollback to previous deployment
	@echo "Rolling back deployment..."
	bin/kamal rollback

deploy-status: ## Check deployment status
	@echo "Checking deployment status..."
	bin/kamal status

deploy-logs: ## View production logs
	@echo "Viewing production logs..."
	bin/kamal logs

deploy-console: ## Open Rails console on production
	@echo "Opening production Rails console..."
	bin/kamal console

deploy-shell: ## Open shell on production server
	@echo "Opening production shell..."
	bin/kamal shell

# Maintenance Commands
clean: ## Clean temporary files and caches
	@echo "Cleaning temporary files..."
	rm -rf tmp/cache
	rm -rf log/*.log
	rm -rf .byebug_history
	@echo "Clean complete!"

clean-docker: ## Clean Docker images and containers
	@echo "Cleaning Docker..."
	docker system prune -f
	docker image prune -f

install: ## Install dependencies
	@echo "Installing dependencies..."
	bundle install
	yarn install || echo "Yarn not found, skipping"

update: ## Update dependencies
	@echo "Updating dependencies..."
	bundle update
	yarn upgrade || echo "Yarn not found, skipping"

# Database Commands
db-prepare: ## Prepare database for current environment
	@echo "Preparing database..."
	bin/rails db:prepare

db-reset: ## Reset database (development only)
	@echo "Resetting database..."
	bin/rails db:drop db:create db:migrate db:seed

db-backup: ## Backup SQLite database
	@echo "Backing up database..."
	cp storage/development.sqlite3 storage/backup_$$(date +%Y%m%d_%H%M%S).sqlite3

# Development Setup
setup: install db-prepare ## Initial setup for new developers
	@echo "Setup complete! Run 'make start' to start the server."

# Quick Commands
s: start ## Alias for start
c: console ## Alias for console
t: test ## Alias for test
d: deploy ## Alias for deploy
m: migrate ## Alias for migrate 