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
    __tablename__ = 'user'
    id = db.Column(db.Integer, primary_key=True)
    username = db.Column(db.String, nullable=False)
    email = db.Column(db.String, nullable=False)
    password = db.Column(db.String, nullable=True)
    posted_recipes = db.relationship("Recipe", cascade="delete")
    liked_recipes = db.relationship(
        "Recipe", secondary=user_liked_recipes, back_populates="users_liked")
    comments = db.relationship("Comment", cascade="delete")

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
            "posted_comments": [pc.serialize_without_user_id() for pc in self.comments]
        }

    def serialize_without_recipes(self):
        return {
            "id": self.id,
            "username": self.username,
            "email": self.email,
            "posted_comments": [pc.serialize_without_user_id() for pc in self.comments]
        }


class Recipe(db.Model):
    __tablename__ = 'recipe'
    id = db.Column(db.Integer, primary_key=True)
    name = db.Column(db.String, nullable=False)
    time = db.Column(db.Integer, nullable=False)
    time_unit = db.Column(db.Integer, nullable=True)
    difficulty = db.Column(db.String, nullable=False)
    meal_type = db.Column(db.String, nullable=False)
    cuisine = db.Column(db.String, nullable=False)
    user_id = db.Column(db.Integer, db.ForeignKey("user.id"))
    users_liked = db.relationship(
        "User", secondary=user_liked_recipes, back_populates="liked_recipes")
    comments = db.relationship("Comment", cascade="delete")
    ingredients = db.relationship("Ingredient", cascade="delete")
    instructions = db.relationship("Instruction", cascade="delete")

    def __init__(self, **kwargs):
        self.name = kwargs.get("name")
        self.time = kwargs.get("time")
        self.time_unit = kwargs.get("time_unit")
        self.difficulty = kwargs.get("difficulty")
        self.meal_type = kwargs.get("meal_type")
        self.cuisine = kwargs.get("cuisine")
        self.user_id = kwargs.get("user_id")

    def serialize(self):
        return {
            "id": self.id,
            "user_id": self.user_id,
            "name": self.name,
            "time": self.time,
            "time_unit": self.time_unit,
            "ingredients": [i.serialize_without_recipe_id() for i in self.ingredients],
            "instructions": sorted([ins.serialize_without_recipe_id() for ins in self.instructions], key=lambda x: x.get("step_number")),
            "comments": [c.serialize_without_recipe_id() for c in self.comments],
            "likes": len(self.users_liked),
            "users_liked": [ul.serialize_without_recipes() for ul in self.users_liked]
        }

    def serialize_without_users_liked(self):
        return {
            "id": self.id,
            "user_id": self.user_id,
            "name": self.name,
            "time": self.time,
            "time_unit": self.time_unit,
            "ingredients": [i.serialize_without_recipe_id() for i in self.ingredients],
            "instructions": sorted([ins.serialize_without_recipe_id() for ins in self.instructions], key=lambda x: x.get("step_number")),
            "comments": [c.serialize_without_recipe_id() for c in self.comments],
            "likes": len(self.users_liked)
        }


class Ingredient(db.Model):
    __tablename__ = 'ingredient'
    id = db.Column(db.Integer, primary_key=True)
    name = db.Column(db.String, nullable=False)
    amount = db.Column(db.Integer, nullable=False)
    is_metric = db.Column(db.Boolean, nullable=False)
    unit = db.Column(db.String, nullable=False)
    recipe_id = db.Column(db.Integer, db.ForeignKey("recipe.id"))
    ingredient_name_id = db.Column(
        db.Integer, db.ForeignKey("ingredient_name.id"))

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
    __tablename__ = 'comment'
    id = db.Column(db.Integer, primary_key=True)
    text = db.Column(db.String, nullable=False)
    user_id = db.Column(db.Integer, db.ForeignKey("user.id"))
    recipe_id = db.Column(db.Integer, db.ForeignKey("recipe.id"))

    def __init__(self, **kwargs):
        self.text = kwargs.get("text")
        self.user_id = kwargs.get("user_id")
        self.recipe_id = kwargs.get("recipe_id")

    def serialize(self):
        return {
            "id": self.id,
            "text": self.text,
            "user_id": self.user_id,
            "recipe_id": self.recipe_id
        }

    def serialize_without_recipe_id(self):
        return {
            "id": self.id,
            "text": self.text,
            "user_id": self.user_id,
        }

    def serialize_without_user_id(self):
        return {
            "id": self.id,
            "text": self.text,
            "recipe_id": self.recipe_id
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
