from flask_sqlalchemy import SQLAlchemy

db = SQLAlchemy()

"""
TODO:
    - Password authentication
    - Images ???
        - Demo on how to store images using Amazon S3

    - For the sake of simplicity, no need to store ingredient names in a table.
      Just let users specify whichever ingredient names they want.

    - Also don't need the "is_metric" field for each ingredient for the sake of
      simplicity. Just let users specify the unit as a string

    - Can limit the unit for time it takes dish to make to be minutes only, to 
      make filtering much simpler

    - Maybe don't need amount and unit for each ingredient?

    - Meal types, cuisines, and difficulty level should be 
      pre-defined/selectable from a dropdown menu for simplicity
"""

# an association table for the many-to-may relationship between users and liked
# posts (one user can like many posts, and one post can be liked by many users)
user_liked_recipes = db.Table(
    "user_liked_recipes",
    db.Model.metadata,
    db.Column("user_id", db.Integer, db.ForeignKey("user.id")),
    db.Column("recipe_id", db.Integer, db.ForeignKey("recipe.id"))
)


class User(db.Model):
    """
    Represents the table of users. 

    Each user has a username, email, password, 
    two lists of recipes--one list being the recipes they've posted, and
    the other being the recipes they've liked--and a list of all comments 
    they've posted on various recipes.

    There is a one-to-one relationship between users and usernames, users and 
    emails, and users and passwords. 
    There is a one-to-many relationship between users and their posted recipes. 
    There is a many-to-many relationship between users and liked recipes.
    """
    __tablename__ = 'user'
    id = db.Column(db.Integer, primary_key=True)
    username = db.Column(db.String, nullable=False)
    email = db.Column(db.String, nullable=False)
    password = db.Column(db.String, nullable=True)
    posted_recipes = db.relationship("Recipe", cascade="delete")
    liked_recipes = db.relationship(
        "Recipe", secondary=user_liked_recipes, back_populates="users_liked")
    posted_comments = db.relationship("Comment", cascade="delete")

    def __init__(self, **kwargs):
        self.username = kwargs.get("username")
        self.email = kwargs.get("email")
        self.password = kwargs.get("password")

    def serialize(self):
        return {
            "id": self.id,
            "username": self.username,
            "email": self.email,
            "posted_recipes": [pr.serialize() for pr in self.posted_recipes],
            "liked_recipes": [lr.serialize_without_users_liked() for lr in self.liked_recipes],
            "posted_comments": [pc.serialize_without_user_id() for pc in self.posted_comments]
        }

    def serialize_without_recipes(self):
        return {
            "id": self.id,
            "username": self.username,
            "email": self.email,
            "posted_comments": [pc.serialize_without_user_id() for pc in self.posted_comments]
        }


class Recipe(db.Model):
    """
    Represents the table of recipes. 

    Each recipe has a name, a time value for how long the dish should take to 
    make (and the unit for that time value), an associated difficulty (beginner, 
    intermediate, expert, etc.), meal type (breakfast, lunch, dinner, snack, 
    etc.) and cuisine (Asian, Latin, American, etc.). Each also has the id of 
    the user who posted this recipe, a list of users who have liked this recipe, 
    and lists of comments for comments under this recipe, as well as lists for 
    the ingredients and instructions.

    There is a one-to-one relationship between recipes and their names, 
    time/time unit, difficulty, meal time, and cuisine. 
    There is a one-to-many relationship between users and 'posted' recipes, 
    comments, ingredients, and instructions, and there is a many-to-many 
    relationship between users and liked recipes.
    """
    __tablename__ = 'recipe'
    id = db.Column(db.Integer, primary_key=True)
    user_id = db.Column(db.Integer, db.ForeignKey("user.id"))
    name = db.Column(db.String, nullable=False)
    time = db.Column(db.Integer, nullable=False)
    time_unit = db.Column(db.Integer, nullable=True)
    difficulty = db.Column(db.String, nullable=False)
    meal_type = db.Column(db.String, nullable=False)
    cuisine = db.Column(db.String, nullable=False)
    ingredients = db.relationship("Ingredient", cascade="delete")
    instructions = db.relationship("Instruction", cascade="delete")
    comments = db.relationship("Comment", cascade="delete")
    number_of_likes = db.Column(db.Integer, nullable=False)
    users_liked = db.relationship(
        "User", secondary=user_liked_recipes, back_populates="liked_recipes")
    created_at = db.Column(db.Integer, nullable=False)  # unix time

    def __init__(self, **kwargs):
        self.user_id = kwargs.get("user_id")
        self.name = kwargs.get("name")
        self.time = kwargs.get("time")
        self.time_unit = kwargs.get("time_unit")
        self.difficulty = kwargs.get("difficulty")
        self.meal_type = kwargs.get("meal_type")
        self.cuisine = kwargs.get("cuisine")
        self.created_at = kwargs.get("created_at")
        self.number_of_likes = 0

    def serialize(self):
        return {
            "id": self.id,
            "user_id": self.user_id,
            "name": self.name,
            "time": self.time,
            "time_unit": self.time_unit,
            "difficulty": self.difficulty,
            "meal_type": self.meal_type,
            "cuisine": self.cuisine,
            "ingredients": [i.serialize_without_recipe_id() for i in self.ingredients],
            "instructions": sorted([ins.serialize_without_recipe_id() for ins in self.instructions], key=lambda x: x.get("step_number")),
            "comments": [c.serialize_without_recipe_id() for c in self.comments],
            "number_of_likes": self.number_of_likes,
            "users_liked": [ul.serialize_without_recipes() for ul in self.users_liked],
            "created_at": self.created_at
        }

    def serialize_without_users_liked(self):
        return {
            "id": self.id,
            "user_id": self.user_id,
            "name": self.name,
            "time": self.time,
            "time_unit": self.time_unit,
            "difficulty": self.difficulty,
            "meal_type": self.meal_type,
            "cuisine": self.cuisine,
            "ingredients": [i.serialize_without_recipe_id() for i in self.ingredients],
            "instructions": sorted([ins.serialize_without_recipe_id() for ins in self.instructions], key=lambda x: x.get("step_number")),
            "comments": [c.serialize_without_recipe_id() for c in self.comments],
            "number_of_likes": self.number_of_likes,
            "created_at": self.created_at
        }


class Ingredient(db.Model):
    """
    Represents the table of ingredients. Each ingredient has a name, amount, and
    unit. It also holds the id of the recipe it's associated with.

    There is a one-to-one relationship between an ingredient and its name,
    amount, and unit. There is a one-to-many relationship between a recipe and 
    its ingredients. 
    """
    __tablename__ = 'ingredient'
    id = db.Column(db.Integer, primary_key=True)
    recipe_id = db.Column(db.Integer, db.ForeignKey("recipe.id"))
    ingredient_name_id = db.Column(
        db.Integer, db.ForeignKey("ingredient_name.id"))
    name = db.Column(db.String, nullable=False)
    amount = db.Column(db.Integer, nullable=False)
    is_metric = db.Column(db.Boolean, nullable=False)
    unit = db.Column(db.String, nullable=False)

    def __init__(self, **kwargs):
        self.recipe_id = kwargs.get("recipe_id")
        self.ingredient_name_id = kwargs.get("ingredient_name_id")
        self.name = kwargs.get("name")
        self.amount = kwargs.get("amount")
        self.is_metric = kwargs.get("is_metric")
        self.unit = kwargs.get("unit")

    def serialize(self):
        return {
            "id": self.id,
            "recipe_id": self.recipe_id,
            "ingredient_name_id": self.ingredient_name_id,
            "name": self.name,
            "amount": self.amount,
            "is_metric": self.is_metric,
            "unit": self.unit
        }

    def serialize_without_recipe_id(self):
        return {
            "id": self.id,
            "ingredient_name_id": self.ingredient_name_id,
            "name": self.name,
            "amount": self.amount,
            "is_metric": self.is_metric,
            "unit": self.unit
        }


class Instruction(db.Model):
    """
    Represents the table of instructions, or steps needed for each recipe. Each
    entry of this table is a single step, which contains the step itself as a 
    string, and the step number as an integer. It also holds the id of the 
    recipe it's associated with.

    There is a one-to-one relationship between an instruction and its 
    step/step numbers. There is a one-to-many relationship between a recipe and
    its corresponding instructions.
    """
    __tablename__ = 'instruction'
    id = db.Column(db.Integer, primary_key=True)
    recipe_id = db.Column(db.Integer, db.ForeignKey("recipe.id"))
    step_number = db.Column(db.Integer, nullable=False)
    step = db.Column(db.String, nullable=False)

    def __init__(self, **kwargs):
        self.recipe_id = kwargs.get("recipe_id")
        self.step_number = kwargs.get("step_number")
        self.step = kwargs.get("step")

    def serialize(self):
        return {
            "id": self.id,
            "recipe_id": self.recipe_id,
            "step_number": self.step_number,
            "step": self.step
        }

    def serialize_without_recipe_id(self):
        return {
            "id": self.id,
            "step_number": self.step_number,
            "step": self.step
        }


class Comment(db.Model):
    """
    Represents the table of comments. 
    Each comment holds its text, as well as the id of the user that posted it 
    and the id of the recipe it was posted under.

    There is a one-to-one relationship between a comment and its text.
    There is a one-to-many relationship between a user and the comments they've
    posted.
    There is a one-to-many relationship between a recipe and the comments posted
    under it.
    """
    __tablename__ = 'comment'
    id = db.Column(db.Integer, primary_key=True)
    user_id = db.Column(db.Integer, db.ForeignKey("user.id"))
    recipe_id = db.Column(db.Integer, db.ForeignKey("recipe.id"))
    text = db.Column(db.String, nullable=False)

    def __init__(self, **kwargs):
        self.user_id = kwargs.get("user_id")
        self.recipe_id = kwargs.get("recipe_id")
        self.text = kwargs.get("text")

    def serialize(self):
        return {
            "id": self.id,
            "user_id": self.user_id,
            "recipe_id": self.recipe_id,
            "text": self.text
        }

    def serialize_without_recipe_id(self):
        return {
            "id": self.id,
            "user_id": self.user_id,
            "text": self.text
        }

    def serialize_without_user_id(self):
        return {
            "id": self.id,
            "recipe_id": self.recipe_id,
            "text": self.text
        }


class IngredientName(db.Model):
    __tablename__ = 'ingredient_name'
    id = db.Column(db.Integer, primary_key=True)
    name = db.Column(db.String, nullable=False)
    # associated_metrics = db.relationship("Ingredient", cascade="delete")

    def __init__(self, **kwargs):
        self.name = kwargs.get("name")

    def serialize(self):
        return {
            "id": self.id,
            "name": self.name
        }
