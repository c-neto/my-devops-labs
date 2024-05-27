import json

from flask import Flask, request
import requests
from pathlib import Path
import os
import io
import http




app = Flask(__name__)

#
# KUBE_API_SERVER = "https://kubernetes.default.svc"
# KUBE_API_SERVER_TIMEOUT = 10
# KUBE_API_ROOT_CA = Path("/var/run/secrets/kubernetes.io/serviceaccount/ca.crt").read_text()
# KUBE_API_TOKEN = Path("/var/run/secrets/kubernetes.io/serviceaccount/token").read_text()


KUBE_API_SERVER = "https://127.0.0.1:41753"
KUBE_API_SERVER_TIMEOUT = 10
KUBE_API_ROOT_CA = """"""
KUBE_API_TOKEN = ""


def verify_token(incoming_bearer_token: str):
    _bearer_header, token = incoming_bearer_token.split(" ")

    body = {
        "apiVersion": "authentication.k8s.io/v1",
        "kind": "TokenReview",
        "spec": {
            "token": token
        }
    }

    cert_file = io.StringIO(KUBE_API_ROOT_CA)

    auth_headers = {"Authorization": f"Bearer {KUBE_API_TOKEN}"}

    response = requests.post(
        f"{KUBE_API_SERVER}/apis/authentication.k8s.io/v1/tokenreviews",
        # cert=cert_file,
        verify=False,
        headers=auth_headers,
        timeout=KUBE_API_SERVER_TIMEOUT,
        json=body
    )

    if response.status_code != int(http.HTTPStatus.CREATED):
        print(response.json())
        raise RuntimeError("error in the tokenreview api access")

    response_content = response.json()

    print(json.dumps(response_content))

    if response_content["status"].get("error"):
        return  response_content["status"]["error"], False

    service_account_name = response_content["status"]["user"]["username"]
    is_authenticated = response_content["status"]["authenticated"]

    return service_account_name, is_authenticated


@app.route('/')
def home():
    incoming_bearer_token = request.headers.get('Authorization')
    service_account_name, is_authenticated = verify_token(incoming_bearer_token)
    return f"{service_account_name} - {is_authenticated}"


if __name__ == "__main__":
    app.run(host='0.0.0.0', port=8080)
