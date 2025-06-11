git config --global user.email "seydiahmedelcheikh@gmail.com"
git config --global user.name "mouhameddiouf"
git config credential.helper store
git add .
git commit -m "
Service -->                                     Rôle
puma -->                                        Serveur web Rails de GitLab (API / interface web)
sidekiq -->                                     Exécute les tâches de fond (CI, jobs, etc.)
postgresql -->                                  Base de données
redis -->                                       Cache, sessions
nginx -->                                       Serveur web frontal (reverse proxy)
gitlab-workhorse -->	                        Proxy entre Nginx et Rails
gitaly -->	                                    Gère l'accès aux dépôts Git
gitlab-kas -->	                                GitLab Agent Server (pour Kubernetes)
prometheus, alertmanager, exporters -->         Monitoring
logrotate -->                                   Gère les fichiers de log
"
git push --force
