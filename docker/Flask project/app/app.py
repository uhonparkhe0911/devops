from flask import Flask, render_template, request, redirect, url_for
import mysql.connector
import os

app = Flask(__name__)

def get_connection():
    return mysql.connector.connect(
        host=os.getenv("MYSQL_HOST", "db"),
        user=os.getenv("MYSQL_USER", "root"),
        password=os.getenv("MYSQL_PASSWORD", "secretpass"),
        database=os.getenv("MYSQL_DB", "testdb")
    )

@app.route('/')
def home():
    return render_template("index.html")

@app.route('/reservation')
def reservation_page():
    return render_template("reservation.html")

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000, debug=True)
