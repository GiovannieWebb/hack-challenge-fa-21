import json
from datetime import datetime
from time import mktime

from db import db
from db import Authentication, Comment, Ingredient, IngredientName, Instruction, Recipe, User
from constants import Constants
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

# random comment 

def success_response(data, code=200):
    return json.dumps(data), code


def failure_response(message, code=404):
    return json.dumps({"error": message}), code


# end of generalized response formats


def extract_token(request):
    """
    Gets token from authorization header.
    """
    token = request.headers.get("Authorization")
    if token is None:
        return False, "Missing authorization header!"
    token = token.replace("Bearer", "").strip()
    return True, token


# your routes here

# ------------------------------ GET METHODS --------------------------------- #


@app.route("/")
@app.route("/api/users/")
def get_all_users():
    """
    Description: Gets all users currently in database.
    Method: GET
    Query Parameters: None
    Headers: None
    Body: None
    Return: {
            "users": [
                {
                    "id": <integer>,
                    "username": <string>,
                    "email": <string>,
                    "posted_recipes": <recipe-list>,
                    "liked_recipes": <recipe-list-without-users-liked>,
                    "posted_comments": <comment-list-without-user-ids>
                },
                ...
            ]
        }
    Sucess Response: 200
    Error Responses: None
    """
    return success_response(
        {"users": [u.serialize() for u in User.query.all()]}
    )


@app.route("/api/recipes/")
def get_all_recipes():
    """
    Description: Gets all recipes currently in database.
    Method: GET
    Query Parameters: None
    Headers: None
    Body: None
    Return: {
            "recipes": [
                {
                    "id": <integer>,
                    "user_id": <integer>,
                    "name": <string>,
                    "time": <integer>,
                    "time_unit": <string>,
                    "difficulty": <string>,
                    "meal_type": <string>,
                    "cuisine": <string>,
                    "ingredients": <ingredient-list-without-recipe-ids>,
                    "instructions": <instructions-list-without-recipe-ids>,
                    "comments": <comments-list-without-recipe-ids>,
                    "number_of_likes": <integer>,
                    "users_liked": <users-list-without-recipes>,
                    "created_at": <integer> <- unix time (time since epoch in 1970)
                },
                ...
            ]
        }
    Sucess Response: 200
    Error Responses: None
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
    Description: Gets all recipes that a user has liked.
    Method: GET
    Query Parameters: user_id
    Headers: None
    Body: None
    Return: {
            "recipes": [
                {
                    "id": <integer>,
                    "user_id": <integer>,
                    "name": <string>,
                    "time": <integer>,
                    "time_unit": <string>,
                    "difficulty": <string>,
                    "meal_type": <string>,
                    "cuisine": <string>,
                    "ingredients": <ingredient-list-without-recipe-ids>,
                    "instructions": <instructions-list-without-recipe-ids>,
                    "comments": <comments-list-without-recipe-ids>,
                    "number_of_likes": <integer>,
                    "users_liked": <users-list-without-recipes>,
                    "created_at": <integer> <- unix time (time since epoch in 1970)
                },
                ...
            ]
        }
    Success Response: 200
    Error Responses: 404 if user does not exist
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
    Description: Gets all recipes that a user has posted.
    Method: GET
    Query Parameters: user_id
    Headers: None
    Body: None
    Return: {
            "recipes": [
                {
                    "id": <integer>,
                    "user_id": <integer>,
                    "name": <string>,
                    "time": <integer>,
                    "time_unit": <string>,
                    "difficulty": <string>,
                    "meal_type": <string>,
                    "cuisine": <string>,
                    "ingredients": <ingredient-list-without-recipe-ids>,
                    "instructions": <instructions-list-without-recipe-ids>,
                    "comments": <comments-list-without-recipe-ids>,
                    "number_of_likes": <integer>,
                    "users_liked": <users-list-without-recipes>,
                    "created_at": <integer> <- unix time (time since epoch in 1970)
                },
                ...
            ]
        }
    Success Response: 200
    Error Responses: 404 if user does not exist
    """
    user = User.query.filter_by(id=user_id).first()
    if user is None:
        return failure_response("User not found!", 404)
    return success_response({
        "posted_recipes": [pr.serialize() for pr in user.posted_recipes]
    })


@app.route("/api/ingredients/<int:recipe_id>/")
def get_ingredients_for_specific_recipe(recipe_id: int):
    """
    Description: Gets all ingredients for a specific recipe.
    Method: GET
    Query Parameters: recipe_id
    Headers: None
    Body: None
    Return: {
            "ingredients": [
                {
                    "id": <integer>,
                    "recipe_id": <integer>,
                    "name": <string>,
                    "amount": <integer>,
                    "unit": <string>
                },
                ...
            ]
        }
    Success Response: 200
    Error Responses: 404 if recipe does not exist.
    """
    recipe = Recipe.query.filter_by(id=recipe_id).first()
    if recipe is None:
        return failure_response("Recipe not found!", 404)
    return success_response(
        {"ingredients": [i.serialize() for i in recipe.ingredients]}
    )


@app.route("/api/instructions/<int:recipe_id>/")
def get_instructions_for_specific_recipe(recipe_id: int):
    """
    Description: Gets all instructions for a specific recipe.
    Method: GET
    Query Parameters: recipe_id
    Headers: None
    Body: None
    Return: {
            "instructions": [
                {
                    "id": <integer>,
                    "recipe_id": <integer>,
                    "step_number": <integer>,
                    "step": <string>
                },
                ...
            ]
        }
    Success Response: 200
    Error Responses: 404 if recipe does not exist.
    """
    recipe = Recipe.query.filter_by(id=recipe_id).first()
    if recipe is None:
        return failure_response("Recipe not found!", 404)
    return success_response({
        "instructions": [ins.serialize() for ins in recipe.instructions]
    })


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


@app.route("/api/comments/<int:recipe_id>/recipe/")
def get_comments_under_recipe(recipe_id: int):
    """
    Description: Gets all comments under a specific recipe.
    Method: GET
    Query Parameters: recipe_id
    Headers: None
    Body: None
    Return: {
            "comments": [
                {
                    "id": <integer>,
                    "user_id": <integer>,
                    "recipe_id": <integer>,
                    "text": <string>
                },
                ...
            ]
        }
    Success Response: 200
    Error Responses: 404 if recipe does not exist.
    """
    recipe = Recipe.query.filter_by(id=recipe_id).first()
    if recipe is None:
        return failure_response("Recipe not found!", 404)
    return success_response({
        "comments": [c.serialize() for c in recipe.comments]
    })


@app.route("/api/comments/<int:user_id>/user/")
def get_comments_by_user(user_id: int):
    """
    Returns all comments posted by the user with id user_id
    """
    user = User.query.filter_by(id=user_id).first()
    if user is None:
        return failure_response('User not found!', 404)
    return success_response({
        "posted_comments": [pc.serialize() for pc in user.posted_comments]
    })


@app.route("/api/recipes/filter/")
def get_recipes_by_filter():
    """
    Description: Gets all recipes matching a certain criteria described by 
    the filters. Returns the list of recipes that match the given filters.
    Method: GET
    Query Parameters: None
    Headers: None
    Body: {
        "difficulties": [], <- list of difficulty levels
        "meal_types": [], <- list of meal types
        "cuisines": [], <- list of cuisines
        "time": {
            "lower": <integer>,
            "upper": <integer>
        },
        "likes": {
            "lower": <integer>,
            "upper": <integer>
        }
        "created": {
            "before": <integer>, <- unix time (time since 1970 epoch)
            "after": <integer>, <- unix time (time since 1970 epoch)
        }
    }
    Return: {
        "recipes": [
            {
                "id": <integer>,
                "user_id": <integer>,
                "name": <string>,
                "time": <integer>,
                "time_unit": <string>,
                "difficulty": <string>,
                "meal_type": <string>,
                "cuisine": <string>,
                "ingredients": <ingredients-list-without-recipe-ids>,
                "instructions": <instructions-list-without-recipe-ids>,
                "comments": <list-of-comments-without-recipe-ids>,
                "number_of_likes": <integer>,
                "users_liked": [],
                "created_at": <integer> <- unix time (time since epoch in 1970)
            },
            ...
        ]
    }
    Success Response: 200
    Errors: None
    """
    body = json.loads(request.data)
    difficulties = body.get("difficulties", Constants.valid_difficulty_levels)
    meal_types = body.get("meal_types", Constants.valid_meal_types)
    cuisines = body.get("cuisines", Constants.valid_cuisines)
    time = body.get("time", Constants.default_time)
    likes = body.get("likes", Constants.default_likes)
    created = body.get("created", Constants.default_created)

    recipes = Recipe.query.filter(
        Recipe.difficulty.in_(tuple(difficulties)),
        Recipe.meal_type.in_(tuple(meal_types)),
        Recipe.cuisine.in_(tuple(cuisines)),
        Recipe.time >= time.get("lower"),
        Recipe.time <= time.get("upper"),
        Recipe.number_of_likes >= likes.get("lower"),
        Recipe.number_of_likes <= likes.get("upper"),
        Recipe.created_at >= created.get("after"),
        Recipe.created_at <= created.get("before")
    )

    return success_response({"recipes": [r.serialize() for r in recipes.all()]})


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


@app.route("/api/users/register/", methods=["POST"])
def register_account():
    """
    Description: Register's a new user account and adds that new user to the 
    database. Returns user's session token and its expiration date, and user's 
    update token and its expiration date.
    Method: POST
    Query Parameters: None
    Headers: None
    Body: {
        "username": <string>,
        "email": <string>,
        "password": <string>
    }
    Return: {
        "session_token": <string>,
        "session_expiration": <string>, <- string of datetime object
        "update_token": <string>,
        "update_token_expiration": <string>, <- string of datetime object
    }
    Sucess Response: 201
    Error Responses: 400 if username, email, or password not specified.
                     403 if user already exists.
    """
    body = json.loads(request.data)
    username = body.get("username")
    if username is None:
        return failure_response("Username not specified!", 400)
    email = body.get("email")
    if email is None:
        return failure_response("Email not specified!", 400)
    password = body.get("password")
    if password is None:
        return failure_response("Password not specified!", 400)

    created, user = Authentication.create_user(username, email, password)
    if not created:
        return failure_response("User already exists!", 403)

    return success_response({
        "session_token": user.session_token,
        "session_expiration": str(user.session_expiration),
        "update_token": user.update_token,
        "update_token_expiration": str(user.update_token_expiration)
    }, 201)

    # new_user = User(username=username, email=email, password=password)
    # db.session.add(new_user)
    # db.session.commit()
    # return success_response(new_user.serialize(), 201)


@app.route("/api/users/login/", methods=["POST"])
def login():
    """
    Description: Logs a user in. Returns user's session token and its expiration 
    date, and user's update token and expiration date.
    Method: POST
    Query Parameters: None
    Headers: None
    Body: {
        "email": <string>,
        "password": <string>
    }
    Return: {
        "session_token": <string>,
        "session_expiration": <string>, <- string of datetime object
        "update_token": <string>,
        "update_token_expiration": <string>, <- string of datetime object
    }
    Sucess Response: 200
    Error Responses: 400 email or password not specified.
                     404 if email or password incorrect.
    """
    body = json.loads(request.data)
    email = body.get("email")
    if email is None:
        return failure_response("Email not specified!", 400)
    password = body.get("password", 400)
    if password is None:
        return failure_response("Password not specified!", 400)

    valid_creds, user = Authentication.verify_credentials(email, password)
    if not valid_creds:
        return failure_response("Invalid email or password!")

    return success_response({
        "session_token": user.session_token,
        "session_expiration": str(user.session_expiration),
        "update_token": user.update_token,
        "update_token_expiration": str(user.update_token_expiration)
    })


@app.route("/api/users/session/update/", methods=["POST"])
def update_session():
    """
    Description: Updates a user's session. Returns user's session token and its 
    expiration date, and user's update token and expiration date.
    Method: POST
    Query Parameters: None
    Headers: Key - "Authorization", Value - "Bearer <update-token>"
    Body: None
    Return: {
        "session_token": <string>,
        "session_expiration": <string>, <- string of datetime object
        "update_token": <string>,
        "update_token_expiration": <string>, <- string of datetime object
    }
    Sucess Response: 200
    Error Responses: 400 if invalid update token.
    """
    success, update_token = extract_token(request)
    if not success:
        return failure_response(update_token)

    valid, user = Authentication.renew_session(update_token)
    if not valid:
        return failure_response("Invalid update token!")

    return success_response({
        "session_token": user.session_token,
        "session_expiration": str(user.session_expiration),
        "update_token": user.update_token,
        "update_token_expiration": str(user.update_token_expiration)
    })


@app.route("/api/users/session/validate/")
def validate_session():
    """
    Description: Validates a user's session. Returns the (serialized) user of 
    the validated session.
    Method: GET
    Query Parameters: None
    Headers: Key - "Authorization", Value - "Bearer <session-token>"
    Body: None
    Return: {
        "id": <integer>,
        "username": <string>,
        "email": <string>,
        "posted_recipes": <recipe-list>,
        "liked_recipes": <recipe-list-without-users-liked>,
        "posted_comments": <comment-list-without-user-ids>
    }
    Sucess Response: 200
    Error Responses: 400 if invalid session token.
    """
    sucess, session_token = extract_token(request)
    if not sucess:
        return failure_response(session_token)

    valid_user = Authentication.verify_session(session_token)
    if valid_user is None:
        return failure_response("Invalid session token!")

    return success_response(valid_user.serialize())


@app.route("/api/recipes/<int:user_id>/", methods=["POST"])
def add_recipe_for_user(user_id: int):
    """
    Description: Adds a recipe to a specific user profile.
    Returns the newly created recipe.
    Method: POST
    Query Parameters: user_id
    Headers: None
    Body: {
            "name": <string>,
            "time": <integer>,
            "time_unit": <string>,
            "difficulty: <string>,
            "meal_type": <string>,
            "cuisine": <string>,
            "ingredients": [
                {
                    "name": <string>,
                    "amount": <integer>,
                    "unit": <string>
                },
                ...
            ],
            "instructions": [
                {
                    "step_number": <integer>
                    "step": <string>
                },
                ...
            ]
        }
    Return: {
        "id": <integer>,
        "user_id": <integer>,
        "name": <string>,
        "time": <integer>,
        "time_unit": <string>,
        "difficulty": <string>,
        "meal_type": <string>,
        "cuisine": <string>,
        "ingredients": <ingredients-list-without-recipe-ids>,
        "instructions": <instructions-list-without-recipe-ids>,
        "comments": [],
        "number_of_likes": 0,
        "users_liked": [],
        "created_at": <integer> <- unix time (time since epoch in 1970)
    }
    Success Response: 200
    Error Responses: 404 if user not found.
                     400 if any fields not specified.
    """
    # Check if user is valid
    user = User.query.filter_by(id=user_id).first()
    if user is None:
        return failure_response("User not found!")

    body = json.loads(request.data)

    # Check all parts of body to see if body is valid
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
    instructions = body.get("instructions")
    if instructions is None:
        return failure_response("Instructions not specified!", 400)
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
    for ins in instructions:
        sn = ins.get("step_number")
        if sn is None:
            return failure_response("Step number not specified for a given instruction!", 400)
        s = ins.get("step")
        if s is None:
            return failure_response("Step not given for a given instruction!", 400)
        if len(s) == 0 or s.isspace():
            return failure_response("No step can be only whitespace!", 400)
    # End of body check (it's a lot, I know)

    new_recipe = Recipe(name=name,
                        user_id=user_id,
                        time=time,
                        time_unit=time_unit,
                        difficulty=difficulty,
                        meal_type=meal_type,
                        cuisine=cuisine,
                        created_at=int(mktime(datetime.now().timetuple())))
    # need to reload the new recipe so we can receive it's newly assigned id
    db.session.add(new_recipe)
    db.session.flush()
    db.session.refresh(new_recipe)
    recipe_id = new_recipe.id
    # add ingredients
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

    # add instructions
    for instruction in instructions:
        new_step = Instruction(recipe_id=recipe_id,
                               step_number=instruction.get("step_number"),
                               step=instruction.get("step"))
        db.session.add(new_step)
        new_recipe.instructions.append(new_step)
    db.session.commit()
    return success_response(new_recipe.serialize(), 201)


@ app.route("/api/recipes/<int:user_id>/like/<int:recipe_id>/", methods=["POST"])
def like_recipe(user_id: int, recipe_id: int):
    """
    Description: Has a specific user like a specific recipe. Does nothing if the
    user has already liked this recipe. Returns the liked recipe.
    Method: POST
    Query Parameters: user_id, recipe_id
    Headers: None
    Body: None
    Return: {
        "id": <integer>,
        "user_id": <integer>,
        "name": <string>,
        "time": <integer>,
        "time_unit": <string>,
        "difficulty": <string>,
        "meal_type": <string>,
        "cuisine": <string>,
        "ingredients": <ingredients-list-without-recipe-ids>,
        "instructions": <instructions-list-without-recipe-ids>,
        "comments": <comment-list-without-recipe-ids>,
        "number_of_likes": <integer>,
        "users_liked": <user-list-without-recipes>,
        "created_at": <integer> <- unix time (time since epoch in 1970)
    }
    Success Response: 200
    Error Responses: 404 if user or recipe not found.
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

    recipe.number_of_likes += 1
    user.liked_recipes.append(recipe)
    db.session.commit()
    return success_response(recipe.serialize())


@ app.route("/api/recipes/<int:user_id>/unlike/<int:recipe_id>/", methods=["POST"])
def unlike_recipe(user_id: int, recipe_id: int):
    """
    Description: Has a specific user remove their like for specific recipe.
    Returns the unliked recipe.
    Method: POST
    Query Parameters: user_id, recipe_id
    Headers: None
    Body: None
    Return: {
        "id": <integer>,
        "user_id": <integer>,
        "name": <string>,
        "time": <integer>,
        "time_unit": <string>,
        "difficulty": <string>,
        "meal_type": <string>,
        "cuisine": <string>,
        "ingredients": <ingredients-list-without-recipe-ids>,
        "instructions": <instructions-list-without-recipe-ids>,
        "comments": <comment-list-without-recipe-ids>,
        "number_of_likes": <integer>,
        "users_liked": <user-list-without-recipes>,
        "created_at": <integer> <- unix time (time since epoch in 1970)
    }
    Success Response: 200
    Error Responses: 404 if user or recipe not found.
                     403 if the user didn't have this recipe liked in the first 
                     place.
    """
    user = User.query.filter_by(id=user_id).first()
    if user is None:
        return failure_response("User not found!", 404)
    recipe = Recipe.query.filter_by(id=recipe_id).first()
    if recipe is None:
        return failure_response("Recipe not found!", 404)
    for r in user.liked_recipes:
        if r.id == recipe.id:
            recipe.number_of_likes -= 1
            user.liked_recipes.remove(r)
            db.session.commit()
            return success_response(recipe.serialize())
    db.session.commit()
    return failure_response("This user has not liked this recipe!", 403)


@ app.route("/api/comments/<int:user_id>/recipe/<int:recipe_id>/", methods=["POST"])
def add_comment_from_user_to_recipe(user_id: int, recipe_id: int):
    """
    Description: Has a specific user comment on a specific recipe. Returns the
    newly posted comment.
    Method: POST
    Query Parameters: user_id, recipe_id
    Headers: None
    Body: {
        "text": <string>
    }
    Return: {
        "id": <integer>,
        "user_id": <integer>,
        "recipe_id": <integer>,
        "text": <string>
    }
    Success Response: 201
    Error Responses: 404 if user or recipe not found.
    """
    user = User.query.filter_by(id=user_id).first()
    if user is None:
        return failure_response("User not found!", 404)
    recipe = Recipe.query.filter_by(id=recipe_id).first()
    if recipe is None:
        return failure_response("Recipe not found!", 404)
    body = json.loads(request.data)
    text = body.get("text")
    if text is None:
        return failure_response("Text not found")
    if len(text) == 0 or text.isspace():
        return failure_response("Text cannot be empty or contain only whitespace!")
    new_comment = Comment(text=text, user_id=user_id, recipe_id=recipe_id)
    db.session.add(new_comment)
    recipe.comments.append(new_comment)
    user.posted_comments.append(new_comment)
    db.session.commit()
    return success_response(new_comment.serialize(), 201)


# ------------------------------ DELETE METHODS ------------------------------ #


@ app.route("/api/users/<int:user_id>/", methods=["DELETE"])
def delete_user(user_id: int):
    """
    Description: Removes a user from the database entirely. Returns the deleted
    user.
    Method: DELETE
    Query Parameters: user_id
    Headers: None
    Body: None
    Return: {
        "id": <integer>,
        "username": <string>,
        "email": <string>,
        "posted_recipes": <recipe-list>,
        "liked_recipes": <recipe-list-without-users-liked>,
        "posted_comments": <comment-list-without-user-ids>
    }
    Success Response: 200
    Error Responses: 404 if user not found.
    """
    user = User.query.filter_by(id=user_id).first()
    if user is None:
        return failure_response("User not found!", 404)
    for recipe in user.liked_recipes:
        recipe.number_of_likes -= 1
    db.session.delete(user)
    db.session.commit()
    return success_response(user.serialize())


@ app.route("/api/recipes/<int:recipe_id>/", methods=["DELETE"])
def delete_recipe(recipe_id: int):
    """
    Description: Removes a recipe from the database entirely. Returns the
    deleted recipe.
    Method: DELETE
    Query Parameters: recipe_id
    Headers: None
    Body: None
    Return: {
        "id": <integer>,
        "user_id": <integer>,
        "name": <string>,
        "time": <integer>,
        "time_unit": <string>,
        "difficulty": <string>,
        "meal_type": <string>,
        "cuisine": <string>,
        "ingredients": <ingredients-list-without-recipe-ids>,
        "instructions": <instructions-list-without-recipe-ids>,
        "comments": <comment-list-without-recipe-ids>,
        "number_of_likes": <integer>,
        "users_liked": <user-list-without-recipes>,
        "created_at": <integer> <- unix time (time since epoch in 1970)
    }
    Success Response: 200
    Error Responses: 404 if recipe not found.
    """
    recipe = Recipe.query.filter_by(id=recipe_id).first()
    if recipe is None:
        return failure_response("Recipe not found!", 404)
    db.session.delete(recipe)
    db.session.commit()
    return success_response(recipe.serialize())


@ app.route("/api/comments/<int:comment_id>/", methods=["DELETE"])
def delete_comment(comment_id: int):
    """
    Description: Removes a comment from the database entirely. Returns the
    deleted comment.
    Method: DELETE
    Query Parameters: comment_id
    Headers: None
    Body: None
    Return: {
        "id": <integer>,
        "user_id": <integer>,
        "recipe_id": <integer>,
        "text": <string>
    }
    Success Response: 200
    Error Responses: 404 if comment not found.
    """
    comment = Comment.query.filter_by(id=comment_id).first()
    if comment is None:
        return failure_response("Comment not found!", 404)
    db.session.delete(comment)
    db.session.commit()
    return success_response(comment.serialize())


@ app.route("/api/ingredients/name/<int:ingredient_name_id>/", methods=["DELETE"])
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
