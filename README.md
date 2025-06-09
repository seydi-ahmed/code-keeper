# code-keeper
Le projet Code-Keeper demande la mise en place d'une solution DevOps complète pour une application microservices, avec les exigences suivantes:

## Infrastructure et configuration 
- Déploiement de GitLab : Utilisation d'Ansible pour automatiser l'installation et la configuration d'une instance GitLab
- Configuration des GitLab Runners : Pour exécuter les pipelines CI/CD
- Choix de cloud : AWS, Azure ou Google Cloud (ou environnement local)

## Organisation du code
- Séparation en 4 dépôts distincts:
  - 1 dépôt pour l'infrastructure (Terraform)
  - 3 dépôts pour les microservices (inventory-app, billing-app api-gateway-app)
- Migration du code crud-master vers cette nouvelle structure

## Pipeline d'Infrastructure (Terraform)
- Stages:
  - Init: Initialisation Terraform
  - Validate: Validation syntaxique
  - Plan: Prévisualisation des changements
  - Apply to Staging: Déploiement staging
  - Approval: Validation manuelle
  - Apply to Production: Déploiement production

## Pipeline CI pour chaque microservice
- Stages:
  - Build: Compilation
  - Test: Tests unitaires/intégration
  - Scan: Analyse de sécurité (SonarQube, Snyk...)
  - Containerization: Création et push d'images Docker

## Pipeline CD pour chaque microservice
- Stages:
  - Deploy to Staging: Déploiement environnement staging
  - Approval: Validation manuelle
  - Deploy to Production: Déploiement production avec zéro downtim

## Aspects sécurité
- Branches protégées
- Gestion sécurisée des secrets
- Principe du moindre privilège
- Mises à jour régulières

## Documentation
- README.md complet expliquant:
- Prérequis
- Configuration
- Setup
- Usage

## Bonus possibles
- Scan sécurité avec tfsec
- Estimation coûts avec Infracost
- Utilisation de Terragrunt
- Personnalisation du code crud-master