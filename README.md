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

## Démarrer la VM et Exécuter le playbook:
- vagrant up
- vagrant ssh
```
sudo apt update
sudo apt install python3-pip -y
pip3 install ansible --upgrade
```
- export PATH=$HOME/.local/bin:$PATH
- ansible --version
- ansible-playbook -i /vagrant/hosts /vagrant/install_gitlab.yml
- reconfigurer GitLab
  - sudo gitlab-ctl reconfigure
- Vérifie l'état de GitLab:
  - sudo gitlab-ctl status

