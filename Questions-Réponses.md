# C'est quoi un fichier .gitlab-ci.yml?
- C’est un fichier de configuration utilisé par GitLab CI/CD. Il décrit toutes les étapes (jobs) que GitLab doit exécuter automatiquement quand tu pushes du code.
- Il permet d'automatiser:
    - Les tests de ton code.
    - La construction de l'image Docker.
    - Le scan de sécurité.
    - Le déploiement dans un environnement (staging, prod...).