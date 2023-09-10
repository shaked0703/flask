from flask import Flask, render_template

app = Flask(__name__)

# Global variable to store visit count
visit_count = 0

@app.route("/")
def hello_world():
    global visit_count
    visit_count += 1
    return render_template("index.html", visit_count=visit_count)
