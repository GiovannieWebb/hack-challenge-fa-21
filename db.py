from flask_sqlalchemy import SQLAlchemy

db = SQLAlchemy()

"""
TODO:
  Password authentication
"""

metric = db.Table(
    "metric",
    db.Model.metadata,
    db.Column("recipe_id", db.Integer, db.ForeignKey("recipe.id")),
    db.Column("ingredient_id", db.Integer, db.ForeignKey("ingredient.id")),
    db.Column("amount", db.Integer, nullable=False),
    db.Column("is_metric", db.Boolean, nullable=False),
    db.Column("unit", db.String, nullable=False)
)


class User(db.Model):
    __tablename__ = 'user'
    id = db.Column(db.Integer, primary_key=True)
    username = db.Column(db.String, nullable=False)
    email = db.Column(db.String, nullable=False)
    password = db.Column(db.String, nullable=True)
    liked_recipies = db.relationship("Recipe")
    posted_recipies = db.relationship("Recipe", cascade="delete")
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
            "liked_recipies": [r.serialize() for r in self.liked_recipies],
            "posted_recipies": [pr.serialize() for pr in self.posted_recipies],
            "comments": [c.serialize() for c in self.comments]
        }


class Recipe(db.Model):
    __tablename__ = 'recipe'
    id = db.Column(db.Integer, primary_key=True)
    likes = db.Column(db.Integer, nullable=True)
    comments = db.relationship("Comment", cascade="delete")

    def __init__(self, **kwargs):
        self.likes = 0

    def serialize(self):
        return {}


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
        return {}


class Ingredient(db.Model):
    __tablename__ = 'ingredient'
    id = db.Column(db.Integer, primary_key=True)
    name = db.Column(db.String, nullable=False)

    def __init__(self, **kwargs):
        self.name = kwargs.get("name")

    def serialize(self):
        return {}


"""
class Metric(db.Model):
    __tablename__ = 'metric'
    id = db.Column(db.Integer, primary_key=True)
    recipe_id = db.Column(db.Integer, db.ForeignKey("recipe.id"))
    ingredient_id = db.Column(db.Integer, db.ForeignKey("ingredient.id"))
    amount = db.Column(db.Integer, nullable=False)
    is_metric = db.Column(db.Boolean, nullable=False)
    unit_type = db.Column(db.String, nullable=False)

    def __init__(self, **kwargs):
        self.recipe_id = kwargs.get("recipe_id")
        self.ingredient_id = kwargs.get("ingredient_id")
        self.amount = kwargs.get("amount")
        self.is_metric = kwargs.get("is_metric")
        self.unit_type = kwargs.get("unit_type")
"""
