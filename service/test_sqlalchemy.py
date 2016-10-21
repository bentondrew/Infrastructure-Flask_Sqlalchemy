from flask import Flask
app = Flask(__name__)


@app.route('/')
def index():
  import sqlalchemy
  return 'Sqlalchemy version installed: {}'.format(sqlalchemy.__version__)
