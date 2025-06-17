git config --global user.email "seydiahmedelcheikh@gmail.com"
git config --global user.name "mouhameddiouf"
git config credential.helper store
git add .
git commit -m "
│ Error: Unreadable module directory
│ 
│ Unable to evaluate directory symlink: lstat ../../modules/vpc/modules: no such file or directory
╵
╷
│ Error: Unreadable module directory
│ 
│ The directory  could not be read for module "app" at ../../modules/vpc/main.tf:22.
╵
╷
│ Error: Unreadable module directory
│ 
│ Unable to evaluate directory symlink: lstat ../../modules/vpc/modules: no such file or directory
╵
╷
│ Error: Unreadable module directory
│ 
│ The directory  could not be read for module "db" at ../../modules/vpc/main.tf:10.
╵
╷
│ Error: Unreadable module directory
│ 
│ Unable to evaluate directory symlink: lstat ../../modules/vpc/modules: no such file or directory
╵
╷
│ Error: Unreadable module directory
│ 
│ The directory  could not be read for module "vpc" at ../../modules/vpc/main.tf:1.
"
git push --force
