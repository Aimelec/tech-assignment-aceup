# AceUp Orders

A fullstack order management system built with Rails 7.2 and React 19.

## Tech Stack

**Backend:** Rails 7.2 (API mode), PostgreSQL, Redis, Sidekiq, RSpec, Swagger (rswag)

**Frontend:** React 19, TypeScript, Mantine v8, TanStack Query, Vitest

**Infrastructure:** Docker Compose (all services containerized)

## Getting Started

### Prerequisites

- [Docker](https://www.docker.com/get-started)
- [Docker Compose](https://docs.docker.com/compose/)

### Setup

```bash
# Copy environment files
cp backend/.env.example backend/.env
cp frontend/.env.example frontend/.env

# Build and start all services
make build

# Initialize the database (run in another terminal)
make db.init

# Start the app
make start
```

The app will be available at:

- **Frontend:** http://localhost:5173
- **Backend API:** http://localhost:3000
- **Swagger docs:** http://localhost:3000/api-docs

## Architecture

### Backend — MVCS Pattern

The backend follows a **Model-View-Controller-Service** pattern with clear separation of concerns:

- **Contracts** (`app/contracts/`) — Input validation using dry-validation. Each operation has its own contract that validates params before any business logic runs.
- **Interactors** (`app/interactors/`) — Business logic layer. Orchestrates validation, persistence, and side effects (e.g., enqueuing email jobs). Controllers stay thin.
- **Serializers** (`app/serializers/`) — JSON:API compliant responses using jsonapi-serializer.
- **Services** (`app/services/`) — Infrastructure concerns like email delivery, built with a provider pattern for easy swapping.

### Frontend — Hooks-Driven Architecture

- **Custom hooks** (`src/hooks/`) — Each operation (create, update, delete) has its own hook encapsulating form state, mutations, validation, and notifications.
- **Shared validation** (`src/utils/orderValidation.ts`) — Form validation rules shared between create and update flows.
- **Shared constants** (`src/utils/orderStatuses.ts`) — Status colors and labels used across badge and modal components.
- **Theme system** (`src/theme/`) — Colors defined as a single source of truth in TypeScript, injected as CSS variables via `StyleProvider` for use in both TSX and CSS Modules.
- **CSS Modules** — Component-scoped styling with no inline CSS.

## Email Confirmation Flow

When a new order is created, the system sends a confirmation email asynchronously:

```
CreateOrder interactor
  └── Order.create!
  └── SendOrderConfirmationJob.perform_later(order.id)     ← enqueued to Sidekiq via Redis
        └── EmailService.new(provider: MockProvider)
              └── MockProvider#send_confirmation(order)
                    └── OrderMailer.confirmation(order).deliver_now
```

1. The **CreateOrder** interactor validates input via contract, persists the order, and enqueues `SendOrderConfirmationJob` to Sidekiq.
2. **Sidekiq** picks up the job from Redis and delegates to **EmailService**, which uses a provider pattern — currently a `MockProvider` that calls the mailer directly.
3. **OrderMailer** renders the confirmation HTML template with order details (customer name, order ID, description, total).
4. In development, **letter_opener** intercepts delivery and stores the email as an HTML file instead of actually sending it.

The provider pattern makes it straightforward to swap `MockProvider` for a real provider (SendGrid, SES, etc.) without touching the job or interactor.

### Extracting Emails

Emails sent in development are stored by letter_opener inside the backend container. To export them to your machine:

```bash
# Export all emails to ./emails/ on your local machine
make emails.export

# Clear stored emails
make emails.clear
```

## Testing

```bash
# Run backend tests (71 specs)
make test.backend

# Run frontend tests (12 specs)
make test.frontend
```

**Backend tests** cover contracts, interactors, models, serializers, and request specs (Swagger-driven).

**Frontend tests** live next to the components they test, with shared utilities in `src/test/`. They cover form validation, mutations, notifications, and user interactions (edit/delete flows).

## CI/CD

GitHub Actions workflows run on every push and PR to `main`:

**Backend CI** (`.github/workflows/backend-ci.yml`)
- **Lint** — Rubocop
- **Test** — RSpec against a PostgreSQL + Redis service container

**Frontend CI** (`.github/workflows/frontend-ci.yml`)
- **Lint** — ESLint
- **Test** — Vitest

## Make Commands

| Command | Description |
|---|---|
| `make build` | Build and start all services |
| `make start` | Start all services |
| `make stop` | Stop all services |
| `make db.init` | Create, migrate, and seed the database |
| `make db.reset` | Drop, recreate, migrate, and seed the database |
| `make db.migrate` | Run pending migrations |
| `make test.backend` | Run RSpec tests |
| `make test.frontend` | Run Vitest tests |
| `make emails.export` | Export letter_opener emails to `./emails/` |
| `make emails.clear` | Clear stored letter_opener emails |
| `make rails.c` | Open Rails console |
| `make sh` | Open shell in backend container |
