# Metis Demo Architecture Diagram

```mermaid
graph TB
    %% External
    User[👤 User<br/>Browser]
    GhentSPARQL[🌐 stad.gent/sparql<br/>External SPARQL Endpoint]
    
    %% Request Flow Numbers
    User -->|1. GET /view/verwerkings-activiteit<br/>Port 8200| identifier
    
    %% Core Services
    subgraph "Docker Network"
        %% Frontend & Entry Point
        identifier[🔑 identifier<br/>mu-identifier:1.10.3<br/>Session Management<br/>⚠️ TCP connection errors]
        dispatcher[🚦 dispatcher<br/>mu-dispatcher:2.1.0-beta.2<br/>Request Routing]
        frontend[🖥️ frontend<br/>Ember.js App<br/>./frontend-metis-ghent<br/>📦 Serves assets & SSR]
        
        %% Data Services
        resourceLabels[🏷️ resource-labels<br/>lblod/resource-label-service:0.3.1<br/>Label Service]
        uriInfo[ℹ️ uri-info<br/>mu-uri-info-service<br/>URI Information]
        cache[💾 resource-labels-cache<br/>semtech/mu-cache:2.0.2<br/>Caching Layer]
        
        %% Proxy
        sparqlproxy[🔄 sparqlproxy<br/>nginx:alpine<br/>SPARQL Proxy<br/>✅ Working correctly]
    end
    
    %% Request Flow Chain
    identifier -->|2. Route request| dispatcher
    dispatcher -->|3. Forward to frontend| frontend
    frontend -->|4. Serve HTML + assets<br/>(CSS, JS, fonts)<br/>304 cached responses| User
    frontend -->|5. SPARQL queries<br/>GET /sparql/| sparqlproxy
    sparqlproxy -->|6. Proxy to external<br/>SPARQL endpoint| GhentSPARQL
    GhentSPARQL -->|7. Query results| sparqlproxy
    sparqlproxy -->|8. Return results| frontend
    
    %% Configuration connections
    cache -.->|links to| resourceLabels
    
    %% SPARQL connections to external endpoint (config only)
    resourceLabels -.->|MU_SPARQL_ENDPOINT| GhentSPARQL
    uriInfo -.->|MU_SPARQL_ENDPOINT| GhentSPARQL
    cache -.->|MU_SPARQL_ENDPOINT| GhentSPARQL
    
    %% Frontend environment config
    frontend -.->|EMBER_METIS_BASE_URL<br/>https://stad.gent/| GhentSPARQL
    
    %% Styling
    classDef external fill:#e1f5fe
    classDef frontend fill:#f3e5f5
    classDef core fill:#e8f5e8
    classDef data fill:#fff3e0
    classDef proxy fill:#fce4ec
    classDef active stroke:#4caf50,stroke-width:3px
    classDef error stroke:#f44336,stroke-width:2px
    
    class User,GhentSPARQL external
    class frontend frontend
    class dispatcher core
    class identifier core
    class resourceLabels,uriInfo,cache data
    class sparqlproxy proxy
    class sparqlproxy,frontend active
    class identifier error
```

## Service Connections Summary

### External Access
- **Port 8200**: User access point via `identifier` service

### Internal Network Links
- `frontend` → `identifier` (backend connection)
- `cache` → `resource-labels` (backend connection)

### SPARQL Endpoint Connections
All services connect to `https://stad.gent/sparql`:
- `resource-labels` (via MU_SPARQL_ENDPOINT)
- `uri-info` (via MU_SPARQL_ENDPOINT) 
- `resource-labels-cache` (via MU_SPARQL_ENDPOINT)
- `sparqlproxy` (nginx proxy configuration)
- `frontend` (via EMBER_METIS_BASE_URL)

### Configuration Files
- `./config/dispatcher` → `dispatcher` service
- `./config/sparql-proxy.conf` → `sparqlproxy` service
- `./frontend-metis-ghent` → `frontend` build context