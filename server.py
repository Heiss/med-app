from flask import Flask, request, abort, jsonify, render_template
from flask_cors import CORS
import uuid
import os
from datetime import datetime

app = Flask(__name__, template_folder="dist",
            static_folder="dist", static_url_path="")
app.config["SECRET_KEY"] = os.getenv("SECRET_KEY", uuid.uuid4().hex)
CORS(app)

# setup a redis and use it with this module https://pypi.org/project/redis-pubsub-dict/ here.
clients = []
last_clear = datetime.now().day


@app.route('/', methods=["GET", "POST"])
def hello_world():
    global last_clear, clients

    today = datetime.now().day
    if last_clear != today:
        clients = []
        last_clear = today

    if request.method == "GET":
        return render_template('index.html')

    data = request.get_json()
    canPass = (clients.count(
        data["hash"]) < int(os.getenv("SET_MAX_VISITOR_NUMBER", 1)))

    if canPass:
        clients.append(data["hash"])

    postData = {"canPass": canPass}

    return jsonify(postData)


app.run(debug=True, host='0.0.0.0', port=5000)
