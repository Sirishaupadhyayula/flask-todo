# Flask Todo – End-to-End DevOps Project

A production-style **end-to-end DevOps project** demonstrating how a simple Flask application can be containerized, deployed to Kubernetes using Helm, and continuously delivered via Jenkins CI/CD — all running locally using **k3d**.

This project focuses on **real-world DevOps workflows**, not just “getting an app to run”.

---

## What This Project Demonstrates

- Docker image build & runtime initialization
- Kubernetes deployment using **Helm**
- Local Kubernetes using **k3d**
- Service exposure via **NodePort** and **Ingress**
- **NGINX Ingress Controller**
- Fully automated **CI/CD pipeline using Jenkins**
- Practical debugging of real issues (Docker socket permissions, kubeconfig context issues, probe failures, ingress routing)

---

## Architecture Overview

```
Developer Commit
     |
     v
GitHub Repository
     |
     v
Jenkins CI/CD
  - Build Docker Image
  - Push to Docker Hub
  - Helm Upgrade
     |
     v
Kubernetes (k3d)
  - Deployment (Flask + Gunicorn)
  - Service (ClusterIP)
  - Ingress (NGINX)
     |
     v
Browser (flask-todo.local)

```
---

## 🧰 Tech Stack

| Layer | Technology |
|-----|-----------|
| Application | Python, Flask, Gunicorn |
| Containerization | Docker |
| Orchestration | Kubernetes (k3d / k3s) |
| Packaging | Helm |
| CI/CD | Jenkins |
| Networking | NodePort, NGINX Ingress |
| Registry | Docker Hub |

---

## 📦 Application Runtime

- Flask app served via **Gunicorn**
- Container startup handled by a custom entrypoint script
- Database tables initialized automatically at container startup
- Uses SQLite **for practice purposes**

> ⚠️ SQLite is intentionally used only for learning.  
> In production, this would be replaced with an external database (Postgres/MySQL).

---

## 🐳 Docker Highlights

- Lightweight base image (`python:3.11-slim`)
- No manual container commands required
- Application starts automatically
- Image published to Docker Hub

---

## ☸️ Kubernetes (k3d)

- Local Kubernetes cluster using **k3d**
- Load balancer ports mapped to host
- Clean cluster recreation used during troubleshooting
- Real Kubernetes primitives: Deployment, Service, Ingress

---

## 📦 Helm Chart Design

- Custom Helm chart (not default boilerplate)
- Parameterized configuration:
  - Image repository & tag
  - Service type
  - Ingress enablement
- Supports:
  - NodePort (for direct access)
  - Ingress (for clean URLs)

---

## 🌐 Service Exposure

### Option 1: NodePort
- Exposes service on a fixed port
- Useful for quick testing

### Option 2: Ingress (Recommended)
- NGINX Ingress Controller
- Host-based routing
- Clean URL:  
  **http://flask-todo.local**

> `/etc/hosts` is used locally for DNS mapping.  
> In production, this would be replaced with real DNS + LoadBalancer.

---

## 🔁 Jenkins CI/CD Pipeline

The Jenkins pipeline automates:

1. Docker image build
2. Image push to Docker Hub
3. Helm upgrade on Kubernetes
4. Rolling update of pods

### Key CI/CD Learnings
- Docker socket permissions inside Jenkins container
- Installing Docker CLI, kubectl, and Helm in Jenkins
- Mounting kubeconfig into Jenkins correctly
- Managing Kubernetes context inside CI pipelines

---

## 🧪 Real Issues Solved (Not Toy Problems)

This project intentionally includes **real DevOps debugging scenarios**, including:

- `docker: permission denied` inside Jenkins
- `kubectl` context mismatch after cluster recreation
- NodePort unreachable due to missing k3d port mapping
- Liveness/readiness probe misconfiguration
- Ingress returning 404 due to host mismatch
- Traefik vs NGINX ingress behavior in k3s

Each issue was debugged and fixed step-by-step.

---

## 📁 Repository Structure


     ├── app.py

     ├── start.sh

     ├── Dockerfile

     ├── requirements.txt

     ├── helm/

     │   └── flask-todo/

     │       ├── templates/

     │       ├── values.yaml

     │       └── Chart.yaml

     ├── Jenkinsfile

     └── README.md


---

## 🎯 Why This Project Matters

This project is **not about Flask**.

It’s about:

- Designing a real deployment flow
- Understanding Kubernetes networking
- Writing Helm charts that actually work
- Running CI/CD against a real cluster
- Debugging what breaks in real DevOps environments

---

## 🚀 Future Enhancements

- External database (Postgres)
- Persistent volumes
- TLS via cert-manager
- Multi-environment Helm values
- Migration to EKS / GKE

---

## 👤 Author

**Rupa Sai Mithra Sirisha Upadhyayula**  
DevOps / Cloud / Platform Engineering

