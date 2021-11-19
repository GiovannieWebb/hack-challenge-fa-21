import json

from db import db
from db import User
from db import Recipe
from db import Ingredient
from db import Comment
from flask import Flask
from flask import request

app = Flask(__name__)
db_filename = "cookbook.db"

app.config["SQLALCHEMY_DATABASE_URI"] = "sqlite:///%s" % db_filename
app.config["SQLALCHEMY_TRACK_MODIFICATIONS"] = False
app.config["SQLALCHEMY_ECHO"] = True

db.init_app(app)
with app.app_context():
    db.create_all()

# generalized response formats


def success_response(data, code=200):
    return json.dumps(data), code


def failure_response(message, code=404):
    return json.dumps({"error": message}), code

# your routes here


@app.route("/")
@app.route("/api/users/")
def get_users():
    """
    Returns all users.
    """
    return success_response(
        {"users": [u.serialize() for u in User.query.all()]}
    )


@app.route("/api/recipes/")
def get_recipies():
    """
    Returns all recipies.
    """
    return success_response(
        {"recipes": [r.serialize() for r in Recipe.query.all()]}
    )


@app.route("/api/ingredients/")
def get_ingredients():
    """
    Returns all ingredients.
    """
    return success_response(
        {"ingredients": [i.serialize() for i in Ingredient.query.all()]}
    )


@app.route("/api/comments/")
def get_comments():
    """
    Returns all comments.
    """
    return success_response(
        {"comments": [c.serialize() for c in Comment.query.all()]}
    )


if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000, debug=True)
