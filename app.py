from flask import Flask

app = Flask(__name__)

@app.route("/")
def index():
    return "This app is developed and built with nix!"

