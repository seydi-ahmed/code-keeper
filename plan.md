# ✅ ÉTAPE 1 – CI/CD: Vérifie que les pipelines tournent sur GitLab
- Objectif: que chaque projet exécute son .gitlab-ci.yml.
  - Va sur GitLab > chaque dépôt > CI/CD > Pipelines
  - Vérifie que le pipeline se lance après un push
  - Résous les erreurs si besoin (je peux t’aider pour ça)
- 👉 Si tout est vert ✅ : passe à l'étape suivante.

****************************************
****************************************

# ✅ ÉTAPE 2 – Docker: Tester chaque microservice localement
- Objectif: s'assurer que tes services sont bien conteneurisés.
- Dans chaque dossier (api-gateway-app, billing-app, etc.):
```
docker build -t mon-service .
docker run -p 5000:5000 mon-service
```
- Teste avec curl ou un navigateur.
- Corrige si une app ne démarre pas.

****************************************
****************************************

# ✅ ÉTAPE 3 – Vagrant (ou Ansible local): déployer GitLab Auto-hébergé
- Objectif: simuler un environnement de prod.
- Dans gitlab-ansible-deploy/:
```
vagrant up
vagrant ssh
ansible-playbook -i hosts install_gitlab.yml
```
- 💡 Assure-toi que tu as bien ansible installé, ou utilise une VM Ubuntu.

****************************************
****************************************

# ✅ ÉTAPE 4 – Terraform: Provisonner ton infra cloud simulée
- Objectif: créer une infra (VMs, DB, réseau) avec Terraform.
- Dans infrastructure-config/:
```
cd environments/staging
terraform init
terraform validate
terraform plan
terraform apply
```
- Cela va créer:
  - des ressources de staging (mock cloud ou localstack)
  - que tu peux adapter à AWS ou OpenStack

****************************************
****************************************

# ✅ ÉTAPE 5 – Déploiement automatique
- Tu dois relier:
  - les pipelines CI (build des images Docker)
  - au déploiement automatique (via Ansible/Terraform)
- À faire:
  - Soit dans les jobs deploy de chaque .gitlab-ci.yml
  - Soit via un dépôt central (gitlab-ansible-deploy) qui fait le ansible-playbook ou terraform apply automatiquement

****************************************
****************************************

# ✅ ÉTAPE 6 – Documentation
- Prépare un fichier README.md global (ou Questions-Réponses.md) avec:
  - architecture (schéma)
  - explication des dossiers
  - comment tester
  - comment déployer
  - outils utilisés

****************************************
****************************************

# 🔚 Tu auras terminé ton projet quand:
- Chaque microservice fonctionne dans un conteneur Docker
- Chaque dépôt exécute son pipeline GitLab CI/CD
- GitLab auto-hébergé (ou distant) fonctionne via Ansible
- L’infrastructure est provisionnée via Terraform
- Le déploiement est automatisé
- Tu as une bonne documentation

****************************************
****************************************

# Préparer une démo ou README self-contained avec:
- 🎯 Objectif du projet
- 🧱 Architecture (avec lien ou image)
- ⚙️ Commandes pour lancer/tester
- 📦 Outils utilisés (Docker, GitLab, Ansible, Terraform, etc.)
- 🧪 Comment tester que tout fonctionne

****************************************
****************************************

# Plan de remplissage

| Étape | Fichier                    | Description                             |
| ----- | -------------------------- | --------------------------------------- |
| ✅ 1   | `backend.tf`               | Configuration du remote backend         |
| ✅ 2   | `variables.tf` global      | Variables réutilisables                 |
| ✅ 3   | `modules/vpc/`             | Création VPC, subnets, IGW              |
| ✅ 4   | `modules/db/`              | Création base de données (RDS ou autre) |
| ✅ 5   | `modules/app/`             | Création cluster EKS ou instance app    |
| ✅ 6   | `main.tf` global           | Appel des modules                       |
| ✅ 7   | `outputs.tf` global        | Sorties globales                        |
| ✅ 8   | `environments/staging/`    | Appels + tfvars                         |
| ✅ 9   | `environments/production/` | Appels + tfvars                         |

****************************************
****************************************

# Backend

| Ressource        | Valeur                |
| ---------------- | --------------------- |
| 🪣 S3 Bucket     | `my-terraform-states` |
| 📋 DynamoDB Lock | `terraform-locks`     |
| 🌍 Région AWS    | `eu-west-3` (Paris) |


- Access Key ID:            AKIAQZFG5DO6Q6DTAQVK
- Clé d'accès secrète:      sMGLA8/c/y4FdG3duTz3YwZFNsMAMKhKQSv5oWWu
```
cat modules/app/main.tf
cat modules/app/variables.tf
cat modules/app/outputs.tf
cat modules/db/main.tf
cat modules/db/outputs.tf
cat modules/db/variables.tf
cat modules/vpc/main.tf
cat modules/vpc/outputs.tf
cat modules/vpc/variables.tf
```