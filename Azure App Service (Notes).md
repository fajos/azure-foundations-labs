# Azure App Service - Complete Guide

## Core Concepts

### 1. App Service Plan
The VM/Container hosting plan that determines:

- Region/Geography where apps run

- Compute Resources: CPU, RAM, storage

- Scale Settings: Instance count, auto-scaling

- Pricing Tier: Free, Shared, Basic, Standard, Premium, Isolated

- OS: Windows or Linux

### 2. Web App
Your actual application running in the App Service Plan:

- Supports multiple frameworks: .NET, Java, Node.js, Python, PHP, Ruby

- Built-in CI/CD with GitHub, Azure DevOps

- Custom domains and SSL

- Authentication/Authorization

- Deployment slots (Staging, Production)

### 3. App Service
The managed platform that hosts:

- Web Apps

- API Apps

- Mobile Apps

- Function Apps

## Pricing Tiers Comparison
| Tier	| Best For	| Features	| Cost
|-------|-----------|-----------|------
| Free (F1)	| Testing/learning	| 1 GB storage, no custom domain	| $0 
| Shared (D1) |	Dev/Test	| Custom domains, no SLA |	~$9.50/mo 
| Basic (B1)	| Small production	| 3 instances, manual scale |	~$54/mo
| Standard (S1) |	Production	| Auto-scale, slots, backups	| ~$73/mo 
| Premium (P1V2) |	High traffic |	More CPU/RAM, VNet integration |	~$196/mo 
| Isolated (I1) |	Enterprise |	Dedicated hardware, compliance	| ~$545/mo

## Portal Administration
### 1. Create via Portal
```text
Azure Portal → Create Resource → Web App
Steps:
1. Subscription + Resource Group
2. Name (globally unique)
3. Runtime stack (.NET, Node.js, etc.)
4. Region
5. App Service Plan (create new or existing)
6. Review + Create
```
### 2. Key Portal Sections
- Overview: Status, URL, resource metrics

- Deployment: CI/CD setup, deployment slots

- Settings: Configuration, custom domains, SSL

- Monitoring: Logs, alerts, Application Insights

- Scale up/out: Change pricing tier or instance count

### 3. Deployment Options
- Local Git: Push from local repo

- GitHub/GitLab: Connect repository

- FTP/S: Manual file upload

- Docker Container: Container registry

- Azure DevOps: Pipeline deployments

## CLI Administration (Essential for Automation)
### 1. Create Resource Group
```bash
az group create --name "MyApp-RG" --location "eastus"
```
<img width="725" height="192" alt="image" src="https://github.com/user-attachments/assets/30159e15-d968-4903-9977-c877ab829d02" />

### 2. Create App Service Plan
```bash
# Basic Plan (B1)
az appservice plan create \
  --name "MyAppPlan" \
  --resource-group "MyApp-RG" \
  --sku B1 \
  --is-linux  # Omit for Windows

<img width="1341" height="578" alt="image" src="https://github.com/user-attachments/assets/02be0256-d69a-4780-bde4-2d0648e6a39b" />

#  Standard Plan with auto-scale
az appservice plan create \
  --name "ProdAppPlan" \
  --resource-group "MyApp-RG" \
  --sku S1 \
  --number-of-workers 3
```
### 3. Create Web App
```bash
# Basic Node.js app
az webapp create \
  --name "myjobapp" \
  --resource-group "MyApp-RG" \
  --plan "MyAppPlan" \
  --runtime "NODE|14-lts"

<img width="1369" height="521" alt="image" src="https://github.com/user-attachments/assets/46fba220-1fc1-489a-bb55-9ff8f4d87699" />


_# Python app with custom runtime_
az webapp create \
  --name "myjobapp-python" \
  --resource-group "MyApp-RG" \
  --plan "MyAppPlan" \
  --runtime "PYTHON|3.9"
```
<img width="1339" height="482" alt="image" src="https://github.com/user-attachments/assets/b1fe478c-a545-4150-9115-8349743833aa" />

### 4. Deploy from Local Git
```
# Configure deployment user
az webapp deployment user set \
  --user-name "mydeployuser" \
  --password "P@ssw0rd123!"

# Configure local git
az webapp deployment source config-local-git \
  --name "myjobapp" \
  --resource-group "MyApp-RG"

# Get git URL and push
git remote add azure <git-url-from-command>
git push azure main
```
### 5. Deploy from GitHub
```
# Connect GitHub repo
az webapp deployment source config \
  --name "myjobapp" \
  --resource-group "MyApp-RG" \
  --repo-url "https://github.com/username/repo" \
  --branch "main" \
  --git-token "your-github-token"
```
### 6. Environment Configuration
```bash
# Set app settings
az webapp config appsettings set \
  --name "myjobapp" \
  --resource-group "MyApp-RG" \
  --settings \
    "APP_ENV=Production" \
    "DB_CONNECTION=$ConnectionString" \
    "API_KEY=your-api-key"
# Set connection strings
az webapp config connection-string set \
  --name "myjobapp" \
  --resource-group "MyApp-RG" \
  --connection-string-type "SQLAzure" \
  --settings "DefaultConnection=$ConnectionString"
```
### 7. Scale Operations
```
# Scale UP (change pricing tier)
az appservice plan update \
  --name "MyAppPlan" \
  --resource-group "MyApp-RG" \
  --sku S2
# Scale OUT (add instances)
az appservice plan update \
  --name "MyAppPlan" \
  --resource-group "MyApp-RG" \
  --number-of-workers 5
```
### 8. Custom Domains & SSL
```
# Add custom domain
az webapp config hostname add \
  --webapp-name "myjobapp" \
  --resource-group "MyApp-RG" \
  --hostname "www.myportfolio.com"

# Bind SSL certificate
az webapp config ssl bind \
  --name "myjobapp" \
  --resource-group "MyApp-RG" \
  --certificate-thumbprint "thumbprint" \
  --ssl-type "SNI"
```
### 9. Deployment Slots
```
# Create staging slot
az webapp deployment slot create \
  --name "myjobapp" \
  --resource-group "MyApp-RG" \
  --slot "staging"

# Swap slots
az webapp deployment slot swap \
  --name "myjobapp" \
  --resource-group "MyApp-RG" \
  --slot "staging" \
  --target-slot "production"
```
### 10. Monitoring & Logs
```
# Download logs
az webapp log download \
  --name "myjobapp" \
  --resource-group "MyApp-RG"

# Tail live logs
az webapp log tail \
  --name "myjobapp" \
  --resource-group "MyApp-RG"

# Configure logging
az webapp log config \
  --name "myjobapp" \
  --resource-group "MyApp-RG" \
  --application-logging true \
  --detailed-error-messages true \
  --web-server-logging filesystem
```
### 11. Backup & Restore
```
# Configure backup
az webapp config backup update \
  --webapp-name "myjobapp" \
  --resource-group "MyApp-RG" \
  --storage-account-url "https://mystorage.blob.core.windows.net/backups" \
  --frequency "1d" \
  --retention "30"

# Create manual backup
az webapp config backup create \
  --webapp-name "myjobapp" \
  --resource-group "MyApp-RG"
```

## Full Deployment Script
```
#!/bin/bash
# deploy-app.sh - One-click deployment for job projects

APP_NAME="portfolio-project-$(date +%s)"
RG_NAME="Portfolio-RG"
PLAN_NAME="Portfolio-Plan"
LOCATION="eastus"
GITHUB_REPO="https://github.com/yourusername/portfolio-app"

echo "🚀 Deploying Portfolio Project..."

# Create resources
az group create --name $RG_NAME --location $LOCATION --output none
az appservice plan create --name $PLAN_NAME --resource-group $RG_NAME --sku B1 --is-linux --output none
az webapp create --name $APP_NAME --resource-group $RG_NAME --plan $PLAN_NAME --runtime "NODE|16-lts" --output none

# Deploy from GitHub
az webapp deployment source config \
  --name $APP_NAME \
  --resource-group $RG_NAME \
  --repo-url $GITHUB_REPO \
  --branch main \
  --manual-integration

# Set environment
az webapp config appsettings set \
  --name $APP_NAME \
  --resource-group $RG_NAME \
  --settings \
    "NODE_ENV=production" \
    "PORT=8080" \
    "APP_URL=https://$APP_NAME.azurewebsites.net"

echo "✅ Deployment complete!"
echo "🌐 App URL: https://$APP_NAME.azurewebsites.net"
```
## Quick Check Commands
```bash
# List all web apps
az webapp list --output table

# Show app details
az webapp show --name "myjobapp" --resource-group "MyApp-RG"

# Get publishing profile (for CI/CD)
az webapp deployment list-publishing-profiles \
  --name "myjobapp" \
  --resource-group "MyApp-RG" \
  --xml

# Restart app
az webapp restart --name "myjobapp" --resource-group "MyApp-RG"
```
## Quick Reference Cheatsheet
| Task	| Portal Location	| CLI Command
|-------|-----------------|------------
| Create App	| Create Resource → Web App	| az webapp create
| Deploy Code |	Deployment Center	| az webapp deployment source
| Set Env Vars | Configuration → Application Settings	| az webapp config appsettings
| Custom Domain |	Custom Domains	| az webapp config hostname
| SSL/TLS	| TLS/SSL Settings	| az webapp config ssl
| Scale	| Scale up (App Service plan)	| az appservice plan update --sku
| Logs	| App Service logs	| az webapp log tail
| Backup	| Backups	| az webapp config backup

## Cost Optimization for Projects
- Use Free tier for demos/prototypes

- Stop app when not in use: az webapp stop

- Auto-shutdown with Azure Functions

- Clean up resources after interviews: az group delete


- Use GitHub Student Pack for $100 Azure credit






