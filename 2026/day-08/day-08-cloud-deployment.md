Day 08 – Cloud Server Setup: Docker, Nginx & Web Deployment

My Task-> 


Today's goal is to deploy a real web server on the cloud and learn practical server management.

You will:

Launch a cloud instance (AWS EC2 or Utho)
Connect via SSH
Install Nginx
Configure security groups for web access (port 80 by default for nginx)
Extract and save logs to a file
Verify your webpage is accessible from the internet
This is real DevOps work - exactly what you'll do in production.

Solution:

Step-1 We have deloy AWS Ec2 Server 
Step-2 Connect EC2 Sever in my local Window machine using SSH.
Step3- Install nginx in Server- Using This command-> sudo apt install nginx
Step4- Check nginx status using this command-> systmctl status nginx 
Step5-> Take screen shot of nginx status.
Step5-> Configure security groups for web access (port 80 by default for nginx) in EC2 
Step6-> Check EC2 instance public ip in web and see nginx page sucessfully open and take screen shot.
Step8-> Check nginx logs-> sudo cat /var/log/nginx/access.log or sudo cat /var/log/nginx/error.log
Step9-> Save log in .txt file -> sudo cat /var/log/nginx/access.log  /var/log/nginx/error.log > nginx-logs.txt
Step10-> Check and confirm nginx logs file created or not using -> ls & Check confirmation that logs are copy in .txt file or not.
Step11->Downlod log file in Local system-> Using scp command-> scp -i "DevOps_Training_Linux_Key.pem" ubuntu@ec2-98-91-16-172.compute-1.amazonaws.com:/home/ubuntu/nginx-logs.txt .
and check logs file is sucessfully downloaded in Local System

Note: We have pushed logs txt in github.
