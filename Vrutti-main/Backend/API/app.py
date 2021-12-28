from flask import Flask, request, jsonify
from flask_sqlalchemy import SQLAlchemy
#import os


app = Flask(__name__)

#app.config['SQLALCHEMY_DATABSE_URI'] = os.environ.get('DATABASE_URL')
app.config['SQLALCHEMY_DATABSE_URI'] = 'mysql://priya:1234@localhost/xyz'
#app.config['DATABASE_URL'] = 'mysql://priya:1234@localhost/xyz'
app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False
app.config['PROPAGATE_EXCEPTIONS'] = True
db = SQLAlchemy(app)

from routes import *
from models import *

# if __name__ == '__main__':
#     app.run(port=8000)
#     print(databasePath)

