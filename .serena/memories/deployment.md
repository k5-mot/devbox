# Deployment Procedures

## Deployment Strategy

This project is a template repository; each template generates projects that deploy independently.

### Deployment Targets
- **Frontend**: Next.js / Vite applications
- **Backend**: FastAPI applications
- **Serverless**: AWS Lambda (using SAM)

## Frontend Deployment

### Next.js Deployment

#### Vercel (Recommended)
```bash
# Login to Vercel account
npx vercel login

# Deploy project
cd next-daisyui-template
npx vercel

# Production deploy
npx vercel --prod
```

**Settings**:
- Framework Preset: Next.js
- Build Command: `pnpm build`
- Output Directory: `.next`
- Install Command: `pnpm install`

#### AWS Amplify
1. Create app in AWS Amplify console
2. Connect GitHub repository
3. Build settings:
```yaml
version: 1
frontend:
  phases:
    preBuild:
      commands:
        - npm install -g pnpm
        - pnpm install
    build:
      commands:
        - pnpm build
  artifacts:
    baseDirectory: .next
    files:
      - '**/*'
  cache:
    paths:
      - node_modules/**/*
```

#### Docker Container
```dockerfile
FROM node:24-alpine AS base

WORKDIR /app
COPY package.json pnpm-lock.yaml ./
RUN npm install -g pnpm && pnpm install --frozen-lockfile

COPY . .
RUN pnpm build

FROM node:24-alpine AS runner
WORKDIR /app
COPY --from=base /app/.next ./.next
COPY --from=base /app/node_modules ./node_modules
COPY --from=base /app/package.json ./package.json

EXPOSE 3000
CMD ["pnpm", "start"]
```

### Vite Deployment

#### Netlify
```bash
# Build
cd vite-serendie-template
pnpm build

# Netlify CLI
npm install -g netlify-cli
netlify login
netlify deploy --prod --dir=dist
```

**netlify.toml**:
```toml
[build]
  command = "pnpm build"
  publish = "dist"

[[redirects]]
  from = "/*"
  to = "/index.html"
  status = 200
```

#### AWS S3 + CloudFront
```bash
# Build
pnpm build

# Create S3 bucket
aws s3 mb s3://your-bucket-name

# Enable static hosting
aws s3 website s3://your-bucket-name --index-document index.html

# Upload files
aws s3 sync dist/ s3://your-bucket-name --delete

# Configure CloudFront distribution (recommended)
```

#### Docker Container
```dockerfile
FROM node:24-alpine AS build

WORKDIR /app
COPY package.json pnpm-lock.yaml ./
RUN npm install -g pnpm && pnpm install --frozen-lockfile

COPY . .
RUN pnpm build

FROM nginx:alpine
COPY --from=build /app/dist /usr/share/nginx/html
COPY nginx.conf /etc/nginx/conf.d/default.conf

EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
```

**nginx.conf**:
```nginx
server {
    listen 80;
    server_name localhost;
    root /usr/share/nginx/html;
    index index.html;

    location / {
        try_files $uri $uri/ /index.html;
    }
}
```

## Backend Deployment

### FastAPI Deployment

#### AWS Lambda + API Gateway (SAM)
```bash
cd python-template

# Create SAM template (template.yaml)
# Build
sam build

# Local testing
sam local start-api

# Deploy
sam deploy --guided
```

**template.yaml example**:
```yaml
AWSTemplateFormatVersion: '2010-09-09'
Transform: AWS::Serverless-2016-10-31

Resources:
  FastAPIFunction:
    Type: AWS::Serverless::Function
    Properties:
      CodeUri: .
      Handler: main.handler
      Runtime: python3.12
      Events:
        ApiEvent:
          Type: Api
          Properties:
            Path: /{proxy+}
            Method: ANY
```

#### Docker Container (ECS/Fargate)
```dockerfile
FROM python:3.12-slim

WORKDIR /app

# Install uv
COPY --from=ghcr.io/astral-sh/uv:latest /uv /usr/local/bin/uv

# Install dependencies
COPY pyproject.toml uv.lock ./
RUN uv sync --frozen --no-dev

# Copy application
COPY . .

EXPOSE 8000
CMD ["uv", "run", "uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8000"]
```

#### AWS EC2 / Azure VM
```bash
# Login to server
ssh user@server

# Clone repository
git clone <repository-url>
cd python-template

# Install uv
curl -LsSf https://astral.sh/uv/install.sh | sh

# Install dependencies
uv sync --frozen

# Create systemd service (/etc/systemd/system/fastapi.service)
[Unit]
Description=FastAPI Application
After=network.target

[Service]
User=www-data
WorkingDirectory=/path/to/python-template
ExecStart=/usr/local/bin/uv run uvicorn main:app --host 0.0.0.0 --port 8000
Restart=always

[Install]
WantedBy=multi-user.target

# Start service
sudo systemctl enable fastapi
sudo systemctl start fastapi
```

#### Nginx Reverse Proxy
```nginx
server {
    listen 80;
    server_name api.example.com;

    location / {
        proxy_pass http://localhost:8000;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
    }
}
```

## Environment Variable Management

### Production Environment
- **AWS**: Systems Manager Parameter Store / Secrets Manager
- **Azure**: Key Vault
- **Vercel/Netlify**: Environment variable settings UI

### .env Files Prohibited in Production
- Use environment variables or secret management services in production
- `.env` files for development only

## Database Deployment

### Migrations
- Alembic (SQLAlchemy)
- Prisma Migrate (TypeScript)

### Managed Services Recommended
- **PostgreSQL**: AWS RDS, Azure Database for PostgreSQL
- **MongoDB**: MongoDB Atlas
- **Redis**: AWS ElastiCache, Azure Cache for Redis

## Monitoring & Logging

### Application Logs
- **AWS**: CloudWatch Logs
- **Azure**: Application Insights
- **Vercel**: Vercel Logs

### Metrics
- **AWS**: CloudWatch Metrics
- **Azure**: Azure Monitor
- **Datadog**: Multi-cloud support

### Error Tracking
- Sentry
- Rollbar
- AWS X-Ray

## CI/CD Integration

### GitLab CI/CD
- Define pipeline in `.gitlab-ci.yml`
- Stages: build → test → deploy

### GitHub Actions
- Define in `.github/workflows/deploy.yml`

### Automatic Deployment
- Production deploy on merge to main branch
- Staging environment on develop branch

## Rollback Strategy

### Frontend
- Vercel: Instant rollback from deployment history
- CloudFront: Switch to previous S3 version

### Backend
- SAM: `sam deploy --rollback`
- Docker: Switch to previous image tag
- ECS: Change task definition revision

## Health Checks

### FastAPI
```python
@app.get("/health")
async def health_check():
    """Health check endpoint."""
    return {"status": "healthy"}
```

### Next.js
```typescript
// pages/api/health.ts
export default function handler(req, res) {
  res.status(200).json({ status: 'healthy' });
}
```

## Scaling

### Horizontal Scaling
- **AWS**: Auto Scaling Group, ECS Service Scaling
- **Azure**: VM Scale Sets
- **Kubernetes**: HPA (Horizontal Pod Autoscaler)

### Vertical Scaling
- Change instance type
- Adjust container resources

## Security

### HTTPS/TLS
- **AWS**: ACM (AWS Certificate Manager)
- **Azure**: App Service Certificate
- **Let's Encrypt**: Free SSL certificates

### WAF (Web Application Firewall)
- AWS WAF
- Azure WAF
- Cloudflare

### DDoS Protection
- AWS Shield
- Azure DDoS Protection
- Cloudflare

## Cost Optimization

### Serverless First
- Lambda: Pay per execution
- S3 + CloudFront: Low-cost static hosting

### Resource Optimization
- Delete unnecessary resources
- Configure Auto Scaling
- Reserved Instances (long-term use)

## Troubleshooting

### Deployment Failures
- Check build logs
- Verify environment variable configuration
- Check dependency versions

### Performance Issues
- Use APM tools (New Relic, Datadog)
- Optimize database queries
- Review cache strategy

### Security Incidents
- Block access immediately
- Analyze logs
- Apply security patches
- Create incident report
