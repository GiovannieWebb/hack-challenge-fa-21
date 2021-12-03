//
//  Ingredients.swift
//  CornellCookbook
//
//  Created by Kayla Sprayberry on 12/1/21.
//

import UIKit

class Ingredients: Codable {

    var name: String
    var amount: Int
    var unit: String
    
    init(name: String, amount: Int, unit: String) {
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
