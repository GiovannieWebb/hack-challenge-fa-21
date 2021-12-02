//
//  User.swift
//  CornellCookbook
//
//  Created by Kayla Sprayberry on 12/1/21.
//

import UIKit
import Foundation

struct User: Codable {
    var id: Int
    var username: String
    var email: String
    var postedRecipes: [Recipie]
    var likedRecipes: [Recipie]
    var postedComments: [String]
    
    init(id: Int, username: String, email: String, postedRecipes: [Recipie], likedRecipes : [Recipie], postedComments: [String]) {
        self.id = id
        self.username = username
        self.email = email
        self.postedRecipes = postedRecipes
        self.likedRecipes = likedRecipes
        self.postedComments = postedComments
    }
    
}
