from flask import Flask, jsonify
import os

app = Flask(__name__)


@app.route("/")
def home():
    return "Application is running", 200


@app.route("/health")
def health():
    return jsonify({"status": "ok"}), 200


if __name__ == "__main__":
    app.run(
        host="0.0.0.0",
        port=int(os.environ.get("PORT", 8080))
    )