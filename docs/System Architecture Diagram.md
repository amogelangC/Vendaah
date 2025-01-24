```mermaid
flowchart TD

    subgraph FL["Frontend Layer - React"]
        direction LR
        subgraph Client["Client Applications"]
            WEB[Web Browser]
            MOB[Mobile Browser]
        end

        subgraph UI["UI Layer"]
            direction LR
            subgraph Pages["Core Pages"]
                VDP[Vendor Dashboard]
                PLP[Product Listing]
                SP[Search Page]
                PDP[Product Details]
                AD[Analytics Dashboard]
            end
            
            subgraph Components["Shared Components"]
                NAV[Navigation]
                FORMS[Form Components]
                CHARTS[Analytics Charts]
            end
        end

        subgraph State["State Management"]
            STORE[Global Store]
            CCACHE[Client Cache]
        end
    end

    %% Backend Layer
    subgraph BL["Backend Layer - Django"]
        direction LR
        subgraph API["API Gateway"]
            REST[REST Endpoints]
            AUTH[Authentication]
            VALID[Request Validation]
        end

        subgraph Services["Business Services"]
            VS[Vendor Service]
            PS[Product Service]
            CS[Customer Service]
            SS[Search Service]
            AS[Analytics Service]
        end

        subgraph Security["Security Layer"]
            RBAC[Access Control]
            ENCRYPT[Data Encryption]
            AUDIT[Audit Logging]
        end
    end

    %% Data Layer
    subgraph DL["Data Layer"]
        direction LR
        subgraph Storage["Data Storage"]
            PG[(PostgreSQL)]
        end

        subgraph Files["File Storage"]
            S3[Object Storage]
            CDN[Content Delivery]
        end

        subgraph Search["Search Services"]
            ES[Search Engine]
            INDEX[Search Index]
        end
    end

    %% External Services at the same level as Backend
    subgraph EX["External Services"]
        direction LR
        MAPS[Maps API]
        CLOUD[Azure Services]
    end

    %% Define connections
    Client --> UI
    UI --> State
    FL --> CORS[**CORS**]
    CORS --> API
    API --> Services
    Services --> Security
    Services --> EX
    Security --> Storage
    Services --> Files
    Services --> Search

    %% Styling
    classDef frontendStyle fill:#e6f3ff,stroke:#333,stroke-width:2px
    classDef backendStyle fill:#f0fff0,stroke:#333,stroke-width:2px
    classDef dataStyle fill:#fff0f5,stroke:#333,stroke-width:2px
    classDef externalStyle fill:#fff6e6,stroke:#333,stroke-width:2px
    classDef componentStyle fill:#ffffff,stroke:#666,stroke-width:1px

    class FL frontendStyle
    class BL backendStyle
    class DL dataStyle
    class EX externalStyle
    class Client,UI,State,API,Services,Security,Storage,Files,Search,CORS componentStyle
