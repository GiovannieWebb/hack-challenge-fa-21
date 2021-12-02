//
//  Comments.swift
//  CornellCookbook
//
//  Created by Kayla Sprayberry on 12/1/21.
//

import UIKit

struct Comments: Codable {
    var id: Int
    var userId: Int
    var recipeId: Int
    var text: String
    
    init(id: Int, userId: Int, text: String) {
        self.id = id
        self.userId = userId
        self.recipeId = 0
        self.text = text
    }
}


//"comments": [
//                {
//                    "id": <integer>,
//                    "user_id": <integer>,
//                    "recipe_id": <integer>,
//                    "text": <string>
//                },
