from werkzeug.security import generate_password_hash, check_password_hash
from app import db


class Yield(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    ycrop_name = db.Column(db.String(80), index=True)
    ycrop_quantity = db.Column(db.String(10), index=True)
    ycrop_year = db.Column(db.Integer, index=True)
    note = db.Column(db.String(100),index = True)

class Resources(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    rmoney_spent = db.Column(db.Integer, index=True)
    rproduct_name = db.Column(db.String(80), index=True)
    rquantity = db.Column(db.String(10), index=True)
