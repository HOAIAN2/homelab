# Homelab

A simple setup for my homelab using `docker-compose`.

## Requirements

1. Install [Docker](https://docs.docker.com/engine/install/)
2. Database backup tool (optional) [mysql-backup](https://github.com/HOAIAN2/mysql-backup)

## Usage

### Clone this repository

```bash
git clone https://github.com/HOAIAN2/homelab.git
```

### Deploy a service

Each service is a simple `docker-compose` setup. Just create `.env` file base on `.env.example` and change some variable if needed and run `docker compose up -d`.

### Port mapping rules

Every service uses `network_mode: bridge`. Each service runs on its own port, except for web services. If a service is a web service, the port should not map to `80` and should map to something like `8080`, `8081`, etc.
