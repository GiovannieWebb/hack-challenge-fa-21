//
//  NetworkManager.swift
//  CornellCookbook
//
//  Created by Kayla Sprayberry on 11/30/21.
//

import Foundation
import Alamofire

class NetworkManager{

    //what is the host
    static let host = "http://143.198.115.54:8080/"
    
    
    //get Methods
    static func getAllUsers(completion: @escaping ([User]) -> Void) {
        AF.request(host, method: .get).validate().responseData { response in
            switch response.result {
            case .success(let data):
                let jsonDecoder = JSONDecoder()
                if let post = try? jsonDecoder.decode([User].self, from: data) {
                    completion(post)
                }
            case .failure(let error):
                print(error)
            }
    }
        
    }
    
    static func getAllRecipes (completion: @escaping ([Recipie]) -> Void)
    {
        AF.request(host, method: .get).validate().responseData { response in
            switch response.result {
            case .success(let data):
                let jsonDecoder = JSONDecoder()
                if let post = try? jsonDecoder.decode([Recipie].self, from: data) {
                    completion(post)
                }
            case .failure(let error):
                print(error)
            }
    }
    }
    
//    static func getIngredients (completion: @escaping ([Ingredients]) -> Void)
//    {
//        AF.request(host, method: .get).validate().responseData { response in
//            switch response.result {
//            case .success(let data):
//                let jsonDecoder = JSONDecoder()
//                if let post = try? jsonDecoder.decode([Ingredients].self, from: data) {
//                    completion(post)
//                }
//            case .failure(let error):
//                print(error)
//            }
//    }
//    }
    
    static func getLikedRecipesFromUser (userId: Int, completion: @escaping ([Recipie]) -> Void)
    {
        AF.request(host, method: .get, parameters: userId).validate().responseData { response in
            switch response.result {
            case .success(let data):
                let jsonDecoder = JSONDecoder()
                if let post = try? jsonDecoder.decode([Recipie].self, from: data) {
                    completion(post)
                }
            case .failure(let error):
                print(error)
            }
    }
    }
    
    static func getPostedRecipesFromUser (userId: Int, completion: @escaping ([Recipie]) -> Void)
    {
        AF.request(host, method: .get, parameters: userId).validate().responseData { response in
            switch response.result {
            case .success(let data):
                let jsonDecoder = JSONDecoder()
                if let post = try? jsonDecoder.decode([Recipie].self, from: data) {
                    completion(post)
                }
            case .failure(let error):
                print(error)
            }
    }
    }
    
    static func getCommentedRecipesFromUser (userId: Int, completion: @escaping ([Recipie]) -> Void)
    {
        AF.request(host, method: .get, parameters: userId).validate().responseData { response in
            switch response.result {
            case .success(let data):
                let jsonDecoder = JSONDecoder()
                if let post = try? jsonDecoder.decode([Recipie].self, from: data) {
                    completion(post)
                }
            case .failure(let error):
                print(error)
            }
    }
    }
    
    static func getIngredientsForSpecificRecipe (recipeId: Int, completion: @escaping ([Ingredients]) -> Void)
    {
        AF.request(host, method: .get, parameters: recipeId).validate().responseData { response in
            switch response.result {
            case .success(let data):
                let jsonDecoder = JSONDecoder()
                if let post = try? jsonDecoder.decode([Ingredients].self, from: data) {
                    completion(post)
                }
            case .failure(let error):
                print(error)
            }
    }
    }
    
    static func getInstructionsForSpecificRecipe (recipeId: Int, completion: @escaping ([Instructions]) -> Void)
    {
        AF.request(host, method: .get, parameters: recipeId).validate().responseData { response in
            switch response.result {
            case .success(let data):
                let jsonDecoder = JSONDecoder()
                if let post = try? jsonDecoder.decode([Instructions].self, from: data) {
                    completion(post)
                }
            case .failure(let error):
                print(error)
            }
    }
    }
    
//    static func getComments (completion: @escaping ([Recipie]) -> Void)
//    {
//
//    }
    
    static func getCommentsUnderRecipe (recipeId: Int, completion: @escaping ([Comments]) -> Void)
    {
        AF.request(host, method: .get, parameters: recipeId).validate().responseData { response in
            switch response.result {
            case .success(let data):
                let jsonDecoder = JSONDecoder()
                if let post = try? jsonDecoder.decode([Comments].self, from: data) {
                    completion(post)
                }
            case .failure(let error):
                print(error)
            }
    }
    }
    
    static func getCommentsByUser (userId: Int, completion: @escaping ([Comments]) -> Void)
    {
        AF.request(host, method: .get, parameters: userId).validate().responseData { response in
            switch response.result {
            case .success(let data):
                let jsonDecoder = JSONDecoder()
                if let post = try? jsonDecoder.decode([Comments].self, from: data) {
                    completion(post)
                }
            case .failure(let error):
                print(error)
            }
    }
    }
    static func getRecipeById (recipeId: Int, completion: @escaping (Recipie) -> Void ) {
        AF.request(host, method: .get, parameters: recipeId).validate().responseData { response in
            switch response.result {
            case .success(let data):
                let jsonDecoder = JSONDecoder()
                if let post = try? jsonDecoder.decode(Recipie.self, from: data) {
                    completion(post)
                }
            case .failure(let error):
                print(error)
            }
    }
    }
    
    static func getRecipesByFilter (completion: @escaping ([Recipie]) -> Void)
    {
        AF.request(host, method: .get).validate().responseData { response in
            switch response.result {
            case .success(let data):
                let jsonDecoder = JSONDecoder()
                if let post = try? jsonDecoder.decode([Recipie].self, from: data) {
                    completion(post)
                }
            case .failure(let error):
                print(error)
            }
    }
    }
    
    
    //post methods
    static func registerAccount (completion: @escaping ([Recipie]) -> Void)
    {
        AF.request(host, method: .post).validate().responseData { response in
            switch response.result {
            case .success(let data):
                let jsonDecoder = JSONDecoder()
                if let post = try? jsonDecoder.decode([Recipie].self, from: data) {
                    completion(post)
                }
            case .failure(let error):
                print(error)
            }
    }
    }
    
    static func login (completion: @escaping ([Recipie]) -> Void)
    {
        AF.request(host, method: .post).validate().responseData { response in
            switch response.result {
            case .success(let data):
                let jsonDecoder = JSONDecoder()
                if let post = try? jsonDecoder.decode([Recipie].self, from: data) {
                    completion(post)
                }
            case .failure(let error):
                print(error)
            }
    }
    }
    
    static func updateSession (completion: @escaping ([Recipie]) -> Void)
    {
        
    }
    
    static func getUserFromValidatedSession (completion: @escaping ([Recipie]) -> Void)
    {
        
    }
    
    static func postRecipeForUser (completion: @escaping ([Recipie]) -> Void)
    {
        
    }
    
    
    static func updateRecipe (completion: @escaping ([Recipie]) -> Void)
    {
        
    }
    
    static func likeRecipe (completion: @escaping ([Recipie]) -> Void)
    {
        
    }
    
    static func unlikeRecipe (completion: @escaping ([Recipie]) -> Void)
    {
        
    }
    
    static func addCommentFromUsertoRecipe (completion: @escaping ([Recipie]) -> Void)
    {
        
    }
    
    static func updateComment (completion: @escaping ([Recipie]) -> Void)
    {
        
    }
    
    static func updateUser (completion: @escaping ([Recipie]) -> Void)
    {
        
    }
    
    //delete methods
    static func deleteUser (completion: @escaping ([Recipie]) -> Void)
    {
        
    }
    
    static func deleteRecipe (completion: @escaping ([Recipie]) -> Void)
    {
        
    }
    
    static func deleteComment (completion: @escaping ([Recipie]) -> Void)
    {
        
    }
    
    
}
