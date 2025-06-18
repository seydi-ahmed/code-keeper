# 📘 Code Keeper – Questions & Réponses

## 🧠 Compréhension générale

**Q1 : Quel est le but du projet Code Keeper ?**  
R : Centraliser, versionner et déployer plusieurs microservices de manière automatisée, sécurisée et modulaire via GitLab CI/CD.

**Q2 : Quels types de services contient ce projet ?**  
R : Des services orientés commande, produits, utilisateurs, facturation, regroupés en microservices indépendants.

**Q3 : Quelle est l’architecture adoptée ?**  
R : Architecture microservices conteneurisée (Docker), orchestrée manuellement via GitLab CI/CD et provisionnée via Terraform.

**Q4 : Quelle est la stack technique ?**  
R : Python/Flask, Docker, GitLab CI/CD, Terraform, Ansible, PostgreSQL, Linux (Debian/Ubuntu).

**Q5 : Quelle est la finalité de l’utilisateur ?**  
R : Pouvoir exécuter un cycle complet de gestion de commandes via API (produits > commandes > factures).

---

## ⚙️ CI/CD avec GitLab

**Q6 : Comment sont structurés les pipelines GitLab ?**  
R : Chaque dépôt possède un `.gitlab-ci.yml` avec des stages (`build`, `test`, `scan`, `deploy_staging`, `deploy_prod`).

**Q7 : Quelle est la logique de déploiement ?**  
R : Automatique en staging, puis déclenchement manuel pour la production via un job avec `when: manual`.

**Q8 : Où sont stockées les images Docker ?**  
R : Dans le registre de container GitLab de chaque dépôt.

**Q9 : Comment se fait la communication entre les services ?**  
R : Via une API Gateway en reverse proxy + REST entre services.

---

## 🐳 Docker & Exécution

**Q10 : Chaque service possède-t-il un Dockerfile ?**  
R : Oui. Il définit l’environnement d’exécution, les dépendances et l’exécution du service.

**Q11 : Peut-on tout lancer en local ?**  
R : Oui, un fichier `docker-compose.yml` permet de tout démarrer localement pour développement ou test.

**Q12 : Les ports sont-ils exposés ?**  
R : Oui, chaque service a un port mappé à son rôle, mais le reverse proxy centralise les appels.

---

## 📦 Déploiement & Infrastructure

**Q13 : Comment est provisionnée l’infra ?**  
R : Avec Terraform. Les fichiers `.tf` définissent des ressources comme machines, volumes, sécurité.

**Q14 : Comment est déployé GitLab ?**  
R : Avec Ansible. Un playbook configure GitLab automatiquement sur une VM Linux.

**Q15 : Peut-on reproduire l’infrastructure ?**  
R : Oui, toute l’infra est déclarative. Une commande `terraform apply` permet de redéployer.

---

## 🔐 Sécurité

**Q16 : Où sont gérés les secrets ?**  
R : Dans GitLab CI/CD via les variables d’environnement (`CI/CD Settings > Variables`).

**Q17 : A-t-on des scans de vulnérabilité ?**  
R : Oui, certains pipelines incluent des scans de dépendances (optionnel selon service).

**Q18 : L’accès à GitLab est-il sécurisé ?**  
R : Oui, authentification SSH et HTTPS, comptes restreints et tokens pour les déploiements.

---

## 📘 Documentation & Utilisation

**Q19 : Comment démarrer un service ?**  
R : `docker-compose up` ou `docker build && docker run` dans le répertoire du service.

**Q20 : Comment tester l’API d’un service ?**  
R : Via Postman, curl, ou des scripts de test fournis dans certains dépôts.

**Q21 : Où se trouvent les endpoints de santé ?**  
R : `/health` ou `/status` selon les services, renvoient `200 OK`.

**Q22 : Que faire en cas d’erreur dans le pipeline ?**  
R : Vérifier le job qui échoue, corriger le code ou configuration, relancer manuellement.

---

## 🧪 Tests

**Q23 : Quels types de tests sont inclus ?**  
R : Des tests unitaires pour les services métier (commande, produit), appelés automatiquement en CI.

**Q24 : Comment exécuter les tests localement ?**  
R : `pytest` ou `python -m unittest` selon le service.

**Q25 : L'intégration est-elle testée ?**  
R : Partiellement via Docker Compose (staging), tests manuels simulant des appels inter-services.

---

## 🎓 Rétrospective

**Q26 : Quelle a été la partie la plus complexe ?**  
R : La coordination GitLab CI/CD avec Terraform et Docker, et le déploiement multi-étapes.

**Q27 : Quelles améliorations sont envisagées ?**  
R : Ajout de logs centralisés, d’un orchestrateur (comme Kubernetes), et de monitoring avec Prometheus/Grafana.

**Q28 : Ce projet est-il prêt pour la prod ?**  
R : Il est fonctionnel et déployable, mais nécessiterait une validation de sécurité plus poussée pour un usage public réel.

---