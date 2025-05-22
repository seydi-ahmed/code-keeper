# Cloud-Design

## Ce qu'on a ajouté par rapport au projet précédent

### 🔧 Infrastructure (Terraform) – terraform/
- Gère le cluster EKS, le réseau (VPC), les groupes de nœuds, et les IAM roles
- Dossier eks/ pour le cluster EKS
- Dossier networking/ pour VPC + sécurité

### ☁️ Manifests spécifiques EKS – eks-manifests/
- alb-ingress.yaml: ingress via AWS Load Balancer Controller
- external-secrets.yaml: secrets gérés par AWS Secrets Manager
- eks-sa.yaml: IAM roles pour ServiceAccounts
- kustomization.yaml (si tu utilises kustomize)

### 📊 Monitoring AWS/K8s – monitoring/
- Prometheus / Grafana configs (*-values.yaml)
- Agent CloudWatch: cloudwatch-agent-config.json

### 🐳 Dockerfiles – Dockerfiles/
- Centralisation des fichiers de build pour chaque service
