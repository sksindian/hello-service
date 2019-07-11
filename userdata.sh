#!/bin/bash
mkdir /opt/hello
yum -y install python3
pip3 install Flask
pip3 install requests
export AWS_ACCESS_KEY_ID="${access}"
export AWS_SECRET_ACCESS_KEY="${secret}"
export AWS_DEFAULT_REGION="${region}"
aws s3 cp s3://hello-network-assignment/ /tmp/ --recursive
mv /tmp/hello* /opt/hello/
chmod a+x /opt/hello/hello.*
cp /opt/hello/hello.service /etc/systemd/system/hello.service
systemctl daemon-reload
systemctl enable hello.service
systemctl start hello.service
