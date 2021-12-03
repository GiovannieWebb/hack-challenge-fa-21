//
//  Instructions.swift
//  CornellCookbook
//
//  Created by Kayla Sprayberry on 12/1/21.
//

import UIKit

class Instructions: Codable {
    var stepNumber: Int
    var step: String
    var id: Int
    
    init(id: Int, stepNumber: Int, step: String) {
        self.stepNumber = stepNumber
        self.id = id 
        self.step = step
    }
}


//"instructions": [
//                {
//                    "step_number": <integer>
//                    "step": <string>
//                },
