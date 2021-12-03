//
//  InstructionPopUp.swift
//  CornellCookbook
//
//  Created by Kayla Sprayberry on 12/2/21.
//

import UIKit

class InstructionPopUp: UIView {

     let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "New Ingredient"
        label.textColor = .black
        label.font = UIFont(name: "Galvji-Bold", size: 20)
        return label
    }()
    
     let instructionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Instructions"
        label.textColor = .black
        label.font = UIFont(name: "Galvji", size: 15)
        return label
    }()
    
    
    let instruction: UITextView = {
       let label = UITextView()
       label.translatesAutoresizingMaskIntoConstraints = false
//        label.text =
//       label.placeholder = "1/4 cup"
       label.textColor = .black
       label.backgroundColor = .white
       label.font = UIFont(name: "Galvji", size: 12)
       return label
   }()
    
    let addButton: UIButton = {
       let apply = UIButton()
        apply.setTitle("Add", for: .normal)
        apply.setTitleColor(.white, for: .normal)
        apply.backgroundColor = UIColor(red: 0.69, green: 0.082, blue: 0.192, alpha: 1)
        apply.layer.cornerRadius = 18
        apply.translatesAutoresizingMaskIntoConstraints = false
        apply.addTarget(self, action: #selector(addIngredient), for: .touchUpInside)
       return apply
   }()
    
    let exitButton: UIButton = {
       let apply = UIButton()
        let selected = false
        if let image = UIImage(named: "exit") {
            apply.setImage(image, for: .normal)
        }
        apply.translatesAutoresizingMaskIntoConstraints = false
        apply.addTarget(self, action: #selector(dismissView), for: .touchUpInside)
       return apply
   }()
    
    
    @objc func addIngredient(){
        //update ingredient list with name and units
    }
    
    @objc func dismissView(){
        self.removeFromSuperview()
//        dismiss(animated: true, completion: nil)
    }
    
    @objc func ifSelect(button: UIButton){
//        let selected = true
        let red = UIColor(red: 0.692, green: 0.084, blue: 0.157, alpha: 1)
        let orange = UIColor(red: 0.942, green: 0.657, blue: 0.451, alpha: 1)
        if button.backgroundColor != red {
            button.backgroundColor = red
//            selected = true
        } else {
            button.backgroundColor = orange
//            selected = false
        }
    }
    
    let container: UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.backgroundColor = UIColor(red: 1, green: 0.947, blue: 0.867, alpha: 1)
        v.layer.cornerRadius = 24
        return v
    }()
    
     lazy var stack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [titleLabel, instructionLabel])
        
        
        return stack
    }()
    
   
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
//        self.backgroundColor = .darkGray
        self.frame = UIScreen.main.bounds
        
        self.addSubview(container)
        
        self.addSubview(titleLabel)
        self.addSubview(instructionLabel)
        self.addSubview(instruction)
        self.addSubview(addButton)
        self.addSubview(exitButton)
        
//        begginerButton.titleLabel?.font = UIFont(name: "Galvji", size: 12)
        
//        container.widthAnchor.constraint(equalToConstant: 375).isActive = true
        container.heightAnchor.constraint(equalToConstant: 284).isActive = true
        container.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        container.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        container.topAnchor.constraint(equalTo: self.topAnchor, constant: 298).isActive = true
        
        titleLabel.widthAnchor.constraint(equalToConstant: 156).isActive = true
        titleLabel.heightAnchor.constraint(equalToConstant: 34).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 110).isActive = true
        titleLabel.topAnchor.constraint(equalTo: container.topAnchor, constant: 7).isActive = true
        
        instructionLabel.widthAnchor.constraint(equalToConstant: 105).isActive = true
        instructionLabel.heightAnchor.constraint(equalToConstant: 27).isActive = true
        instructionLabel.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 36).isActive = true
        instructionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 7).isActive = true

        
        instruction.widthAnchor.constraint(equalToConstant: 305).isActive = true
        instruction.heightAnchor.constraint(equalToConstant: 145).isActive = true
        instruction.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 47).isActive = true
        instruction.topAnchor.constraint(equalTo: instructionLabel.bottomAnchor).isActive = true
        
        addButton.widthAnchor.constraint(equalToConstant: 121).isActive = true
        addButton.heightAnchor.constraint(equalToConstant: 36).isActive = true
        addButton.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 129).isActive = true
        addButton.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: -10).isActive = true
        
        
        exitButton.widthAnchor.constraint(equalToConstant: 16.97).isActive = true
        exitButton.heightAnchor.constraint(equalToConstant: 16.97).isActive = true
        exitButton.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -14).isActive = true
        exitButton.topAnchor.constraint(equalTo: titleLabel.topAnchor).isActive = true
        
    }
    required init?(coder: NSCoder) {
        fatalError("no")
    }

}

