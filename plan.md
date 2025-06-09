# Phase 1: Préparation et Initialisation
##  Création des dépôts GitLab
### Dépôt Infrastructure
- Nom: code-keeper-infra
- Contenu: Configuration Terraform pour staging/production
- Structure:
```
code-keeper-infra/
├── modules/          # Modules partagés (VPC, DB, Kubernetes, etc.)
├── staging/          # Environnement staging
├── production/       # Environnement production
└── .gitlab-ci.yml    # Pipeline Terraform (init, validate, plan, apply)
```
### Dépôts Microservices
- inventory-app → Code + Dockerfile + CI/CD
- billing-app → Code + Dockerfile + CI/CD
- api-gateway-app → Code + Dockerfile + CI/CD
### Dépôt Ansible (Optionnel)
- Nom: code-keeper-ansible
- Contenu: Playbooks pour déployer GitLab et les runners

## Configuration de GitLab
### Déployer GitLab avec Ansible
- Utiliser le playbook deploy-gitlab.yml pour installer :
```
- name: Install GitLab
  hosts: gitlab_servers
  tasks:
    - name: Add GitLab repo
      apt_repository:
        repo: "deb https://packages.gitlab.com/gitlab/gitlab-ce/ubuntu focal main"
        key_url: "https://packages.gitlab.com/gitlab/gitlab-ce/gpgkey"
```
### Configurer les Runners
- Installer GitLab Runner en mode docker ou kubernetes.
- Enregistrer les runners avec:
```
sudo gitlab-runner register --url "https://gitlab.example.com" --token "PROJECT_TOKEN"
```

**************************************************************
**************************************************************

# Phase 2: Infrastructure as Code (Terraform)
## Définir l'infrastructure cloud
### Créer les modules Terraform
- Exemple: modules/ec2 pour les instances, modules/rds pour les bases de données.
### Configurer les environnements
- Staging (staging/main.tf):
```
module "inventory_app" {
  source = "../modules/ec2"
  env    = "staging"
}
```
- Production (production/main.tf) :
```
module "inventory_app" {
  source = "../modules/ec2"
  env    = "production"
}
```
### Pipeline Terraform (.gitlab-ci.yml)
```
stages:
  - init
  - validate
  - plan
  - deploy_staging
  - approval
  - deploy_prod

terraform_init:
  stage: init
  script: terraform init

terraform_validate:
  stage: validate
  script: terraform validate
```

**************************************************************
**************************************************************


# Phase 3: CI/CD pour les Microservices
## Pipeline CI (Build, Test, Scan)
- Exemple pour inventory-app (.gitlab-ci.yml):
```
yaml
stages:
  - build
  - test
  - scan
  - dockerize

build:
  stage: build
  script: python -m pip install -r requirements.txt

test:
  stage: test
  script: pytest tests/

sonarqube_scan:
  stage: scan
  image: sonarsource/sonar-scanner-cli
  script: sonar-scanner -Dsonar.login=$SONAR_TOKEN
```
## Pipeline CD (Déploiement Staging → Production)
### Déploiement Staging
```
deploy_staging:
  stage: deploy
  environment: staging
  script: kubectl apply -f k8s/staging.yaml
  only: main
```
### Approbation manuelle
```
deploy_prod:
  stage: deploy
  environment: production
  script: kubectl apply -f k8s/production.yaml
  when: manual
```

**************************************************************
**************************************************************


# Phase 4: Sécurité et Optimisation
## Bonnes Pratiques Sécurité
- Secrets Management: Utiliser GitLab Variables ou HashiCorp Vault.
- Least Privilege: Restreindre les permissions IAM dans Terraform.
- Scan des Containers: Intégrer Trivy ou Clair dans le pipeline.

## Documentation
- README.md doit inclure:
    - Prérequis (Terraform, Ansible, Docker)
    - Étapes de déploiement
    - Schéma d’architecture

# Résumé des Étapes Clés
1. Créer les dépôts GitLab (infra + 3 microservices).
2. Déployer GitLab et les runners avec Ansible.
3. Coder l’infrastructure avec Terraform (staging/prod).
4. Configurer les pipelines CI/CD pour chaque microservice.
5. Ajouter la sécurité (scan, secrets, IAM).
6. Documenter et tester.