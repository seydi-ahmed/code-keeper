# Cours Clés à Suivre:
- "Introduction to the AWS Management Console" (1h) → Découverte de l'interface AWS.
- "Getting Started with Compute/Security/Networking" (2h chacun) → Bases des services AWS (EC2, IAM, VPC).
- "AWS Cloud Practitioner Essentials" (si disponible) → Le plus important !

# Bonus:
- "Introduction to Cloud 101" (3h) → Théorie du cloud.
- "AWS Sustainability in the Cloud" (1.5h) → Comprendre les coûts/éco-responsabilité.

*************************************
*************************************

# Notes pour Aws Cloud Practitioner:
## Renommer:
1) Accédez à votre compartiment:
- Ouvrez la Console AWS S3
- Sélectionnez le compartiment website-bucket-xxxxxxx
- Cochez la case à côté de index.html
- Cliquez sur "Actions" > "Renommer"
- Permissions (Autorisations) --> EN bas "Effet - Allow"
- Static website hosting --> Modifier:
    --> enable
    --> host a static website
- index document:
    --> ancien nom
    --> nouveau nom

## Second part:
- S3 --> cloud-first-steps-xxxx --> userdata.txt --> open --> VÉRIFIER
                                                 --> Download --> Return S3 --> EC2 --> launch instance --> Quick Start (Amazon linux AWS)
                                                 --> instance type (compare instance type) --> t3.micro --> Get advice
                                                 --> key pair (key pair name) --> Proceded with a key pair
                                                 --> vpc (cloud-first-step/LabVpc)
                                                 --> subnet (cloud-first-step/LabVpc)
                                                 --> security group name (Lab-SG) --> Description (HTTP Security Group) --> Type (HTTP)
                                                 --> configure storage (gp3) --> advanced details (choose file) --> launch instance --> view all instances
                                                 --> actualiser --> webserver01 (running) --> public ipv4 dns