from flask_sqlalchemy import SQLAlchemy

db = SQLAlchemy()

"""
TODO:
  Password authentication
"""

# recipe_metric = db.Table(
#     "recipe_metric",
#     db.Model.metadata,
#     db.Column("recipe_id", db.Integer, db.ForeignKey("recipe.id")),
#     db.Column("metric_d", db.Integer, db.ForeignKey("metric.id"))
# )


class User(db.Model):
    __tablename__ = 'user'
    id = db.Column(db.Integer, primary_key=True)
    username = db.Column(db.String, nullable=False)
    email = db.Column(db.String, nullable=False)
    password = db.Column(db.String, nullable=True)
    liked_recipes = db.relationship("Recipe")
    posted_recipes = db.relationship("Recipe", cascade="delete")
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
            "liked_recipes": [r.serialize() for r in self.liked_recipes],
            "posted_recipes": [pr.serialize() for pr in self.posted_recipes],
            "comments": [c.serialize_without_user_id() for c in self.comments]
        }


class Metric(db.Model):
    __tablename__ = 'metric'
    id = db.Column(db.Integer, primary_key=True)
    ingredient_name = db.Column(db.String, nullable=False)
    amount = db.Column(db.Integer, nullable=False)
    is_metric = db.Column(db.Boolean, nullable=False)
    unit = db.Column(db.String, nullable=False)
    Fe_id = db.Column(db.Integer, db.ForeignKey("recipe.id"))
    ingredient_id = db.Column(db.Integer, db.ForeignKey("ingredient.id"))

    def __init__(self, **kwargs):
        self.recipe_id = kwargs.get("recipe_id")
        self.ingredient_id = kwargs.get("ingredient_id")
        self.ingredient_name = kwargs.get("ingredient_name")
        self.amount = kwargs.get("amount")
        self.is_metric = kwargs.get("is_metric")
        self.unit = kwargs.get("unit")

    def serialize(self):
        return {
            "id": self.id,
            "recipe_id": self.recipe_id,
            "ingredient_id": self.ingredient_id,
            "amount": self.amount,
            "is_metric": self.is_metric,
            "unit": self.unit
        }

    def serialize_without_recipe_id(self):
        return {
            "id": self.id,
            "ingredient_id": self.ingredient_id,
            "amount": self.amount,
            "is_metric": self.is_metric,
            "unit": self.unit
        }


class Recipe(db.Model):
    __tablename__ = 'recipe'
    id = db.Column(db.Integer, primary_key=True)
    name = db.Column(db.String, nullable=False)
    likes = db.Column(db.Integer, nullable=True)
    user_id = db.Column(db.Integer, db.ForeignKey("user.id"))
    comments = db.relationship("Comment", cascade="delete")
    contents = db.relationship("Metric", cascade="delete")

    def __init__(self, **kwargs):
        self.likes = 0
        self.name = kwargs.get("name")
        self.user_id = kwargs.get("user_id")

    def serialize(self):
        return {
            "id": self.id,
            "name": self.name,
            "likes": self.likes,
            "user_id": self.user_id,
            "contents": [m.serialize_without_recipe_id() for m in self.contents],
            "comments": [c.serialize_without_recipe_id() for c in self.comments]
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


class Ingredient(db.Model):
    __tablename__ = 'ingredient'
    id = db.Column(db.Integer, primary_key=True)
    name = db.Column(db.String, nullable=False)
    associated_metrics = db.relationship("Metric", cascade="delete")

    def __init__(self, **kwargs):
        self.name = kwargs.get("name")

    def serialize(self):
        return {
            "id": self.id,
            "name": self.name
        }
