# AWS Terraform & Ansible Production Infrastructure

## 🚀 Overview

This repository contains a **production-ready AWS infrastructure** built using **Terraform** for provisioning and **Ansible (ansible-pull)** for configuration management.

The project demonstrates a real-world DevOps workflow where infrastructure is immutable, configuration is pulled automatically by instances, and applications are deployed as Docker containers behind a load balancer.

This setup closely mirrors how modern cloud-native teams deploy and manage infrastructure in production environments.

---

## 🏗️ Architecture

```
Internet
   |
   v
Application Load Balancer (ALB)
   |
   v
Auto Scaling Group (EC2)
   |
   v
Dockerized Application
   |
   v
Amazon RDS
```

**Key design principles:**

* Separation of public and private subnets
* Stateless EC2 instances
* Immutable infrastructure
* Infrastructure as Code (IaC)

---

## 🧰 Tech Stack

| Category                 | Tools                     |
| ------------------------ | ------------------------- |
| Infrastructure           | Terraform                 |
| Configuration Management | Ansible (ansible-pull)    |
| Cloud Provider           | AWS                       |
| Compute                  | EC2 (Auto Scaling Group)  |
| Networking               | VPC, Subnets, IGW, NAT    |
| Load Balancing           | Application Load Balancer |
| Database                 | Amazon RDS                |
| Containers               | Docker                    |
| CI/CD                    | GitHub Actions            |

---

## 📁 Repository Structure

```
.
├── terraform/
│   ├── prod/
│   ├── modules/
│   │   ├── networking/
│   │   ├── security_group/
│   │   ├── loadbalancer/
│   │   ├── autoscaling/
│   │   └── database/
│   └── global/
│
├── ansible/
│   ├── site.yml
│   ├── group_vars/
│   ├── roles/
│   │   ├── common/
│   │   ├── docker/
│   │   ├── app/
│   │   └── nginx/
│
├── scripts/
│   ├── deploy.sh
│   ├── destroy.sh
│   └── smoke_test.sh
│
└── .github/
    └── workflows/
        └── ci.yml
```

---

## 🔄 Deployment Flow

1. **Docker Image Build**

   * Application image is built locally or via CI
   * Image is pushed to Amazon ECR

2. **Infrastructure Provisioning**

   * Terraform provisions VPC, ALB, ASG, EC2, and RDS

3. **Instance Bootstrapping**

   * EC2 instances start with `user_data`
   * Ansible and Git are installed automatically

4. **Configuration Pull**

   * EC2 runs `ansible-pull`
   * Configuration is pulled directly from this repository

5. **Application Deployment**

   * Docker is installed
   * Application image is pulled from ECR
   * Container is started

6. **Traffic Routing**

   * ALB routes traffic to healthy EC2 instances

---

## 🧠 Why ansible-pull?

Instead of pushing configuration from a central machine, this project uses **ansible-pull**, where:

* Each EC2 instance pulls its own configuration
* No SSH access is required
* Instances are fully self-configuring

This approach scales naturally with Auto Scaling Groups and improves security.

---

## 🛠️ How to Deploy

### Prerequisites

* AWS Account
* Terraform >= 1.x
* AWS CLI configured
* Docker image pushed to ECR

### Deploy Infrastructure

```bash
cd terraform/prod
terraform init
terraform apply
```

### Destroy Infrastructure

```bash
terraform destroy
```

---

## 🔐 Security Considerations

* EC2 instances run in private subnets
* Only ALB is exposed to the internet
* RDS is accessible only from EC2 Security Group
* No credentials are hardcoded in application code

---

## 📌 Key Takeaways

* Real-world Infrastructure as Code project
* Production-like AWS architecture
* Clean separation of concerns
* Scalable and maintainable design

---

## 📄 License

This project is for educational and demonstration purposes.

---

## ✍️ Author
**Eslam El Sharkawy**
DevOps / Cloud Engineer
