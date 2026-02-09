#!/bin/bash
sudo yum install httpd -y
echo "Server 2 Response Nadeem" > /var/www/html/index.html
sudo systemctl start httpd
sudo systemctl enable httpd
