# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

This is a demonstration application for Metis (Ghent), built as a microservices architecture using Docker Compose. It reuses most of the "Centrale Vindplaats" frontend for a quick demo. The application provides a SPARQL query interface and semantic data browsing capabilities, connecting to the Ghent city SPARQL endpoint.

## Development Commands

**Frontend (Ember.js)**
```bash
# Navigate to frontend directory
cd frontend-metis-ghent

# Install dependencies
npm install

# Start development server
npm run start

# Build for production
npm run build

# Run tests
npm run test
npm run test:ember

# Linting
npm run lint
npm run lint:fix
```

**Docker Environment**
```bash
# Start all services
docker-compose up

# Start in detached mode
docker-compose up -d

# Stop services
docker-compose down

# Rebuild services
docker-compose up --build
```

## Architecture Overview

### Service Architecture
- **Frontend**: Ember.js application (`frontend-metis-ghent/`) serving the UI
- **Dispatcher**: mu-dispatcher routing requests between services
- **SPARQL Proxy**: Nginx proxy forwarding SPARQL queries to `stad.gent/sparql`
- **Resource Services**: Labels and URI info services for semantic data processing
- **Cache Layer**: mu-cache for performance optimization

### Key Components

**Frontend Structure**
- Built with Ember.js (Octane edition) using Embroider for modern bundling
- Uses `ember-metis` for semantic data routing and views
- Integrates YASGUI for SPARQL query interface
- Implements FastBoot for server-side rendering

**Routing System**
- Custom semantic routes via `ember-metis` (`classRoute`, `externalRoute`, `fallbackRoute`)
- Dynamic view routes for semantic classes (e.g., `verwerkings-activiteit`)
- SPARQL query interface at `/sparql`
- Legal pages under `/legaal`

**Data Flow**
1. Frontend requests go through mu-dispatcher (`config/dispatcher/dispatcher.ex`)
2. SPARQL queries are proxied to Ghent's endpoint via nginx (`config/sparql-proxy.conf`)
3. Resource labels and URI info are cached for performance
4. Semantic data is displayed using metis components

### Configuration

**Environment Variables**
- `EMBER_METIS_BASE_URL`: Base URL for Metis (defaults to `https://stad.gent/`)
- `YASGUI_DEFAULT_QUERY`: Default SPARQL query for the interface
- `YASGUI_EXTRA_PREFIXES`: Additional RDF prefixes

**Key Configuration Files**
- `docker-compose.yml`: Service orchestration
- `config/dispatcher/dispatcher.ex`: Request routing logic
- `config/sparql-proxy.conf`: SPARQL endpoint proxy configuration
- `frontend-metis-ghent/config/environment.js`: Ember application configuration

## Working with Semantic Data

The application uses RDF/SPARQL for data access. Key namespaces:
- `http://data.vlaanderen.be/ns/toestemming#VerwerkingsActiviteit`: Processing activities
- Standard prefixes: `skos`, `dct`, `besluit`, `mandaat`

When adding new semantic views, use the `classRoute` helper in the router and create corresponding route handlers that query the SPARQL endpoint.

## Testing

- Uses QUnit for unit tests
- Ember Testing utilities for integration tests
- Testem for test runner configuration
- Tests located in `frontend-metis-ghent/tests/`

## Deployment Notes

- Frontend is containerized with Docker
- Uses Embroider for optimized builds
- FastBoot enabled for server-side rendering
- SPARQL queries are proxied to external endpoints (stad.gent)
- All services communicate via Docker internal networking