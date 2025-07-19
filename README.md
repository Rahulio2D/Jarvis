# README

Jarvis is a simple API for myself to handle common daily tasks/queries. The goal is for it to become a personal assistant through a hub application that can naturally process language using AI and transform that into a suitable API request.

Some of the things I currently plan to implement include:
- People (i.e. Phone Numbers and Email)
- Weather
- Traffic alerts (based on calendar)
- Notes/Reminders
- Shopping Lists
- Health/Fitness (Apple Watch Integration)

This project is being developed using [Cursor AI](https://cursor.com/)

## Quick Start with Makefile

This project includes a comprehensive Makefile for common development and deployment tasks.

### View All Available Commands
```bash
make help
```

### Development Commands
```bash
make start          # Start Rails development server
make console        # Open Rails console
make test           # Run RSpec tests
make migrate        # Run database migrations
make setup          # Initial setup for new developers
```

### Quick Aliases
```bash
make s              # Alias for start
make c              # Alias for console
make t              # Alias for test
make d              # Alias for deploy
make m              # Alias for migrate
```

### Deployment Commands
```bash
make deploy         # Deploy to production using Kamal
make deploy-status  # Check deployment status
make deploy-logs    # View production logs
make deploy-rollback # Rollback to previous deployment
```

### Docker Commands
```bash
make docker-build   # Build Docker image
make docker-run     # Run Docker container locally
make docker-stop    # Stop Docker container
```

### Database Commands
```bash
make db-prepare     # Prepare database for current environment
make db-reset       # Reset database (development only)
make db-backup      # Backup SQLite database
```

### Maintenance Commands
```bash
make clean          # Clean temporary files and caches
make install        # Install dependencies
make update         # Update dependencies
```

## Initial Setup

For new developers, run:
```bash
make setup
```

This will install dependencies and prepare the database.
