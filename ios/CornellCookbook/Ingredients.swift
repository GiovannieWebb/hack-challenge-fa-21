//
//  Ingredients.swift
//  CornellCookbook
//
//  Created by Kayla Sprayberry on 12/1/21.
//

import UIKit

struct IngredientResponse: Codable {
    var ingredients: [Ingredients]
}

struct Ingredients: Codable {

    var id: Int
    var name: String
    var amount: Int
    var unit: String
    
    init(id: Int, name: String, amount: Int, unit: String) {
        self.id = id
        self.name = name
        self.amount = amount
        self.unit = unit
    }
    
//    func getName (){
//        return self.name
//    }
}



//"ingredients": [
//                {
//                    "name": <string>,
//                    "amount": <integer>,
//                    "unit": <string>
//                },
