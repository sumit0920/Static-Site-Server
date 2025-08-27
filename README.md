# Static Website Deployment with Nginx and Rsync

This project demonstrates how to deploy a simple static website (HTML/CSS/images) on an **Amazon Linux EC2 instance** using **Nginx** and **Rsync** for updates. It also covers optional SSL setup using **Certbot**.

# Project URL:
```
https://roadmap.sh/projects/static-site-server

```
---

## Project Overview
This project helps you understand:
1. Setting up an EC2 server on AWS (RPM-based Amazon Linux).  
2. Installing and configuring **Nginx** to serve static content.  
3. Using **Rsync** to deploy changes to the server quickly.  
4. Automating deployment with a `deploy.sh` script.  
5. Optionally adding **SSL certificates** for HTTPS using Certbot.

---

## Architecture
```
(Local Machine)
│
│ rsync via SSH
▼
(EC2 Server: Amazon Linux)
└── Nginx Web Server
└── Serves static HTML/CSS/images
```

- **Local files** are synced to `/var/www/static-site/` on EC2.  
- **Nginx** serves the files directly on port 80 (or 443 with SSL).  

---

## Prerequisites

1. **AWS EC2 Instance** (Amazon Linux, t2.micro works fine).  
2. **SSH Access** to the server using your `.pem` key.  
3. **Domain name** (optional) pointing to the EC2 public IP.  
4. **Installed packages on local machine:**  
   - `rsync`  
   - `ssh`  
5. **Installed packages on EC2 server:**  
   - `nginx`  
   - `rsync`  
   - (optional) `certbot` for SSL  

---

## Setup Instructions

### 1. Launch EC2 and SSH into the server
```bash
ssh -i your-key.pem ec2-user@your-ec2-public-ip
```
# 2. Install and start Nginx on EC2
```
sudo yum update -y
sudo yum install nginx -y
sudo systemctl enable nginx
sudo systemctl start nginx
```
# 3. Create a directory for the static site
```
sudo mkdir -p /var/www/static-site
sudo chown ec2-user:ec2-user /var/www/static-site
```
# 4. Configure Nginx
Create /etc/nginx/conf.d/static-site.conf:
```
server {
    listen 80;
    server_name your-domain.com;  # or use server IP

    root /var/www/static-site;
    index index.html;

    location / {
        try_files $uri $uri/ =404;
    }
}
```
Then test and reload Nginx:
```
sudo nginx -t
sudo systemctl reload nginx
```
Deployment
1. Create a deployment script (deploy.sh) on local machine
```
chmod +x deploy.sh
```
2. Deploy changes
Whenever you update local files:
./deploy.sh

Optional: Enable SSL with Certbot
On EC2:
```
sudo yum install certbot python3-certbot-nginx -y
sudo certbot --nginx -d your-domain.com -d www.your-domain.com
```
Certificates auto-renew via systemd or cron jobs.

# Folder Structure
```
project-root/
│
├── static-site/
│   ├── index.html
│   ├── style.css
│   └── images/
│
├── deploy.sh
└── README.md
```
# Contributing
Contributions are welcome!
1. Fork the repository.
2. Create your feature branch (git checkout -b feature/new-feature).
3. Commit your changes (git commit -m "Add some feature").
4. Push to the branch (git push origin feature/new-feature).
5. Open a Pull Request.


Author: Sumit Sharma
Contact: sumitsharma.aset@gmail.com
Date: August 2025

---
