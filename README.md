# hack-challenge-fa-2021

**App Name:** CornellCookbook

**App Tagline:** Sharing Big Red recipes with the Cornell community!

**Some screenshots of app** (highlight important features):

**A short description of the app** (its purpose and features):
The purpose of the CornellCookbook app is to connect the Cornell community through the sharing of food recipes. Users are prompted to register accounts and are able to interact with the platform once logged in. Users are able to add new recipes, view existing recipes, and interact with other users via likes and comments on shared recipes. On a user's profile, posted and liked recipes are stored for easy access later. Recipes are organized by categories such as cuisine, difficulty, preparation time, and popularity, which makes user navigation more efficient and enjoyable!

**A list of the app addresses each of the requirements:**
  Backend: 4+ routes (1 GET, 1 POST): 14 GET routes, 10 POST routes, 4 DELETE routes
           2+ tables with relation:
              User -- many-to-many with liked recipes, one-to-many with posted recipes (Recipe table relation)
              Recipe -- many-to-many with users who liked and one-to-many with user who posted, ingredients, and instructions (User, Ingredient, and Instruction table relations)
              Incredient -- one-to-many with recipes (Recipe table relation)
              Instruction -- one-to-many with recipes (Recipe table relation)
           API Specification: found in repo
  IOS:
  Design:
 
