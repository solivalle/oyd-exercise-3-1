#!/bin/bash
dnf install -y ruby
aws s3 cp s3://$BUCKET/server.rb /opt/server.rb
COMPUTE_TYPE=ec2 nohup ruby /opt/server.rb &