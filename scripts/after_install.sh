#!/bin/bash
echo 'run after_install.sh: ' >> /home/ec2-user/deploy.log

echo 'cd /home/ec2-user/DATN-K26/BACKEND' >> /home/ec2-user/deploy.log
cd /home/ec2-user/DATN-K26 >> /home/ec2-user/deploy.log

echo 'npm install' >> /home/ec2-user/deploy.log 
npm install >> /home/ec2-user/deploy.log
