# 🐳 GiftLink Docker Deployment Guide

## Prerequisites
- Docker Desktop installed and running
- Docker Hub account
- Git (optional)

## 🚀 Quick Start

### 1. Build and Push to Docker Hub

#### Windows (PowerShell):
```powershell
# Edit build-and-push.ps1 and replace "your-dockerhub-username" with your actual username
.\build-and-push.ps1
```

#### Linux/Mac (Bash):
```bash
# Make script executable
chmod +x build-and-push.sh

# Edit build-and-push.sh and replace "your-dockerhub-username" with your actual username
./build-and-push.sh
```

### 2. Run Locally with Docker Compose

#### Development (builds locally):
```bash
docker-compose up -d
```

#### Production (uses Docker Hub images):
```bash
# Edit docker-compose.prod.yml and replace "your-dockerhub-username"
docker-compose -f docker-compose.prod.yml up -d
```

## 📋 Manual Steps

### 1. Build Images Manually

```bash
# Backend
docker build -t your-username/giftlink-backend:latest ./giftlink-backend

# Frontend
docker build -t your-username/giftlink-frontend:latest ./giftlink-frontend
```

### 2. Push to Docker Hub

```bash
# Login
docker login

# Push images
docker push your-username/giftlink-backend:latest
docker push your-username/giftlink-frontend:latest
```

### 3. Run Individual Containers

```bash
# MongoDB
docker run -d --name mongodb \
  -e MONGO_INITDB_ROOT_USERNAME=belvi \
  -e MONGO_INITDB_ROOT_PASSWORD=belvi123 \
  -p 27017:27017 \
  mongo:6-alpine

# Backend
docker run -d --name backend \
  -e MONGO_URL=mongodb://belvi:belvi123@mongodb:27017/giftsdb \
  -e JWT_SECRET=mySecretKey123912738aopsgjnspkmndfsopkvajoirjg94gf2opfng2moknm \
  -p 3060:3060 \
  --link mongodb \
  your-username/giftlink-backend:latest

# Frontend
docker run -d --name frontend \
  -p 80:80 \
  --link backend \
  your-username/giftlink-frontend:latest
```

## 🔧 Configuration

### Environment Variables

Create a `.env` file for production:

```env
MONGO_USERNAME=your_mongo_user
MONGO_PASSWORD=your_secure_password
JWT_SECRET=your_very_secure_jwt_secret_key_here
```

### Ports
- Frontend: http://localhost (port 80)
- Backend API: http://localhost:3060
- MongoDB: localhost:27017

## 🛠️ Troubleshooting

### Check container logs:
```bash
docker-compose logs -f [service-name]
```

### Restart services:
```bash
docker-compose restart [service-name]
```

### Clean up:
```bash
# Stop and remove containers
docker-compose down

# Remove volumes (⚠️ This will delete database data)
docker-compose down -v

# Remove images
docker rmi your-username/giftlink-backend:latest
docker rmi your-username/giftlink-frontend:latest
```

## 🔒 Security Best Practices

1. **Change default passwords** in production
2. **Use environment variables** for sensitive data
3. **Enable HTTPS** with reverse proxy (nginx/traefik)
4. **Regular security updates** of base images
5. **Scan images** for vulnerabilities

## 📊 Monitoring

### Health Checks
All services include health checks. Check status:
```bash
docker-compose ps
```

### Resource Usage
```bash
docker stats
```

## 🌐 Production Deployment

For production deployment, consider:
- Using orchestration tools (Kubernetes, Docker Swarm)
- Setting up CI/CD pipelines
- Implementing proper logging and monitoring
- Using secrets management
- Setting up backup strategies for MongoDB