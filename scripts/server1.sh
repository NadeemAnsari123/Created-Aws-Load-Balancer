#!/bin/bash
sudo yum install httpd -y
echo "Server 1 Response" > /var/www/html/index.html
sudo systemctl start httpd
sudo systemctl enable httpd
