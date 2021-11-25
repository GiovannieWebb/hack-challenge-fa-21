import json

from db import db
from db import User, Recipe, Ingredient, Comment, IngredientName
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

# ------------------------------ GET METHODS --------------------------------- #


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
def get_recipes():
    """
    Returns all recipes.
    """
    return success_response(
        {"recipes": [r.serialize() for r in Recipe.query.all()]}
    )


@app.route("/api/ingredients/name/")
def get_ingredient_names():
    """
    Gets all ingredient names.
    """
    return success_response(
        {"ingredient_names": [i_n.serialize()
                              for i_n in IngredientName.query.all()]}
    )


@app.route("/api/ingredients/")
def get_ingredients():
    """
    Returns all ingredients.
    """
    return success_response(
        {"ingredients": [i.serialize() for i in Ingredient.query.all()]}
    )


@app.route("/api/recipes/liked/<int:user_id>/")
def get_liked_recipes_from_user(user_id: int):
    """
    Gets all recipes that a user has liked.
    Error 404 if this user does not exist.
    """
    user = User.query.filter_by(id=user_id).first()
    if user is None:
        return failure_response("User not found!", 404)
    return success_response({
        "liked_recipes": [lr.serialize() for lr in user.liked_recipes]
    })


@app.route("/api/recipes/posted/<int:user_id>/")
def get_posted_recipes_from_user(user_id: int):
    """
    Gets all recipes that a user has posted.
    Error 404 if this user does not exist.
    """
    user = User.query.filter_by(id=user_id).first()
    if user is None:
        return failure_response("User not found!", 404)
    return success_response({
        "posted_recipes": [pr.serialize() for pr in user.posted_recipes]
    })


@app.route("/api/ingredients/<int:recipe_id>/")
def get_ingredients_for_specific_recipe(recipe_id):
    """
    Gets all ingredients for a specific recipe.
    Error 404 if recipe with recipe_id does not exist
    """
    recipe = Recipe.query.filter_by(id=recipe_id).first()
    if recipe is None:
        return failure_response("Recipe not found!", 404)
    return success_response(
        {"ingredients": [i.serialize() for i in recipe.ingredients]}
    )


@app.route("/api/recipes/<int:start>/duration/<int:end>/")
def get_recipes_with_duration(start, end):
    """
    Returns all dishes (recipes) that take between start and end to make.
    BODY:
    {
        time_unit: <string>
    }
    Error 400 if time_unit not specified
    """
    body = json.loads(request.data)
    time_unit = body.get("time_unit")
    if time_unit is None:
        return failure_response("Time unit not specified!")
    recipes = db.session.query(Recipe).filter(Recipe.time_unit == time_unit,
                                              Recipe.time >= start,
                                              Recipe.time <= end)
    return success_response({"recipes": [r.serialize() for r in recipes.all()]})


@app.route("/api/comments/")
def get_comments():
    """
    Returns all comments.
    """
    return success_response(
        {"comments": [c.serialize() for c in Comment.query.all()]}
    )


# ------------------------------ POST METHODS -------------------------------- #


@app.route("/api/ingredients/name/", methods=["POST"])
def add_ingredient_name():
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
    ingredient_name = IngredientName.query.filter_by(name=name).first()
    if ingredient_name is not None:
        return failure_response("Ingredient with this name already exists!", 404)
    new_ingredient_name = IngredientName(name=name)
    db.session.add(new_ingredient_name)
    db.session.commit()
    return success_response(new_ingredient_name.serialize(), 201)


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


@app.route("/api/recipes/<int:user_id>/", methods=["POST"])
def add_recipe_for_user(user_id: int):
    """
    Adds a recipe to a specific user profile.\n
    Parameters:
        user_id: id of user to add this recipe to
    BODY:
        {
            "name": <string>,
            "time": <integer>,
            "time_unit": <string>,
            "difficulty: <string>,
            "meal_type": <string>,
            "cuisine": <string>,
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
    time = body.get("time")
    if time is None:
        return failure_response("Time not specified!", 400)
    time_unit = body.get("time_unit")
    if time_unit is None:
        return failure_response("Time unit not specified!", 400)
    difficulty = body.get("difficulty")
    if difficulty is None:
        return failure_response("Difficulty not specified!", 400)
    meal_type = body.get("meal_type")
    if meal_type is None:
        return failure_response("Meal type not specified!", 400)
    cuisine = body.get("cuisine")
    if cuisine is None:
        return failure_response("Cuisine not specified!", 400)
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

    new_recipe = Recipe(name=name,
                        time=time,
                        time_unit=time_unit,
                        difficulty=difficulty,
                        meal_type=meal_type,
                        cuisine=cuisine,
                        user_id=user_id)
    db.session.add(new_recipe)
    db.session.flush()
    db.session.refresh(new_recipe)
    recipe_id = new_recipe.id
    for ingredient in ingredients:
        db_ingredient_name = IngredientName.query.filter_by(
            name=ingredient.get("name")).first()
        if db_ingredient_name is None:
            db_ingredient_name = IngredientName(name=ingredient.get("name"))
            db.session.add(db_ingredient_name)
            db.session.flush()
            db.session.refresh(db_ingredient_name)
        new_ingredient = Ingredient(recipe_id=recipe_id,
                                    ingredient_name_id=db_ingredient_name.id,
                                    name=db_ingredient_name.name,
                                    amount=ingredient.get("amount"),
                                    is_metric=ingredient.get("is_metric"),
                                    unit=ingredient.get("unit"))
        db.session.add(new_ingredient)
        # db_ingredient_name.associated_metrics.append(new_ingredient)
        new_recipe.ingredients.append(new_ingredient)
    db.session.commit()
    return success_response(new_recipe.serialize())


@app.route("/api/recipes/<int:user_id>/like/<int:recipe_id>/", methods=["POST"])
def like_recipe(user_id, recipe_id):
    """
    Have the user with user_id like the recipe with recipe_id.
    Returns the liked recipe.
    Error 404 if either the user doesn't exist or recipe doesn't exist.
    """
    user = User.query.filter_by(id=user_id).first()
    if user is None:
        return failure_response("User not found!", 404)
    recipe = Recipe.query.filter_by(id=recipe_id).first()
    if recipe is None:
        return failure_response("Recipe not found!", 404)
    already_liked = False
    for r in user.liked_recipes:
        if recipe_id == r.id:
            already_liked = True
            break
    if already_liked:
        return success_response(recipe.serialize())

    user.liked_recipes.append(recipe)
    db.session.commit()
    return success_response(recipe.serialize())


@app.route("/api/recipes/<int:user_id>/unlike/<int:recipe_id>/", methods=["POST"])
def unlike_recipe(user_id, recipe_id):
    """
    Have the user with user_id unlike the recipe with recipe_id.
    Returns the unliked recipe.
    Error 404 if either the user doesn't exist or recipe doesn't exist.
    Error 403 if the user hasn't liked this recipe
    """
    user = User.query.filter_by(id=user_id).first()
    if user is None:
        return failure_response("User not found!", 404)
    recipe = Recipe.query.filter_by(id=recipe_id).first()
    if recipe is None:
        return failure_response("Recipe not found!", 404)
    for r in user.liked_recipes:
        if r.id == recipe.id:
            user.liked_recipes.remove(r)
            db.session.commit()
            return success_response(recipe.serialize())
    db.session.commit()
    return failure_response("This user has not liked this recipe!", 403)


@app.route("/api/comments/<int:user_id>/recipe/<int:recipe_id>/", methods=["POST"])
def add_comment_from_user_to_recipe(user_id, recipe_id):
    user = User.query.filter_by(id=user_id).first()
    if user is None:
        return failure_response("User not found!", 404)
    recipe = Recipe.query.filter_by(id=recipe_id).first()
    if recipe is None:
        return failure_response("Recipe not found!", 404)
    body = json.loads(request.data)
    text = body.get("text")
    if text is None or len(text) == 0 or text.isspace():
        return failure_response("Text not found")
    if len(text) == 0 or text.isspace():
        return failure_response("Text cannot be empty or contain only whitespace!")
    new_comment = Comment(text=text, user_id=user_id, recipe_id=recipe_id)
    db.session.add(new_comment)
    recipe.comments.append(new_comment)
    user.comments.append(new_comment)
    db.session.commit()
    return success_response(new_comment.serialize())


# -------------------------------- DEL METHODS ------------------------------- #


@app.route("/api/users/<int:user_id>/", methods=["DELETE"])
def delete_user(user_id):
    """
    Deletes user with associated user_id.
    This removes the user entirely from the database.
    Error 404 if this user never existed to begin with.
    Returns the deleted user.
    """
    user = User.query.filter_by(id=user_id).first()
    if user is None:
        return failure_response("User not found!", 404)
    db.session.delete(user)
    db.session.commit()
    return success_response(user.serialize())


@app.route("/api/recipes/<int:recipe_id>/", methods=["DELETE"])
def delete_recipe(recipe_id):
    """
    Deletes recipe with associated recipe_id.
    This removes the recipe entirely from the database.
    Error 404 if this recipe never existed to begin with.
    Returns the deleted recipe.
    """
    recipe = Recipe.query.filter_by(id=recipe_id).first()
    if recipe is None:
        return failure_response("Recipe not found!", 404)
    db.session.delete(recipe)
    db.session.commit()
    return success_response(recipe.serialize())


@app.route("/api/comments/<int:comment_id>/", methods=["DELETE"])
def delete_comment(comment_id):
    """
    Deletes comment with associated comment_id.
    This removes the comments entirely from the database.
    Error 404 if this comment never existed to begin with.
    Returns the deleted comment.
    """
    comment = Comment.query.filter_by(id=comment_id).first()
    if comment is None:
        return failure_response("Comment not found!", 404)
    db.session.delete(comment)
    db.session.commit()
    return success_response(comment.serialize())


@app.route("/api/ingredients/name/<int:ingredient_name_id>/", methods=["DELETE"])
def delete_ingredient_name(ingredient_name_id):
    """
    Deletes ingredient name with associated ingredient_name_id.
    This removes the ingredient name entirely from the database.
    Error 404 if this ingredient name never existed to begin with.
    Returns the deleted ingredient name.
    """
    ingredient_name = IngredientName.query.filter_by(
        id=ingredient_name_id).first()
    if ingredient_name is None:
        return failure_response("Ingredient name not found!", 404)
    db.session.delete(ingredient_name)
    db.session.commit()
    return success_response(ingredient_name.serialize())


if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000, debug=True)
