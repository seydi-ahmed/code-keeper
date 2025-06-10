git config --global user.email "seydiahmedelcheikh@gmail.com"
git config --global user.name "mouhameddiouf"
git config credential.helper store
git add .
git commit -m "
Dépôt gitlab 'passed'
1) api-gateway-app
2) billing-app
3) inventory-app
4) infrastructure-config
5) gitlab-ansible-deploy
6) postgres-db
7) rabbitmq
"
git push --force
