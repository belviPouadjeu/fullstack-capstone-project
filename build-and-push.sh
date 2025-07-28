#!/bin/bash

# Configuration
DOCKER_USERNAME="your-dockerhub-username"
APP_NAME="giftlink"
VERSION="latest"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo -e "${GREEN}🚀 Building and pushing GiftLink application to Docker Hub${NC}"

# Check if Docker is running
if ! docker info > /dev/null 2>&1; then
    echo -e "${RED}❌ Docker is not running. Please start Docker and try again.${NC}"
    exit 1
fi

# Login to Docker Hub
echo -e "${YELLOW}🔐 Logging in to Docker Hub...${NC}"
docker login

# Build backend image
echo -e "${YELLOW}🏗️  Building backend image...${NC}"
docker build -t ${DOCKER_USERNAME}/${APP_NAME}-backend:${VERSION} ./giftlink-backend
if [ $? -ne 0 ]; then
    echo -e "${RED}❌ Backend build failed${NC}"
    exit 1
fi

# Build frontend image
echo -e "${YELLOW}🏗️  Building frontend image...${NC}"
docker build -t ${DOCKER_USERNAME}/${APP_NAME}-frontend:${VERSION} ./giftlink-frontend
if [ $? -ne 0 ]; then
    echo -e "${RED}❌ Frontend build failed${NC}"
    exit 1
fi

# Push backend image
echo -e "${YELLOW}📤 Pushing backend image...${NC}"
docker push ${DOCKER_USERNAME}/${APP_NAME}-backend:${VERSION}
if [ $? -ne 0 ]; then
    echo -e "${RED}❌ Backend push failed${NC}"
    exit 1
fi

# Push frontend image
echo -e "${YELLOW}📤 Pushing frontend image...${NC}"
docker push ${DOCKER_USERNAME}/${APP_NAME}-frontend:${VERSION}
if [ $? -ne 0 ]; then
    echo -e "${RED}❌ Frontend push failed${NC}"
    exit 1
fi

echo -e "${GREEN}✅ Successfully built and pushed all images!${NC}"
echo -e "${GREEN}Backend: ${DOCKER_USERNAME}/${APP_NAME}-backend:${VERSION}${NC}"
echo -e "${GREEN}Frontend: ${DOCKER_USERNAME}/${APP_NAME}-frontend:${VERSION}${NC}"