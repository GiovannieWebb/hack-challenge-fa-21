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
    
    init(stepNumber: Int, step: String) {
        self.stepNumber = stepNumber
        self.step = step
    }
}


//"instructions": [
//                {
//                    "step_number": <integer>
//                    "step": <string>
//                },
