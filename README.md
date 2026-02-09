## Folder Structure 

```
AWS-Load-Balancer-Tutorial/
│
├── README.md                 # Complete tutorial
├── diagrams/                 # Architecture diagram
│   └── alb-architecture.png
├── scripts/                  # User-data scripts for EC2
│   ├── server1.sh
│   └── server2.sh
└── .gitignore                # Ignore unwanted files
```
A step-by-step guide to create an **Application Load Balancer (ALB)** in AWS with EC2 instances and Target Groups.
--

## Table of Contents
- [Overview](#overview)
- [Prerequisites](#prerequisites)
- [Step 1: Launch 2 EC2 Instances](#step-1-launch-2-ec2-instances)
- [Step 2: Create Target Group](#step-2-create-target-group)
- [Step 3: Create Application Load Balancer (ALB)](#step-3-create-application-load-balancer-alb)
- [Step 4: Test Load Balancer](#step-4-test-load-balancer)
- [Step 5: Verify Health Checks](#step-5-verify-health-checks)
- [Architecture Diagram](#architecture-diagram)
- [Scripts](#scripts)
- [Conclusion](#conclusion)

---

## Overview
This tutorial demonstrates how to set up an **ALB** to distribute traffic across **EC2 instances** using a **Target Group**.  
---

## Prerequisites
- AWS account
- Basic knowledge of EC2, Security Groups, and Load Balancers
- IAM permissions to create EC2, ALB, and Target Groups
---

## Step 1: Launch 2 EC2 Instances
1. AWS Console → EC2 → Launch Instance
2. Choose AMI: Amazon Linux 2 / Ubuntu
3. Instance Type: t2.micro
4. Add User Data:

**server1.sh**
```bash
#!/bin/bash
sudo yum install httpd -y
echo "Server 1 Response" > /var/www/html/index.html
sudo systemctl start httpd
sudo systemctl enable httpd
````

**server2.sh**

```bash
#!/bin/bash
sudo yum install httpd -y
echo "Server 2 Response" > /var/www/html/index.html
sudo systemctl start httpd
sudo systemctl enable httpd
```

5. Security Group: Allow **HTTP (80) from 0.0.0.0/0**
6. Launch **2 instances**

---

## Step 2: Create Target Group

1. EC2 → Load Balancing → Target Groups → Create Target Group
2. Type: Instances, Protocol: HTTP, Port: 80
3. Target Group Name: `my-target-group`
4. Register both EC2 instances
5. Create Target Group

---

## Step 3: Create Application Load Balancer (ALB)
1. EC2 → Load Balancers → Create Load Balancer
2. Select Application Load Balancer
3. Name: `my-alb`, Scheme: Internet-facing, IP type: IPv4
4. Listener: HTTP : 80
5. Select Availability Zones where EC2 instances are running
6. Security Group: Allow HTTP (80) from 0.0.0.0/0
7. Target Group: `my-target-group`
8. Click Create Load Balancer

---

## Step 4: Test Load Balancer
1. Copy ALB DNS Name: `my-alb-123456789.us-east-1.elb.amazonaws.com`
2. Open in browser: `http://my-alb-xxxx.amazonaws.com`
3. Refresh page → You should see:

   * 1st refresh: Server 1 Response
   * 2nd refresh: Server 2 Response Nadeem

Round-robin load balancing working
---

## Step 5: Verify Health Checks

1. EC2 → Target Groups → Your Target Group → Targets
2. Both instances status = healthy

---

## Architecture Diagram
![ALB Architecture](diagrams/alb-architecture.png)

---

## Scripts
All user-data scripts for EC2 instances are in the **scripts/** folder.
--

## Conclusion
* ALB distributes traffic across multiple EC2 instances
* Target Group manages registered instances
* Simple web pages served by EC2 instances demonstrate load balancing
