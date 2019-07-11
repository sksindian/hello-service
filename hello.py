from flask import Flask, request, jsonify, after_this_request
import requests
app = Flask(__name__)
## Collect the instance ID
instance_id = requests.get("http://169.254.169.254/latest/meta-data/instance-id")
## return Header output and GET output in one function
@app.route('/', methods=['GET'])
def hello_world():
    @after_this_request
    def add_header(resp):
        inst_id = instance_id.content.decode("utf-8")
        resp.headers['Origin-Instance'] = inst_id
        return resp
    if request.method == 'GET':
        return jsonify({"response" : "hello-world"})
