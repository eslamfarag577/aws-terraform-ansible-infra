# 🚀 AWS Terraform + Ansible Infrastructure Automation

This repository demonstrates a **production-style infrastructure automation project** using **Terraform**, **Ansible (Pull-based)**, **Docker**, and **Nginx** on **AWS**.

The project provisions cloud infrastructure and deploys a Flask API application in a **fully automated, self-configuring EC2 environment**, following real-world DevOps best practices.

---

## 📌 Project Goals

* Automate AWS infrastructure using Terraform
* Use **Ansible Pull** for self-bootstrap configuration
* Run application inside Docker containers
* Use Nginx as a reverse proxy
* Support Auto Scaling–friendly design
* Follow Infrastructure as Code (IaC) principles

---

## 🧱 Architecture Overview

```
Internet
   |
   v
Application Load Balancer (ALB)
   |
   v
EC2 Auto Scaling Group
   |
   ├─ Docker Container (Flask App)
   └─ Nginx (Reverse Proxy)
   |
   v
(Optional) Amazon RDS
```

---

## 🔄 High-Level Flow (End-to-End)

```
1) Build Docker image locally or via CI
2) Push image to Amazon ECR
3) Terraform provisions AWS resources
4) EC2 starts → user_data executes
5) ansible-pull runs on the instance
6) Ansible installs Docker, runs container, configures Nginx
7) ALB routes traffic to EC2
```

---

## 🛠️ Tools & Technologies

| Tool         | Purpose                      |
| ------------ | ---------------------------- |
| Terraform    | Provision AWS infrastructure |
| Ansible      | Configuration management     |
| Ansible Pull | Self-bootstrap EC2 instances |
| Docker       | Application runtime          |
| Nginx        | Reverse proxy                |
| AWS EC2      | Compute                      |
| AWS ALB      | Traffic routing              |
| AWS RDS      | Database (optional)          |

---

## 📁 Repository Structure

```
aws-terraform-ansible-infra/
├─ ansible/
│  ├─ site.yml
│  ├─ group_vars/
│  │  └─ all.yml
│  └─ roles/
│     ├─ common/
│     │  ├─ tasks/main.yml
│     │  └─ handlers/main.yml
│     ├─ docker/
│     │  └─ tasks/main.yml
│     ├─ app/
│     │  ├─ tasks/main.yml
│     │  └─ templates/.env.j2
│     └─ nginx/
│        ├─ tasks/main.yml
│        ├─ handlers/main.yml
│        └─ templates/nginx.conf.j2
│
├─ terraform/
│  ├─ global/
│  ├─ modules/
│  │  ├─ networking/
│  │  ├─ security_group/
│  │  ├─ loadbalancer/
│  │  ├─ autoscaling/
│  │  └─ database/
│  └─ prod/
│
└─ README.md
```

---

## 🧠 Key Design Decision: Ansible Pull

Instead of using Ansible in **push mode**, this project uses **pull mode**.

### Why Ansible Pull?

* Ideal for Auto Scaling
* No central control node
* Each EC2 instance configures itself
* Immutable & reproducible servers

### user_data Script Example

```bash
#!/bin/bash
apt update
apt install -y ansible git

ansible-pull \
  -U https://github.com/eslamfarag577/aws-terraform-ansible-infra.git \
  -i localhost, \
  ansible/site.yml
```

---

## ⚙️ Ansible Roles Explained

### 🔹 common

* System updates
* User creation
* SSH hardening
* Disable root login & password auth

### 🔹 docker

* Install Docker (official repo)
* Install docker-compose plugin
* Enable Docker service
* Add user to docker group

### 🔹 app

* Create `/opt/app`
* Render `.env` file from template
* Pull Docker image
* Run container with restart policy

### 🔹 nginx

* Install Nginx
* Remove default config
* Configure reverse proxy
* Restart service on changes

---

## 🌱 Environment Variables (.env)

The application uses environment variables injected via Ansible:

```env
APP_ENV=prod
APP_PORT=8080

DB_HOST=*****rds-endpoint
DB_PORT=5432
DB_NAME=terraform
DB_USER=esla,
DB_PASS=*******
```

---

## 🧪 Validation

After deployment, open:

```
http://<EC2_PUBLIC_IP>
```

or (local test):

```
curl http://localhost
```

Expected response:

```json
{
  "env": "prod",
  "service": "flask-rds-demo",
  "status": "ok"
}
```

---

## 🛡️ Security Considerations

* SSH root login disabled
* Password authentication disabled
* Only port 80 exposed publicly
* Internal app port (8080) not exposed
* Docker runs as non-root user

---

## 📈 Best Practices Applied

✅ Infrastructure as Code
✅ Idempotent Ansible roles
✅ Pull-based configuration
✅ Stateless application design
✅ Auto Scaling ready

---

## 📄 Use Cases

* DevOps Portfolio Project
* Interview Demonstration
* Learning Terraform + Ansible
* Production-ready reference architecture

---

## 🧾 License

MIT License

---

## 🙌 Author

**Eslam Farag**
DevOps / Cloud Engineer

GitHub: [https://github.com/eslamfarag577](https://github.com/eslamfarag577)

---

## 🔮 Possible Improvements

* Add HTTPS via ACM
* Add CI/CD with GitHub Actions
* Use AWS Secrets Manager
* Add CloudWatch logging
* Enable blue/green deployments

---

🚀 **This project represents a real-world DevOps workflow, not a tutorial demo.**
