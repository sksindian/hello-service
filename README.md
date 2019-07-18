# hello-service
DEV Branch
Application URL is -> "http://hello-lb-493015950.us-east-2.elb.amazonaws.com:8080"

Components: 
1) AWS Public Cloud in US-EAST-2 region and its 3 AZ
2) AutoScalling group across the all 3 availability zone.
3) Application Load-balance 
4) S3 Bucket for uploading and downloading the code for running the instances
5) Python3 with Flask is running as system service

More information and documents: Please refer the "pdf" in the same repo 


GET Output
[root@ip-172-31-15-94 ~]# python
Python 2.7.16 (default, Jun 19 2019, 17:20:54)
[GCC 7.3.1 20180303 (Red Hat 7.3.1-5)] on linux2
Type "help", "copyright", "credits" or "license" for more information.
>>> import requests
>>> abc = requests.get("http://hello-lb-493015950.us-east-2.elb.amazonaws.com:8080")
>>> abc.json()
{u'response': u'hello-world'}
>>>

Header information 'Origin-Instance'
[root@ip-172-31-15-94 ~]# curl -i http://hello-lb-493015950.us-east-2.elb.amazonaws.com:8080
HTTP/1.1 200 OK
Date: Thu, 18 Jul 2019 01:40:16 GMT
Content-Type: application/json
Content-Length: 27
Connection: keep-alive
Origin-Instance: i-0fea8fbe2929a2f73
Server: Werkzeug/0.15.4 Python/3.7.3
