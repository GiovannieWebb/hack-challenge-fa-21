//
//  Recipie.swift
//  CornellCookbook
//
//  Created by Kayla Sprayberry on 11/20/21.
//

import Foundation
import UIKit

class Recipie {
    
    var name: String
    var instructions: String
    var ingredients: String
    var cuisine: String
    var isSelected: Bool
    var imageName: String

    init (name: String, instructions: String, ingredients: String, cuisine: String) {
        self.name = name
        self.instructions = instructions
        self.ingredients = ingredients
        self.cuisine = cuisine
        self.imageName = "pizza"
        self.isSelected = false
    }
    
    func getImage() -> UIImage {
        let imageName = isSelected ? "\(imageName)invert" : imageName
        guard let image = UIImage(named: imageName) else { return UIImage() }
        
        return image
    }
    
    
}
