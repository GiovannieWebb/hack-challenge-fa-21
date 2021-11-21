import json

from db import db
from db import User
from db import Recipe
from db import Ingredient
from db import Comment
from db import Metric
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


@app.route("/api/users/", methods=["POST"])
def add_user():
    """
    Adds a new user.\n
    BODY:\n
    {
        "username": <string>,
        "email": <string>,
        "password": <string>
    }\n
    Error 400 if username, email, or password not specified
    Error 404 if user with specified username already exists
    """
    body = json.loads(request.data)
    username = body.get("username")
    if username is None:
        return failure_response("Username not specified!", 400)
    user = User.query.filter_by(username=username).first()
    if user is not None:
        return failure_response("User with this username already exists!", 404)
    email = body.get("email")
    if email is None:
        return failure_response("Email not specified!", 400)
    password = body.get("password")
    if password is None:
        return failure_response("Password not specified!", 400)
    new_user = User(username=username, email=email, password=password)
    db.session.add(new_user)
    db.session.commit()
    return success_response(new_user.serialize(), 201)


@app.route("/api/recipes/")
def get_recipes():
    """
    Returns all recipes.
    """
    return success_response(
        {"recipes": [r.serialize() for r in Recipe.query.all()]}
    )


@app.route("/api/recipes/<int:user_id>/", methods=["POST"])
def add_recipe_for_user(user_id: int):
    """
    Adds a recipe to a specific user profile.\n
    Parameters:
        user_id: id of user to add this recipe to
    BODY:
        {
            "name": <string>,
            "ingredients": [
                {
                    "name": <string>,
                    "unit": <string>,
                    "amount": <integer>,
                    "is_metric": <boolean>
                },
                {
                    "name": <string>,
                    "unit": <string>,
                    "amount": <integer>,
                    "is_metric": <boolean>
                },
                ...
            ] 
        }
    Error 404 is user with user_id not found\n
    Error 400 if "name" not specified\n
    Error 400 if "ingredients" not specified\n
    Error 400 if "name", "unit", or "amount" are not specified for a particular
    ingredient

    If an ingredient doesn't exist, add that ingredient to the ingredients table

    Returns the newly added recipe
    """
    user = User.query.filter_by(id=user_id).first()
    if user is None:
        return failure_response("User not found!")
    body = json.loads(request.data)
    name = body.get("name")
    if name is None:
        return failure_response("Recipe name not specified!", 400)
    ingredients = body.get("ingredients")
    if ingredients is None:
        return failure_response("Ingredients list not specified!", 400)
    for i in ingredients:
        n = i.get("name")
        if n is None:
            return failure_response("Name not specified for a given ingredient!", 400)
        u = i.get("unit")
        if u is None:
            return failure_response("Unit not specified for a given ingredient!", 400)
        a = i.get("amount")
        if a is None:
            return failure_response("Amount not specified for a given ingredient!", 400)
        im = i.get("is_metric")
        if im is None:
            return failure_response("Metric vs Imperial not specified for a given ingredient!", 400)

    new_recipe = Recipe(name=name, user_id=user_id)
    db.session.add(new_recipe)
    db.session.flush()
    db.session.refresh(new_recipe)
    recipe_id = new_recipe.id
    for ingredient in ingredients:
        db_ingredient = Ingredient.query.filter_by(
            name=ingredient.get("name")).first()
        if db_ingredient is None:
            db_ingredient = Ingredient(name=ingredient.get("name"))
            db.session.add(db_ingredient)
        new_metric = Metric(recipe_id=recipe_id,
                            ingredient_id=db_ingredient.id,
                            ingredient_name=db_ingredient.name,
                            amount=ingredient.get("amount"),
                            is_metric=ingredient.get("is_metric"),
                            unit=ingredient.get("unit"))
        db.session.add(new_metric)
        db_ingredient.associated_metrics.append(new_metric)
        new_recipe.contents.append(new_metric)
    db.session.commit()
    return success_response(new_recipe.serialize())


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


@app.route("/api/ingredients/", methods=["POST"])
def add_ingredient():
    """
    Adds an ingredient.\n
    BODY:\n
    {
        "name": <string>
    }\n
    Error 400 if name is not specified
    Error 404 if ingredient with this name already exists
    """
    body = json.loads(request.data)
    name = body.get("name")
    if name is None:
        return failure_response("Ingredient name not found!", 400)
    name = name.lower()
    ingredient = Ingredient.query.filter_by(name=name).first()
    if ingredient is not None:
        return failure_response("Ingredient with this name already exists!", 404)
    new_ingredient = Ingredient(name=name)
    db.session.add(new_ingredient)
    db.session.commit()
    return success_response(new_ingredient.serialize(), 201)


if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000, debug=True)
