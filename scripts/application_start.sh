#!/bin/bash

echo 'run application_start.sh: ' >> /home/ec2-user/DATN-K26/BACKEND/
# nodejs-app is the same name as stored in pm2 process
echo 'npm start nodejs-app' >> /home/ec2-user/DATN-K26/BACKEND/
npm start >> /home/ec2-user/DATN-K26/BACKEND/