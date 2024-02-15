#!/bin/bash
echo 'run after_install.sh: ' >> /home/ec2-user/DATN-K26/BACKEND/deploy1.log

echo 'cd /home/ec2-user/DATN-K26/BACKEND' >> /home/ec2-user/DATN-K26/BACKEND/deploy1.log
cd /home/ec2-user/DATN-K26/BACKEND >> /home/ec2-user/DATN-K26/BACKEND/deploy1.log

echo 'npm install' >> /home/ec2-user/DATN-K26/BACKEND/deploy1.log
npm install >> /home/ec2-user/DATN-K26/BACKEND/deploy1.log