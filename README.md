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




**********************************
**********************************
