# code-keeper
Le projet Code-Keeper demande la mise en place d'une solution DevOps complète pour une application microservices, avec les exigences suivantes:

### Infrastructure et configuration 
- Déploiement de GitLab : Utilisation d'Ansible pour automatiser l'installation et la configuration d'une instance GitLab
- Configuration des GitLab Runners : Pour exécuter les pipelines CI/CD
- Choix de cloud : AWS, Azure ou Google Cloud (ou environnement local)

### Organisation du code
- Séparation en 4 dépôts distincts:
  - 1 dépôt pour l'infrastructure (Terraform)
  - 3 dépôts pour les microservices (inventory-app, billing-app api-gateway-app)
- Migration du code crud-master vers cette nouvelle structure

### Pipeline d'Infrastructure (Terraform)
- Stages:
  - Init: Initialisation Terraform
  - Validate: Validation syntaxique
  - Plan: Prévisualisation des changements
  - Apply to Staging: Déploiement staging
  - Approval: Validation manuelle
  - Apply to Production: Déploiement production

### Pipeline CI pour chaque microservice
- Stages:
  - Build: Compilation
  - Test: Tests unitaires/intégration
  - Scan: Analyse de sécurité (SonarQube, Snyk...)
  - Containerization: Création et push d'images Docker

### Pipeline CD pour chaque microservice
- Stages:
  - Deploy to Staging: Déploiement environnement staging
  - Approval: Validation manuelle
  - Deploy to Production: Déploiement production avec zéro downtim

### Aspects sécurité
- Branches protégées
- Gestion sécurisée des secrets
- Principe du moindre privilège
- Mises à jour régulières

### Documentation
- README.md complet expliquant:
- Prérequis
- Configuration
- Setup
- Usage

### Bonus possibles
- Scan sécurité avec tfsec
- Estimation coûts avec Infracost
- Utilisation de Terragrunt
- Personnalisation du code crud-master

## Structure
```
code-keeper/
├── .gitlab-ci.yml                    # Configuration principale des pipelines
├── README.md                         # Documentation principale
├── ansible/
│   ├── playbooks/
│   │   └── deploy-gitlab.yml         # Playbook pour déployer GitLab
│   ├── inventories/                  # Inventaires Ansible
│   └── roles/                        # Rôles Ansible
├── infrastructure/                    # Dépôt séparé pour l'infra
│   ├── modules/                      # Modules Terraform réutilisables
│   ├── staging/                      # Configuration pour staging
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   └── outputs.tf
│   ├── production/                   # Configuration pour production
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   └── outputs.tf
│   └── .gitlab-ci.yml                # Pipeline spécifique à l'infra
├── inventory-app/                     # Dépôt séparé
│   ├── src/                          # Code de l'application
│   ├── tests/                        # Tests
│   ├── Dockerfile                    # Configuration Docker
│   ├── .gitlab-ci.yml                # Pipeline CI/CD spécifique
│   └── README.md                     # Documentation spécifique
├── billing-app/                       # Dépôt séparé
│   ├── src/                          # Code de l'application
│   ├── tests/                        # Tests
│   ├── Dockerfile                    # Configuration Docker
│   ├── .gitlab-ci.yml                # Pipeline CI/CD spécifique
│   └── README.md                     # Documentation spécifique
└── api-gateway-app/                   # Dépôt séparé
    ├── src/                          # Code de l'application
    ├── tests/                        # Tests
    ├── Dockerfile                    # Configuration Docker
    ├── .gitlab-ci.yml                # Pipeline CI/CD spécifique
    └── README.md                     # Documentation spécifique
```

### Explication de la structure:
1. Ansible:
- Contient tout ce qui concerne le déploiement automatisé de GitLab
- Playbooks, rôles et inventaires séparés pour une meilleure organisation
2. Infrastructure (dépôt séparé):
- Configuration Terraform pour les environnements staging et production
- Modules réutilisables pour éviter la duplication
- Pipeline spécifique pour gérer l'infrastructure
3. Microservices (3 dépôts séparés):
- Chaque service a sa propre structure avec:
  - Code source
  - Tests
  - Configuration Docker
  - Pipeline CI/CD spécifique
  - Documentation
4. Fichiers racine:
- Configuration globale des pipelines
- Documentation principale du projet
5. Cette structure permet:
- Une séparation claire des responsabilités
- Une meilleure maintenabilité
- Une indépendance des microservices
- Une gestion distincte de l'infrastructure

## Créer le réseau commun pour les conteneurs:
- docker network create microservice-net

## Lancer les bases de données PostgreSQL
- Inventory Database (port 5433 externe pour éviter conflit local)
```
docker run -d \
  --name inventory-db \
  --network microservice-net \
  -e POSTGRES_USER=inventory_user \
  -e POSTGRES_PASSWORD=inventory_pass \
  -e POSTGRES_DB=inventory_db \
  -p 5433:5432 \
  postgres:13
```

- Billing Database (port 5434 externe)
```
docker run -d \
  --name billing-db \
  --network microservice-net \
  -e POSTGRES_USER=billing_user \
  -e POSTGRES_PASSWORD=billing_pass \
  -e POSTGRES_DB=billing_db \
  -p 5434:5432 \
  postgres:13
```

## Lancer RabbitMQ (interface admin accessible en local sur 15672)
```
docker run -d \
  --name rabbitmq \
  --network microservice-net \
  -e RABBITMQ_DEFAULT_USER=user \
  -e RABBITMQ_DEFAULT_PASS=pass \
  -p 5672:5672 \
  -p 15672:15672 \
  rabbitmq:3-management
```

## Construire les images
```
docker build -t inventory-app ./inventory-app
docker build -t billing-app ./billing-app
docker build -t api-gateway-app ./api-gateway-app
```

## Lancer les applications
- Inventory App
```
docker run -d \
  --name inventory-app \
  --network microservice-net \
  -e DB_HOST=inventory-db \
  -e DB_PORT=5432 \
  -e DB_USER=inventory_user \
  -e DB_PASSWORD=inventory_pass \
  -e DB_NAME=inventory_db \
  -p 8081:8080 \
  inventory-app
```

- Billing App
```
docker run -d \
  --name billing-app \
  --network microservice-net \
  -e DB_HOST=billing-db \
  -e DB_PORT=5432 \
  -e DB_USER=billing_user \
  -e DB_PASSWORD=billing_pass \
  -e DB_NAME=billing_db \
  -e RABBITMQ_HOST=rabbitmq \
  -e RABBITMQ_USER=user \
  -e RABBITMQ_PASS=pass \
  -p 8082:8080 \
  billing-app
```

- API Gateway App
```
docker run -d \
  --name api-gateway-app \
  --network microservice-net \
  -e INVENTORY_URL=http://inventory-app:8080 \
  -e BILLING_URL=http://billing-app:8080 \
  -p 3000:3000 \
  api-gateway-app
```