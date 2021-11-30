import sys


class Constants:
    """
    Constants that the backend and frontend should communicate together to 
    maintain. Normally isn't good practice, but should be fine for this app.
    """
    valid_cuisines = [
        "american",
        "italian",
        "asian",
        "latin",
        "mexican",
        "jamaican",
        "japanese",
        "chinese",
        "korean",
        "indian",
        "other"
    ]

    valid_difficulty_levels = [
        "beginner",
        "intermediate",
        "expert"
    ]

    valid_meal_types = [
        "breakfast",
        "lunch",
        "dinner",
        "snack"
    ]

    default_time = {
        "lower": 0,
        "upper": sys.maxsize
    }

    default_likes = {
        "lower": 0,
        "upper": sys.maxsize
    }

    default_created = {
        "before": sys.maxsize,
        "after": 0
    }
