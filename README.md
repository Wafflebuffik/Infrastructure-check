# Infrastructure Check

Simple infrastructure validation environment built with **Docker** and **Bash automation**.

The project provides a containerized way to run infrastructure preparation and validation scripts in a reproducible environment.

It is designed as a small **DevOps practice project** demonstrating:

- Docker image building
- Bash scripting automation
- Git hooks for validation
- Reproducible infrastructure checks

---

# Project Goal

The goal of this project is to create a **lightweight infrastructure validation container** that:

- prepares a minimal environment
- installs required packages
- runs infrastructure validation scripts
- ensures reproducible execution across systems

This project also demonstrates **basic DevOps workflow automation**.

---

# Project Structure

```
Infrastructure-check
│
├── Dockerfile
├── src
│   └── requirements.sh
└── README.md
```

### Explanation

- **Dockerfile** – builds the runtime environment
- **src/requirements.sh** – infrastructure setup script
- **.git/hooks/pre-push** – Git hook used to validate container builds before pushing

---

# Requirements

Before running the project make sure you have installed:

- Docker
- Git
- Linux / WSL / macOS environment

Docker is required because the infrastructure checks are executed inside a container.

---

# Build the Docker Image

Clone the repository:

```bash
git clone https://github.com/Wafflebuffik/Infrastructure-check.git
cd Infrastructure-check
```

Build the Docker image:

```bash
docker build -t infrastructure-check .
```

---

# Run the Container

Run the container:

```bash
docker run infrastructure-check
```

Run it in background mode:

```bash
docker run -d infrastructure-check
```

View container logs:

```bash
docker logs <container_id>
```

---

# Bash Script

The main logic of the project is located in:

```
src/requirements.sh
```

The script performs infrastructure preparation tasks such as:

- installing required Linux packages
- preparing the environment
- validating dependencies

Example operations:

```bash
apt-get update
apt-get install -y curl git jq
```

This allows the container to simulate a **minimal infrastructure setup process**.

---

# Git Hook (pre-push)

This repository uses a **pre-push Git hook** to ensure that the Docker image builds correctly before code is pushed.

The hook performs:

1. Docker image build
2. Container execution test
3. Validation of successful execution

Example workflow:

```bash
git push
```

The hook automatically runs:

```bash
docker build .
docker run test-image
```

If the build fails, the push will be blocked.

This simulates a **local CI validation step**.

---

# Development Workflow

Typical workflow when contributing:

```bash
git clone repo
make changes
git commit
git push
```

During `git push`, the pre-push hook verifies that:

- Docker image builds correctly
- container runs successfully

This helps prevent broken builds from being pushed to the repository.

---

# Author

Created by **Marek Kaszuba**

DevOps / Infrastructure learning project.
