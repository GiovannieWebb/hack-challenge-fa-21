//
//  Recipie.swift
//  CornellCookbook
//
//  Created by Kayla Sprayberry on 11/20/21.
//

import Foundation
import UIKit

struct Recipie: Codable {
    
    var userId: Int
    var name: String
    var time: Int
    var difficulty: String
    var mealType: String
    var cuisine: String
    var ingredients: [Ingredients]
    var instructions: [Instructions]
    var comments: [Comments]
    var numberOfLikes: Int
    var usersLiked: [User]
    var usersCommented: [User]
    var createdAt: Int
    var isSelected: Bool
    var imageName: String
    
    
    
//    "id": <integer>,
//                        "user_id": <integer>,
//                        "name": <string>,
//                        "time": <integer>,
//                        "difficulty": <string>,
//                        "meal_type": <string>,
//                        "cuisine": <string>,
//                        "ingredients": <ingredient-list-without-recipe-ids>,
//                        "instructions": <instructions-list-without-recipe-ids>,
//                        "comments": <comments-list-without-recipe-ids>,
//                        "number_of_likes": <integer>,
//                        "users_liked": <users-list-without-recipes>,
//                        "users_commented": <users-list-without-recipes>,
//                        "created_at": <integer> <- unix time (time since epoch in 1970)

    init (userId: Int, name: String, time: Int, difficulty: String, mealType: String, cuisine: String, ingredients: [Ingredients], instructions: [Instructions], comments: [Comments], numberOfLikes: Int, usersLiked: [User], usersCommented: [User], createdAt: Int) {
        self.userId = userId
        self.name = name
        self.time = time
        self.difficulty = difficulty
        self.mealType = mealType
        self.cuisine = cuisine
        self.ingredients = ingredients
        self.instructions = instructions
        self.comments = comments
        self.numberOfLikes = numberOfLikes
        self.usersLiked = usersLiked
        self.usersCommented = usersCommented
        self.createdAt = createdAt
//        self.ingredients = ingredients
        
        self.imageName = "pizza"
        self.isSelected = false
    }
    
    func getImage() -> UIImage {
        let imageName = isSelected ? "\(imageName)invert" : imageName
        guard let image = UIImage(named: imageName) else { return UIImage() }
        
        return image
    }
    
    func getName() -> UIImage {
        let imageName = isSelected ? "\(imageName)invert" : imageName
        guard let image = UIImage(named: imageName) else { return UIImage() }
        
        return image
    }
    
    func getTime() -> UIImage {
        let imageName = isSelected ? "\(imageName)invert" : imageName
        guard let image = UIImage(named: imageName) else { return UIImage() }
        
        return image
    }
    
    func getCuisine() -> UIImage {
        let imageName = isSelected ? "\(imageName)invert" : imageName
        guard let image = UIImage(named: imageName) else { return UIImage() }
        
        return image
    }
    
    func getDifficulty() -> UIImage {
        let imageName = isSelected ? "\(imageName)invert" : imageName
        guard let image = UIImage(named: imageName) else { return UIImage() }
        
        return image
    }

    
}
