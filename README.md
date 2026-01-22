# 🚀 DevOps Zero-Touch Deployment Platform

> **Fork → Configure Once → Push Code → Get a Live URL**  
> A fully automated, production-grade DevOps platform that provisions AWS infrastructure, Kubernetes, CI/CD, ingress, and DNS with **zero manual deployment steps**.

---

## 📌 What does this project do?

This project provides a **self-service DevOps platform** where any developer can deploy their application to AWS **without manually configuring**:

- EC2
- Kubernetes
- Load Balancers
- IAM permissions
- DNS records
- CI/CD pipelines

Once set up, **everything runs automatically via GitHub Actions**.

---

## 🎯 Problem This Project Solves

Traditional deployment requires:
- Manual AWS setup
- Complex IAM permissions
- Kubernetes expertise
- DNS + Load Balancer configuration
- Fragile CI/CD pipelines

This platform solves all of that by providing:

✅ Zero-touch infrastructure provisioning  
✅ Secure GitHub OIDC authentication (no AWS keys)  
✅ Kubernetes on AWS (EKS)  
✅ Automatic ALB + DNS routing  
✅ Fork-safe automation  
✅ Production-ready architecture  

---

## 🧠 Architecture Diagram
![Zero Touch DevOps Architecture](docs/Architecture.png)

## 🧰 Tech Stack

- **Cloud**: AWS
- **IaC**: Terraform
- **CI/CD**: GitHub Actions
- **Containers**: Docker
- **Orchestration**: Kubernetes (EKS)
- **Ingress**: AWS Load Balancer Controller
- **DNS**: Route 53
- **Auth**: GitHub OIDC (No AWS keys)



---

## ✨ Key Features

- 🔥 **Zero-Touch Deployment**
- 🔐 **No AWS keys stored in GitHub** (OIDC-based authentication)
- 🧱 **Infrastructure fully managed by Terraform**
- 🌐 **Automatic domain-based access**
- ♻️ **Idempotent & re-runnable pipelines**
- 🧩 **Fork-safe by design**
- 📈 **Production-ready AWS architecture**

---

---

## 🚦 End-to-End Flow (How the Platform Works)


# 🧑‍💻 HOW TO USE THIS PLATFORM (STEP-BY-STEP)


---

## 🟢 STEP 1 — Create GitHub OIDC IAM Role (REQUIRED)



### 1️⃣ Go to AWS Console → **IAM**
- Click **Roles**
- Click **Create role**

---

### 2️⃣ Select Trusted Entity
- Trusted entity type: **Web identity**
- Identity provider: **GitHub**
- Audience: `sts.amazonaws.com`

> ⚠️ If **GitHub is NOT visible** in the identity provider list, follow **Step 2A** below.

---

## 🟡 STEP 2A — Configure GitHub OIDC Provider (If Not Available)

> Perform this step **only if GitHub does not appear** as an identity provider.

---

### 1️⃣ Go to IAM → Identity Providers
- AWS Console → **IAM**
- Click **Identity providers**
- Click **Add provider**

---

### 2️⃣ Add OIDC Provider Details
- **Provider type**: `OpenID Connect`
- **Provider URL**: https://token.actions.githubusercontent.com
- **Audience**: sts.amazonaws.com

Click **Add provider**

---

### 3️⃣ Verify Provider Creation
Ensure the provider appears as:
- Type: `OIDC`
- URL: `token.actions.githubusercontent.com`

✅ GitHub is now available as a Web Identity Provider.

---

### 4️⃣ Resume IAM Role Creation
Go back to: IAM → Roles → Create role

Then continue with **Web identity → GitHub**.

---

## 🟢 STEP 3 — Configure GitHub Access Scope

While creating the IAM role:

- **GitHub organization / user**: `your-github-username`
- **Repository**: `*` (or specify your repository name)
- **Branch**: `main`

This ensures:
- Fork-safe access
- Controlled role assumption
- Secure CI/CD execution

---

## 🟢 STEP 4 — Attach Permissions

Attach the following AWS managed policy:

- `AdministratorAccess` *(recommended only for learning/demo)*


---

## 🟢 STEP 5 — Name the Role

Set the role name as: github-actions-zero-touch-role

---

## 🟢 STEP 6 — Copy the Role ARN

After role creation, copy the **Role ARN**.

Example: arn:aws:iam::123456789012:role/github-actions-zero-touch-role


📌 This ARN will be added later as a **GitHub Actions secret**.

---

✅ **GitHub OIDC authentication is now fully configured.**



---

## 🟢 STEP 2 — Buy or Configure Domain in Route 53

### Option A (Recommended): Buy Domain via Route 53
- Go to **Route 53 → Domains**
- Buy a domain (e.g. `mytesterapp.com`)
- Hosted zone is created automatically

### Option B: Existing Domain
- Create a hosted zone in Route 53
- Update NS records at your registrar

---

## 🟢 STEP 3 — Get Hosted Zone ID

- Go to **Route 53 → Hosted Zones**
- Click your domain
- Copy **Hosted Zone ID**

- Example: Z0123456789ABCDEFG

---

## 🟢 STEP 4 — Create Terraform Backend (CRITICAL)

### 1️⃣ Create S3 Bucket
- Go to **S3**
- Create bucket: zero-touch-devops-terraform-state

- Enable **Block Public Access**
- Enable **Versioning**

---

### 2️⃣ Create DynamoDB Table
- Go to **DynamoDB**
- Create table: terraform-locks

- Partition key: LockID (String)

- Capacity: On-demand

---

## 🟢 STEP 5 — Get ECR URL

### 1️⃣ Go to **ECR**
- Click **Repositories**
- Create a temporary repo (any name)

### 2️⃣ Copy Registry URL (NOT repo name)
Example: 123456789012.dkr.ecr.ap-south-1.amazonaws.com

> You can delete the dummy repo later.

---

## 🟢 STEP 6 — Fork the Repository

- Click **Fork**
- Clone your fork locally

---

## 🟢 STEP 7 — Add GitHub Secrets

Go to your **forked repo** →  
**Settings → Secrets → Actions**

Add the following secrets:

| Secret Name | Example |
|-----------|--------|
| `AWS_ROLE_ARN` | `arn:aws:iam::123456789012:role/github-actions-zero-touch-role` |
| `DOMAIN_NAME` | `mytesterapp.com` |
| `HOSTED_ZONE_ID` | `Z0123456789ABCDEFG` |
| `ECR_URL` | `123456789012.dkr.ecr.ap-south-1.amazonaws.com` |

---

## 🟢 STEP 8 — Add Your Application

## 📂 Repository Folder Structure

```text
.
├── .github
├── terraform
├── k8s
├── scripts
├── app
│   ├── Dockerfile
│   └── src
│       └── main-app
├── README.md

```

### 📁 `/app` folder
Put your application code here.

### 🐳 Dockerfile (REQUIRED)
Your app **must** have a Dockerfile.

## 🟢 STEP 9 — Push to main
- git add .
- git commit -m "Deploy my app"
- git push origin main

## 🟢 STEP 10 — Watch Deployment
- Go to : GitHub → Actions → Zero Touch Deploy
- ⏳ First run takes 15–25 minutes (EKS creation)

## 🟢 STEP 11 — Verify ALB & App
- Check ALB: Go to EC2 → Load Balancers
- ALB should be created automatically

## 🔗 Domain Setup & Live Application Access (Step 12)

Once the infrastructure and application deployment are complete, the **Application Load Balancer (ALB)** will be successfully provisioned by Terraform via the main GitHub Actions workflow.

However, **DNS configuration is intentionally separated** to ensure fork-safety and better control.

---

## ✅ Step 12: Configure Route 53 & Access Live App

### 1️⃣ Verify ALB Provisioning
- Go to **GitHub → Actions**
- Open the **Infrastructure / Deploy workflow**
- Ensure the workflow has completed successfully
- Confirm that the **ALB is created** in AWS

> ℹ️ The ALB DNS name is required for Route 53 record creation.

---

### 2️⃣ Manually Trigger the Route 53 Workflow
Once the ALB is ready:

1. Navigate to:
GitHub → Actions → Route 53 Workflow
2. Click **Run workflow**
3. Select the `main` branch
4. Start the workflow

This workflow will:
- Create/Update Route 53 DNS records
- Point your domain to the ALB
- Ensure idempotent DNS setup (safe to re-run)

---

### 3️⃣ DNS Propagation
- DNS changes may take **1–3 minutes** (sometimes up to 5 minutes)
- No manual AWS console steps required

---

### 4️⃣ Access Your Live Application 🎉

- Once the Route 53 workflow completes, your application will be publicly available at:

- **`http://<repository-name>.<domain-name>`**

- 📌 Example: http://expense-tracker.example.com


---

## ♻️ Re-runs & Safety
- Route 53 workflow is **idempotent**
- Safe to re-run if ALB changes
- No duplicate DNS records created

---

## 🧩 Why This Two-Step Approach?
- Keeps the platform **fork-safe**
- Prevents broken DNS before ALB exists
- Allows controlled domain management
- Ideal for production-grade CI/CD pipelines

---

✅ **At this point, your application is fully live and production-ready.**

## ✅ Done!

Just configure the credentials, add your app inside the `app/` folder, and push your code to the `main` branch.

⏳ Wait **10–15 minutes** for the pipeline to complete — your application will be live automatically.




