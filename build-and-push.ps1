# Configuration
$DOCKER_USERNAME = "your-dockerhub-username"
$APP_NAME = "giftlink"
$VERSION = "latest"

Write-Host "🚀 Building and pushing GiftLink application to Docker Hub" -ForegroundColor Green

# Check if Docker is running
try {
    docker info | Out-Null
} catch {
    Write-Host "❌ Docker is not running. Please start Docker and try again." -ForegroundColor Red
    exit 1
}

# Login to Docker Hub
Write-Host "🔐 Logging in to Docker Hub..." -ForegroundColor Yellow
docker login

# Build backend image
Write-Host "🏗️  Building backend image..." -ForegroundColor Yellow
docker build -t "${DOCKER_USERNAME}/${APP_NAME}-backend:${VERSION}" ./giftlink-backend
if ($LASTEXITCODE -ne 0) {
    Write-Host "❌ Backend build failed" -ForegroundColor Red
    exit 1
}

# Build frontend image
Write-Host "🏗️  Building frontend image..." -ForegroundColor Yellow
docker build -t "${DOCKER_USERNAME}/${APP_NAME}-frontend:${VERSION}" ./giftlink-frontend
if ($LASTEXITCODE -ne 0) {
    Write-Host "❌ Frontend build failed" -ForegroundColor Red
    exit 1
}

# Push backend image
Write-Host "📤 Pushing backend image..." -ForegroundColor Yellow
docker push "${DOCKER_USERNAME}/${APP_NAME}-backend:${VERSION}"
if ($LASTEXITCODE -ne 0) {
    Write-Host "❌ Backend push failed" -ForegroundColor Red
    exit 1
}

# Push frontend image
Write-Host "📤 Pushing frontend image..." -ForegroundColor Yellow
docker push "${DOCKER_USERNAME}/${APP_NAME}-frontend:${VERSION}"
if ($LASTEXITCODE -ne 0) {
    Write-Host "❌ Frontend push failed" -ForegroundColor Red
    exit 1
}

Write-Host "✅ Successfully built and pushed all images!" -ForegroundColor Green
Write-Host "Backend: ${DOCKER_USERNAME}/${APP_NAME}-backend:${VERSION}" -ForegroundColor Green
Write-Host "Frontend: ${DOCKER_USERNAME}/${APP_NAME}-frontend:${VERSION}" -ForegroundColor Green