//
//  FilterPopUp.swift
//  CornellCookbook
//
//  Created by Kayla Sprayberry on 12/1/21.
//

import UIKit

class FilterPopUp: UIView {
//    let red = UIColor(red: 0.692, green: 0.084, blue: 0.157, alpha: 1)
    
    var  selected = false
     let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Filters"
        label.textColor = .black
        label.font = UIFont(name: "Galvji-Bold", size: 20)
        return label
    }()
    
     let difficultLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Difficulty"
        label.textColor = .black
        label.font = UIFont(name: "Galvji", size: 15)
        return label
    }()
    
    let timeLabel: UILabel = {
       let label = UILabel()
       label.translatesAutoresizingMaskIntoConstraints = false
       label.text = "Time"
        label.textColor = .black
       label.font = UIFont(name: "Galvji", size: 15)
       return label
   }()
    
    let mealLabel: UILabel = {
       let label = UILabel()
       label.translatesAutoresizingMaskIntoConstraints = false
       label.text = "Meal"
        label.textColor = .black
       label.font = UIFont(name: "Galvji", size: 15)
       return label
   }()
    
    let cuisineLabel: UILabel = {
       let label = UILabel()
       label.translatesAutoresizingMaskIntoConstraints = false
       label.text = "Cuisine"
        label.textColor = .black
       label.font = UIFont(name: "Galvji", size: 15)
       return label
   }()
    
    let applyButton: UIButton = {
       let apply = UIButton()
        apply.setTitle("Apply", for: .normal)
        apply.setTitleColor(.black, for: .normal)
        apply.backgroundColor = UIColor(red: 0.942, green: 0.657, blue: 0.451, alpha: 1)
        apply.layer.cornerRadius = 18
        apply.translatesAutoresizingMaskIntoConstraints = false
        apply.addTarget(self, action: #selector(applyFilters), for: .touchUpInside)
       return apply
   }()
    
    let begginerButton: UIButton = {
       let apply = UIButton()
        let selected = false
        apply.setTitle("Beginner", for: .normal)
        apply.setTitleColor(.black, for: .normal)
        apply.backgroundColor = UIColor(red: 0.942, green: 0.657, blue: 0.451, alpha: 1)
        apply.titleLabel?.font = UIFont(name: "Galvji", size: 12)
        apply.layer.cornerRadius = 13.5
        apply.translatesAutoresizingMaskIntoConstraints = false
        apply.addTarget(self, action: #selector(ifSelect), for: .touchUpInside)
       return apply
   }()
    
    let interButton: UIButton = {
       let apply = UIButton()
        let selected = false
        apply.setTitle("Intermediate", for: .normal)
        apply.setTitleColor(.black, for: .normal)
        apply.titleLabel?.font = UIFont(name: "Galvji", size: 12)
        apply.backgroundColor = UIColor(red: 0.942, green: 0.657, blue: 0.451, alpha: 1)
        apply.layer.cornerRadius = 13.5
        apply.translatesAutoresizingMaskIntoConstraints = false
        apply.addTarget(self, action: #selector(ifSelect), for: .touchUpInside)
       return apply
   }()
    
    let expertButton: UIButton = {
       let apply = UIButton()
        let selected = false
        apply.setTitle("Expert", for: .normal)
        apply.setTitleColor(.black, for: .normal)
        apply.titleLabel?.font = UIFont(name: "Galvji", size: 12)
        apply.backgroundColor = UIColor(red: 0.942, green: 0.657, blue: 0.451, alpha: 1)
        apply.layer.cornerRadius = 13.5
        apply.translatesAutoresizingMaskIntoConstraints = false
        apply.addTarget(self, action: #selector(ifSelect), for: .touchUpInside)
       return apply
   }()
    let tenButton: UIButton = {
       let apply = UIButton()
        let selected = false
        apply.setTitle("<10 min", for: .normal)
        apply.setTitleColor(.black, for: .normal)
        apply.titleLabel?.font = UIFont(name: "Galvji", size: 12)
        apply.backgroundColor = UIColor(red: 0.942, green: 0.657, blue: 0.451, alpha: 1)
        apply.layer.cornerRadius = 13.5
        apply.translatesAutoresizingMaskIntoConstraints = false
        apply.addTarget(self, action: #selector(ifSelect), for: .touchUpInside)
       return apply
   }()
    
    let twentyButton: UIButton = {
       let apply = UIButton()
        let selected = false
        apply.setTitle("10-20 min", for: .normal)
        apply.setTitleColor(.black, for: .normal)
        apply.titleLabel?.font = UIFont(name: "Galvji", size: 12)
        apply.backgroundColor = UIColor(red: 0.942, green: 0.657, blue: 0.451, alpha: 1)
        apply.layer.cornerRadius = 13.5
        apply.translatesAutoresizingMaskIntoConstraints = false
        apply.addTarget(self, action: #selector(ifSelect), for: .touchUpInside)
       return apply
   }()
    
    
    let plusButton: UIButton = {
       let apply = UIButton()
        let selected = false
        apply.setTitle("20+ min", for: .normal)
        apply.setTitleColor(.black, for: .normal)
        apply.titleLabel?.font = UIFont(name: "Galvji", size: 12)
        apply.backgroundColor = UIColor(red: 0.942, green: 0.657, blue: 0.451, alpha: 1)
        apply.layer.cornerRadius = 13.5
        apply.translatesAutoresizingMaskIntoConstraints = false
        apply.addTarget(self, action: #selector(ifSelect), for: .touchUpInside)
       return apply
   }()
    
    let breckfastButton: UIButton = {
       let apply = UIButton()
        let selected = false
        apply.setTitle("Breakfast", for: .normal)
        apply.setTitleColor(.black, for: .normal)
        apply.titleLabel?.font = UIFont(name: "Galvji", size: 12)
        apply.backgroundColor = UIColor(red: 0.942, green: 0.657, blue: 0.451, alpha: 1)
        apply.layer.cornerRadius = 13.5
        apply.translatesAutoresizingMaskIntoConstraints = false
        apply.addTarget(self, action: #selector(ifSelect), for: .touchUpInside)
       return apply
   }()
    
    let lunchButton: UIButton = {
       let apply = UIButton()
        let selected = false
        apply.setTitle("Lunch", for: .normal)
        apply.setTitleColor(.black, for: .normal)
        apply.titleLabel?.font = UIFont(name: "Galvji", size: 12)
        apply.backgroundColor = UIColor(red: 0.942, green: 0.657, blue: 0.451, alpha: 1)
        apply.layer.cornerRadius = 13.5
        apply.translatesAutoresizingMaskIntoConstraints = false
        apply.addTarget(self, action: #selector(ifSelect), for: .touchUpInside)
       return apply
   }()
    
    let dinnerButton: UIButton = {
       let apply = UIButton()
        let selected = false
        apply.setTitle("Dinner", for: .normal)
        apply.setTitleColor(.black, for: .normal)
        apply.titleLabel?.font = UIFont(name: "Galvji", size: 12)
        apply.backgroundColor = UIColor(red: 0.942, green: 0.657, blue: 0.451, alpha: 1)
        apply.layer.cornerRadius = 13.5
        apply.translatesAutoresizingMaskIntoConstraints = false
        apply.addTarget(self, action: #selector(ifSelect), for: .touchUpInside)
       return apply
   }()
    
    let americanButton: UIButton = {
       let apply = UIButton()
        let selected = false
        apply.setTitle("American", for: .normal)
        apply.setTitleColor(.black, for: .normal)
        apply.titleLabel?.font = UIFont(name: "Galvji", size: 12)
        apply.backgroundColor = UIColor(red: 0.942, green: 0.657, blue: 0.451, alpha: 1)
        apply.layer.cornerRadius = 13.5
        apply.translatesAutoresizingMaskIntoConstraints = false
        apply.addTarget(self, action: #selector(ifSelect), for: .touchUpInside)
       return apply
   }()
    
    let asianButton: UIButton = {
       let apply = UIButton()
        let selected = false
        apply.setTitle("Asian", for: .normal)
        apply.setTitleColor(.black, for: .normal)
        apply.titleLabel?.font = UIFont(name: "Galvji", size: 12)
        apply.backgroundColor = UIColor(red: 0.942, green: 0.657, blue: 0.451, alpha: 1)
        apply.layer.cornerRadius = 13.5
        apply.translatesAutoresizingMaskIntoConstraints = false
        apply.addTarget(self, action: #selector(ifSelect), for: .touchUpInside)
       return apply
   }()
    
    let latinButton: UIButton = {
       let apply = UIButton()
        let selected = false
        apply.setTitle("Latin", for: .normal)
        apply.setTitleColor(.black, for: .normal)
        apply.titleLabel?.font = UIFont(name: "Galvji", size: 12)
        apply.backgroundColor = UIColor(red: 0.942, green: 0.657, blue: 0.451, alpha: 1)
        apply.layer.cornerRadius = 13.5
        apply.translatesAutoresizingMaskIntoConstraints = false
        apply.addTarget(self, action: #selector(ifSelect), for: .touchUpInside)
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
    
    @objc func applyFilters (button: UIButton){
//        if selected {
        button.backgroundColor = UIColor(red: 0.692, green: 0.084, blue: 0.157, alpha: 1)
        self.removeFromSuperview()
//        }
//        else {
//            selected = false
//        }
    }
    @objc func ifSelect(button: UIButton){
//        let selected = true
        let red = UIColor(red: 0.692, green: 0.084, blue: 0.157, alpha: 1)
        let orange = UIColor(red: 0.942, green: 0.657, blue: 0.451, alpha: 1)
        if button.backgroundColor != red {
            button.backgroundColor = red
            selected = true
        } else {
            button.backgroundColor = orange
            selected = false
        }
    }
    
    @objc func dismissView(){
        self.removeFromSuperview()
//        dismiss(animated: true, completion: nil)
    }
    
    let container: UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.backgroundColor = UIColor(red: 1, green: 0.947, blue: 0.867, alpha: 1)
        v.layer.cornerRadius = 24
        return v
    }()
    
     lazy var stack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [titleLabel, difficultLabel])
        
        
        return stack
    }()
    
   
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
//        self.backgroundColor = .darkGray
        self.frame = UIScreen.main.bounds
        
        self.addSubview(container)
        self.addSubview(titleLabel)
        self.addSubview(difficultLabel)
        self.addSubview(mealLabel)
        self.addSubview(timeLabel)
        self.addSubview(cuisineLabel)
        self.addSubview(applyButton)
        //buttons
        self.addSubview(begginerButton)
        self.addSubview(interButton)
        self.addSubview(expertButton)
        self.addSubview(tenButton)
        self.addSubview(twentyButton)
        self.addSubview(plusButton)
        self.addSubview(breckfastButton)
        self.addSubview(lunchButton)
        self.addSubview(dinnerButton)
        self.addSubview(americanButton)
        self.addSubview(asianButton)
        self.addSubview(latinButton)
        self.addSubview(exitButton)
        
//        begginerButton.titleLabel?.font = UIFont(name: "Galvji", size: 12)
        
        container.widthAnchor.constraint(equalToConstant: 300).isActive = true
        container.heightAnchor.constraint(equalToConstant: 385).isActive = true
        container.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 38).isActive = true
        container.topAnchor.constraint(equalTo: self.topAnchor, constant: 258).isActive = true
        
        titleLabel.widthAnchor.constraint(equalToConstant: 66).isActive = true

        titleLabel.heightAnchor.constraint(equalToConstant: 26).isActive = true

        titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 158).isActive = true

        titleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 267).isActive = true
        
        difficultLabel.widthAnchor.constraint(equalToConstant: 77).isActive = true

        difficultLabel.heightAnchor.constraint(equalToConstant: 25).isActive = true

        difficultLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 52).isActive = true

        difficultLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 320).isActive = true
        
        timeLabel.widthAnchor.constraint(equalToConstant: 77).isActive = true

        timeLabel.heightAnchor.constraint(equalToConstant: 25).isActive = true

        timeLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 52).isActive = true

        timeLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 391).isActive = true
        
        mealLabel.widthAnchor.constraint(equalToConstant: 77).isActive = true

        mealLabel.heightAnchor.constraint(equalToConstant: 25).isActive = true

        mealLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 52).isActive = true

        mealLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 457).isActive = true
        
        cuisineLabel.widthAnchor.constraint(equalToConstant: 60).isActive = true

        cuisineLabel.heightAnchor.constraint(equalToConstant: 25).isActive = true

        cuisineLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 52).isActive = true

        cuisineLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 515).isActive = true
        
        applyButton.widthAnchor.constraint(equalToConstant: 121).isActive = true

        applyButton.heightAnchor.constraint(equalToConstant: 36).isActive = true

        applyButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 130).isActive = true

        applyButton.topAnchor.constraint(equalTo: self.topAnchor, constant: 597).isActive = true
        
        
        begginerButton.widthAnchor.constraint(equalToConstant: 81).isActive = true

        begginerButton.heightAnchor.constraint(equalToConstant: 22).isActive = true

        begginerButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 59).isActive = true

        begginerButton.topAnchor.constraint(equalTo: self.topAnchor, constant: 348).isActive = true
        
        interButton.widthAnchor.constraint(equalToConstant: 83.89).isActive = true

        interButton.heightAnchor.constraint(equalToConstant: 22).isActive = true

        interButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 153).isActive = true

        interButton.topAnchor.constraint(equalTo: self.topAnchor, constant: 348).isActive = true
        
        expertButton.widthAnchor.constraint(equalToConstant: 81).isActive = true

        expertButton.heightAnchor.constraint(equalToConstant: 22).isActive = true

        expertButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 246).isActive = true

        expertButton.topAnchor.constraint(equalTo: self.topAnchor, constant: 348).isActive = true
        
        tenButton.widthAnchor.constraint(equalToConstant: 81).isActive = true

        tenButton.heightAnchor.constraint(equalToConstant: 22).isActive = true

        tenButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 60).isActive = true

        tenButton.topAnchor.constraint(equalTo: self.topAnchor, constant: 419).isActive = true
        
        twentyButton.widthAnchor.constraint(equalToConstant: 81).isActive = true

        twentyButton.heightAnchor.constraint(equalToConstant: 22).isActive = true

        twentyButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 154).isActive = true

        twentyButton.topAnchor.constraint(equalTo: self.topAnchor, constant: 419).isActive = true
        
        plusButton.widthAnchor.constraint(equalToConstant: 81).isActive = true

        plusButton.heightAnchor.constraint(equalToConstant: 22).isActive = true

        plusButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 246).isActive = true

        plusButton.topAnchor.constraint(equalTo: self.topAnchor, constant: 419).isActive = true
        
        breckfastButton.widthAnchor.constraint(equalToConstant: 81).isActive = true

        breckfastButton.heightAnchor.constraint(equalToConstant: 22).isActive = true

        breckfastButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 60).isActive = true

        breckfastButton.topAnchor.constraint(equalTo: self.topAnchor, constant: 485).isActive = true
        
        lunchButton.widthAnchor.constraint(equalToConstant: 81).isActive = true

        lunchButton.heightAnchor.constraint(equalToConstant: 22).isActive = true

        lunchButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 154).isActive = true

        lunchButton.topAnchor.constraint(equalTo: self.topAnchor, constant: 485).isActive = true
        
        dinnerButton.widthAnchor.constraint(equalToConstant: 81).isActive = true

        dinnerButton.heightAnchor.constraint(equalToConstant: 22).isActive = true

        dinnerButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 246).isActive = true

        dinnerButton.topAnchor.constraint(equalTo: self.topAnchor, constant: 485).isActive = true
        
        americanButton.widthAnchor.constraint(equalToConstant: 81).isActive = true

        americanButton.heightAnchor.constraint(equalToConstant: 22).isActive = true

        americanButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 60).isActive = true

        americanButton.topAnchor.constraint(equalTo: self.topAnchor, constant: 543).isActive = true
        
        asianButton.widthAnchor.constraint(equalToConstant: 81).isActive = true

        asianButton.heightAnchor.constraint(equalToConstant: 22).isActive = true

        asianButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 154).isActive = true

        asianButton.topAnchor.constraint(equalTo: self.topAnchor, constant: 543).isActive = true
        
        latinButton.widthAnchor.constraint(equalToConstant: 81).isActive = true

        latinButton.heightAnchor.constraint(equalToConstant: 22).isActive = true

        latinButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 246).isActive = true
        latinButton.topAnchor.constraint(equalTo: self.topAnchor, constant: 543).isActive = true
        
        exitButton.widthAnchor.constraint(equalToConstant: 16.97).isActive = true
        exitButton.heightAnchor.constraint(equalToConstant: 16.97).isActive = true
        exitButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 307).isActive = true
        exitButton.topAnchor.constraint(equalTo: self.topAnchor, constant: 270).isActive = true
        
    }
    required init?(coder: NSCoder) {
        fatalError("no")
    }
}
