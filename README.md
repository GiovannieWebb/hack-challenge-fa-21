# Hack Challenge Fall 2021

## App Name:
Cornell Cookbook

## App Tagline:
_Sharing Big Red recipes with the Cornell community!_


## A short description of the app (its purpose and features):
The purpose of the CornellCookbook app is to connect the Cornell community through the sharing of food recipes. Users are prompted to register accounts and are able to interact with the platform once logged in. Users are able to add new recipes, view existing recipes, and interact with other users via likes and comments on shared recipes. On a user's profile, posted and liked recipes are stored for easy access later. Recipes are organized by categories such as cuisine, difficulty, preparation time, and popularity, which makes user navigation more efficient and enjoyable!

## A list of how the app addresses each of the requirements:
  **Backend:**
   * Base URL (containerized with Docker, deployed via Heroku app. Note that the Heroku app may take some time to load on the first load/if the app hasn't been visited for a while, so give it a few seconds if need be)
    - https://cookbookendpoints.herokuapp.com/

   * 4+ routes (1 GET, 1 POST): 14 GET routes, 10 POST routes, 4 DELETE routes

   * 2+ tables with relation:
        1. User -- many-to-many with liked recipes, one-to-many with posted recipes (Recipe table relation)
        2. Recipe -- many-to-many with users who liked and one-to-many with user who posted, ingredients, and instructions (User, Ingredient, and Instruction table relations)
        3. Ingredient -- one-to-many with recipes (Recipe table relation)
        4. Instruction -- one-to-many with recipes (Recipe table relation)

   * API Specification: https://drive.google.com/file/d/1q3FCY79J1o2nTnD8N867aiosd68dDT9b/view?usp=sharing
    
  **IOS:**
  * AutoLayout using NSLayoutConstraint or SnapKit: 
      * AutoLayout using NSLayoutConstraint

  * At least one UICollectionView or UITableView: 
      * 1+ UICollectionViews and Tables
        1. UICollectionView: 3 on home page
        2. UITableView: 2 on recipe page, one for ingredients, and one for instructions
  * Integration with an API - this API must provide some meaningful value to your app.: 
      * API is used to get recipes to display 

  **Design:**
  * Figma files: 
    - https://www.figma.com/file/KIzluyhsHMUcSKnVBeIFgT/Hackathon-Challenge?node-id=0%3A1
    - https://www.figma.com/file/KIzluyhsHMUcSKnVBeIFgT/Hackathon-Challenge?node-id=9%3A2628

  * Fidelity Sketches and Explorations:
    - ![Active Recipe Exploration](/design/active-recipe-exploration-1.png)
    - ![Active Recipe Likes/Comments Edit](/design/active-recipe-likes-comments-edit-1.png)
    - ![Homepage](/design/homepage-1.png)
    - ![Homepage Exploration](/design/homepage-explorations-1.png)
    - ![New Recipe Exploration](/design/new-recipe-exploration-1.png)
    - ![Onboarding/Login/Signup](/design/onboarding-login-signup-1.png)
    - ![Profile and New Recipe Creation](/design/profile-and-new-recipe-creation-1.png)
    - ![Search Exploration](/design/search-exploration-1.png)
    - ![Visual Exploration](/design/visual-explorations-1.png)

## Some screenshots of app (highlight important features):
![Login/Sigup Page](/images/login-signup.png)
![User Signup Page](/images/user-signup.png)
![Homepage](/images/homepage.png)
![Recipe Filter](/images/filter.png)
![Recipe Ingredients View](/images/view-recipe-ingredients.png)
![Recipe Instructions View](/images/view-recipe-instructions.png)
![New Recipe Creation](/images/create-new-recipe.png)
![User Profile](/images/user-profile.png)




## Demo Video:

[![Cornell Cookbook Demo Video](http://img.youtube.com/vi/3tA_bOlpaOA/0.jpg)](http://www.youtube.com/watch?v=3tA_bOlpaOA)

