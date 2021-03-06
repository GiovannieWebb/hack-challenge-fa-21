//
//  ViewController.swift
//  CornellCookbook
//
//  Created by Kayla Sprayberry on 11/18/21.
//

import UIKit

protocol updateRecipeDelegate: class {
//    func getRecipeList(allRecipies: [Recipie])
//    func updateIngredients(newIngredients: [Ingredients])
//    func updateInstructions(newInstructions: [Instructions])
//    func updateInstructions(newString: String)
    func updateName(newString: String)
}

protocol updateInstructionDelegate: class {
    func updateInstructions(newInstructions: [Instructions])
}

protocol updateIngredientsDelegate: class {
    func updateIngredients(newIngredients: [Ingredients])
}

var hasUserID = false

class ViewController: UIViewController {
    
    
    private let button: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "bored"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let button1: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "bored"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let button2: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "bored"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let loginButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "bored"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let firstImage : UIImageView = {
        let firstImage = UIImageView(image: UIImage(named: "screen1"))
        firstImage.sizeToFit()
        firstImage.translatesAutoresizingMaskIntoConstraints = false
        return firstImage
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor(red: 1, green: 0.947, blue: 0.867, alpha: 1)

        navigationController?.isNavigationBarHidden = true
        //button
        button.addTarget(self, action: #selector(didTapButton12), for: .touchUpInside)
        button1.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
        button2.addTarget(self, action: #selector(didTapButton1), for: .touchUpInside)
        loginButton.addTarget(self, action: #selector(didTapButton2), for: .touchUpInside)
        
        
        
        view.addSubview(button)
        view.addSubview(button1)
        view.addSubview(button2)
        view.addSubview(loginButton)
        
        onboarding()
        setUpConstraints()
    }
    
    func onboarding(){
        if hasUserID {
            view.addSubview(firstImage)
//            setUpConstraints()
        } else {
            view.addSubview(firstImage)
//            setUpConstraints()
        }
    }
    
    func setUpConstraints (){
        NSLayoutConstraint.activate([
            firstImage.topAnchor.constraint(equalTo: view.topAnchor),
            firstImage.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            firstImage.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            firstImage.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        
        NSLayoutConstraint.activate([
            button.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 88),
            button.widthAnchor.constraint(equalToConstant: 25),
            button.heightAnchor.constraint(equalToConstant: 25),
            button.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -62)
        ])
        
        NSLayoutConstraint.activate([
            button1.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 175),
            button1.widthAnchor.constraint(equalToConstant: 25),
            button1.heightAnchor.constraint(equalToConstant: 25),
            button1.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -62)
        ])
        NSLayoutConstraint.activate([
            button2.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 263),
            button2.widthAnchor.constraint(equalToConstant: 25),
            button2.heightAnchor.constraint(equalToConstant: 25),
            button2.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -62)
        ])
        NSLayoutConstraint.activate([
            loginButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 68),
            loginButton.widthAnchor.constraint(equalToConstant: 240),
            loginButton.heightAnchor.constraint(equalToConstant: 63),
            loginButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -191)
        ])
    }
    
    @objc func didTapButton12() {
        firstImage.image = UIImage(named: "screen1")
    }
    @objc func didTapButton() {
        firstImage.image = UIImage(named: "screen2")
    }
    @objc func didTapButton1() {
        firstImage.image = UIImage(named: "screen3")
//        button.setImage(UIImage(named: "board1"), for: .normal)
    }
    @objc func didTapButton2() {
        let vc3 = SearchViewController()
        let navVC = UINavigationController(rootViewController: vc3)
        navVC.modalPresentationStyle = .fullScreen
        present(navVC, animated: true)
    }

}

//MARK: Profile Controller
class ProfileViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate
{

    let titleLabel = UILabel()
    let yourRecipes = UIButton()
    let savedRecipes = UIButton()
    let newRecipeButton = UIButton()
    let filter = UIButton()
    
    var featureCollectionView : UICollectionView!
    let recipieCellReuseIdentifier = "recipieCellReuseIdentifier"
    
    var featureSection = ["Featured"]
    var featureRecipes : [[Recipie]] =
        [[Recipie(userId: 12, name: "Simone", time: 4, difficulty: "Begginer", mealType: "Lunch", cuisine: "Latin", ingredients: [Ingredients(id: 1, name: "eggs", amount: 3, unit: "Slices"), Ingredients(id: 1, name: "trouble", amount: 5, unit: "two")], instructions: [Instructions(id: 1, stepNumber: 1, step: "one"), Instructions(id: 1,stepNumber: 2, step: "two")], comments: [Comments(id: 12, userId: 12, text: "12")], numberOfLikes: 12, usersLiked: [User(id: 7, username: "one", email: "one", postedRecipes: [], likedRecipes: [], postedComments: ["one"])], usersCommented: [User(id: 2, username: "strg", email: "mail", postedRecipes: [], likedRecipes: [], postedComments: [])], createdAt: 2), Recipie(userId: 12, name: "Simone", time: 4, difficulty: "Begginer", mealType: "Lunch", cuisine: "Latin", ingredients: [Ingredients(id: 1,name: "eggs", amount: 3, unit: "Slices"), Ingredients(id: 1,name: "trouble", amount: 5, unit: "two")], instructions: [Instructions(id: 1,stepNumber: 1, step: "one"), Instructions(id: 1,stepNumber: 2, step: "two")], comments: [Comments(id: 12, userId: 12, text: "12")], numberOfLikes: 12, usersLiked: [User(id: 7, username: "one", email: "one", postedRecipes: [], likedRecipes: [], postedComments: ["one"])], usersCommented: [User(id: 2, username: "strg", email: "mail", postedRecipes: [], likedRecipes: [], postedComments: [])], createdAt: 2), Recipie(userId: 12, name: "Simone", time: 4, difficulty: "Begginer", mealType: "Lunch", cuisine: "Latin", ingredients: [Ingredients(id: 1, name: "eggs", amount: 3, unit: "Slices"), Ingredients(id: 1,name: "trouble", amount: 5, unit: "two")], instructions: [Instructions(id: 1,stepNumber: 1, step: "one"), Instructions(id: 1,stepNumber: 2, step: "two")], comments: [Comments(id: 12, userId: 12, text: "12")], numberOfLikes: 12, usersLiked: [User(id: 7, username: "one", email: "one", postedRecipes: [], likedRecipes: [], postedComments: ["one"])], usersCommented: [User(id: 2, username: "strg", email: "mail", postedRecipes: [], likedRecipes: [], postedComments: [])], createdAt: 2), Recipie(userId: 12, name: "Simone", time: 4, difficulty: "Begginer", mealType: "Lunch", cuisine: "Latin", ingredients: [Ingredients(id: 1,name: "eggs", amount: 3, unit: "Slices"), Ingredients(id: 1, name: "trouble", amount: 5, unit: "two")], instructions: [Instructions(id: 1,stepNumber: 1, step: "one"), Instructions(id: 1,stepNumber: 2, step: "two")], comments: [Comments(id: 12, userId: 12, text: "12")], numberOfLikes: 12, usersLiked: [User(id: 7, username: "one", email: "one", postedRecipes: [], likedRecipes: [], postedComments: ["one"])], usersCommented: [User(id: 2, username: "strg", email: "mail", postedRecipes: [], likedRecipes: [], postedComments: [])], createdAt: 2)], [Recipie(userId: 12, name: "Simone", time: 4, difficulty: "Begginer", mealType: "Lunch", cuisine: "Latin", ingredients: [Ingredients(id: 1,name: "eggs", amount: 3, unit: "Slices"), Ingredients(id: 1,name: "trouble", amount: 5, unit: "two")], instructions: [Instructions(id: 1,stepNumber: 1, step: "one"), Instructions(id: 1,stepNumber: 2, step: "two")], comments: [Comments(id: 12, userId: 12, text: "12")], numberOfLikes: 12, usersLiked: [User(id: 7, username: "one", email: "one", postedRecipes: [], likedRecipes: [], postedComments: ["one"])], usersCommented: [User(id: 2, username: "strg", email: "mail", postedRecipes: [], likedRecipes: [], postedComments: [])], createdAt: 2), Recipie(userId: 12, name: "Simone", time: 4, difficulty: "Begginer", mealType: "Lunch", cuisine: "Latin", ingredients: [Ingredients(id: 1,name: "eggs", amount: 3, unit: "Slices"), Ingredients(id: 1,name: "trouble", amount: 5, unit: "two")], instructions: [Instructions(id: 1,stepNumber: 1, step: "one"), Instructions(id: 1,stepNumber: 2, step: "two")], comments: [Comments(id: 12, userId: 12, text: "12")], numberOfLikes: 12, usersLiked: [User(id: 7, username: "one", email: "one", postedRecipes: [], likedRecipes: [], postedComments: ["one"])], usersCommented: [User(id: 2, username: "strg", email: "mail", postedRecipes: [], likedRecipes: [], postedComments: [])], createdAt: 2), Recipie(userId: 12, name: "Simone", time: 4, difficulty: "Begginer", mealType: "Lunch", cuisine: "Latin", ingredients: [Ingredients(id: 1,name: "eggs", amount: 3, unit: "Slices"), Ingredients(id: 1,name: "trouble", amount: 5, unit: "two")], instructions: [Instructions(id: 1,stepNumber: 1, step: "one"), Instructions(id: 1,stepNumber: 2, step: "two")], comments: [Comments(id: 12, userId: 12, text: "12")], numberOfLikes: 12, usersLiked: [User(id: 7, username: "one", email: "one", postedRecipes: [], likedRecipes: [], postedComments: ["one"])], usersCommented: [User(id: 2, username: "strg", email: "mail", postedRecipes: [], likedRecipes: [], postedComments: [])], createdAt: 2)]]

    let cellPadding: CGFloat = 10
    let sectionPadding: CGFloat = 5
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
//        title = "Karen's Cookbook"
        titleLabel.text = "Karen's Cookbook"
        titleLabel.font = UIFont(name: "Galvji-Bold", size: 30)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        
        yourRecipes.setTitle("Your Recipes", for: .normal)
        yourRecipes.layer.cornerRadius = 22.5
        yourRecipes.backgroundColor = UIColor(red: 1, green: 0.947, blue: 0.867, alpha: 1)
        yourRecipes.isSelected = true
        yourRecipes.setTitleColor(UIColor(red: 0.692, green: 0.084, blue: 0.157, alpha: 1), for: .normal)
        yourRecipes.layer.borderWidth = 2
        yourRecipes.titleLabel?.font = UIFont(name: "Galvji", size: 14.4)
        yourRecipes.layer.borderColor = UIColor(red: 0.692, green: 0.084, blue: 0.157, alpha: 1).cgColor
        yourRecipes.translatesAutoresizingMaskIntoConstraints = false
        yourRecipes.addTarget(self, action: #selector(showYour), for: .touchUpInside)
        
        savedRecipes.setTitle("Saved Recipes", for: .normal)
        savedRecipes.layer.cornerRadius = 22.5
        savedRecipes.setTitleColor(.black, for: .normal)
        savedRecipes.titleLabel?.font = UIFont(name: "Galvji", size: 14.4)
        savedRecipes.backgroundColor = UIColor(red: 1, green: 0.947, blue: 0.867, alpha: 1)
        
        savedRecipes.isSelected = false
        savedRecipes.translatesAutoresizingMaskIntoConstraints = false
        savedRecipes.addTarget(self, action: #selector(showSaved), for: .touchUpInside)
        
        filter.setTitle("Filter", for: .normal)
        filter.setTitleColor(.black, for: .normal)
        filter.translatesAutoresizingMaskIntoConstraints = false
        filter.addTarget(self, action: #selector(showFilters), for: .touchUpInside)
        
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = cellPadding
        layout.minimumInteritemSpacing = cellPadding
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: 160, height: 200)
        
        featureCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        featureCollectionView.translatesAutoresizingMaskIntoConstraints = false
        featureCollectionView.backgroundColor = .clear
        featureCollectionView.register(RecipeCollectionViewCell.self, forCellWithReuseIdentifier: recipieCellReuseIdentifier)
        featureCollectionView.dataSource = self
        featureCollectionView.delegate = self

        if let image = UIImage(named: "new") {
                newRecipeButton.setImage(image, for: .normal)
        }
        newRecipeButton.translatesAutoresizingMaskIntoConstraints = false
        newRecipeButton.addTarget(self, action: #selector(newRecipe), for: .touchUpInside)

        
        
        view.addSubview(filter)
        view.addSubview(titleLabel)
        view.addSubview(newRecipeButton)
        view.addSubview(featureCollectionView)
        view.addSubview(savedRecipes)
        view.addSubview(yourRecipes)
        setupConstraints()
    }
    
    @objc func showFilters() {
        let pop = FilterPopUp()
        view.addSubview(pop)
    }
    
    @objc func newRecipe() {
        let vc = NewViewController()
        vc.modalPresentationStyle = .fullScreen
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func showYour() {
        yourRecipes.setTitleColor(UIColor(red: 0.692, green: 0.084, blue: 0.157, alpha: 1), for: .normal)
        savedRecipes.setTitleColor(.black, for: .normal)
        yourRecipes.layer.borderWidth = 2
        savedRecipes.layer.borderWidth = 0
        yourRecipes.layer.borderColor = UIColor(red: 0.692, green: 0.084, blue: 0.157, alpha: 1).cgColor
//        let pop = FilterPopUp()
//
//        let vc = YourViewController()
//        present(vc, animated: true)
//
//        view.addSubview(pop)
    }
    
    @objc func showSaved() {
        savedRecipes.setTitleColor(UIColor(red: 0.692, green: 0.084, blue: 0.157, alpha: 1), for: .normal)
        yourRecipes.setTitleColor(.black, for: .normal)
        savedRecipes.layer.borderWidth = 2
        savedRecipes.layer.borderColor = UIColor(red: 0.692, green: 0.084, blue: 0.157, alpha: 1).cgColor
        yourRecipes.layer.borderWidth = 0
        
//        let vc = HomeViewController()
//        present(vc, animated: true)
//
//        let pop = FilterPopUp()
//        view.addSubview(pop)
    }
    
    func setupConstraints() {
        
        NSLayoutConstraint.activate([
            titleLabel.widthAnchor.constraint(equalToConstant: 400),
            titleLabel.heightAnchor.constraint(equalToConstant: 40),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 7),
            titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 84)
        ])
        NSLayoutConstraint.activate([
            filter.widthAnchor.constraint(equalToConstant: 40),

            filter.heightAnchor.constraint(equalToConstant: 23),
            filter.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 320),

            filter.topAnchor.constraint(equalTo: view.topAnchor, constant: 93)
        ])
        
        NSLayoutConstraint.activate([
            savedRecipes.widthAnchor.constraint(equalToConstant: 119.53),
            savedRecipes.heightAnchor.constraint(equalToConstant: 33),
            savedRecipes.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 193),
            savedRecipes.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 7)
        ])
        
        NSLayoutConstraint.activate([
            yourRecipes.widthAnchor.constraint(equalToConstant: 108),
            yourRecipes.heightAnchor.constraint(equalToConstant: 33),
            yourRecipes.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 57),
            yourRecipes.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 7)
        ])
        NSLayoutConstraint.activate([
//  featureCollectionView.widthAnchor.constraint(equalToConstant: 108),
            featureCollectionView.bottomAnchor.constraint(equalTo: view.topAnchor, constant: 730),
//  featureCollectionView.heightAnchor.constraint(equalToConstant: 33),
            featureCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            featureCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            featureCollectionView.topAnchor.constraint(equalTo: yourRecipes.bottomAnchor, constant: 7)
        ])
        
        NSLayoutConstraint.activate([
            newRecipeButton.widthAnchor.constraint(equalToConstant: 85),
            newRecipeButton.heightAnchor.constraint(equalToConstant: 85),
            newRecipeButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 145),
            newRecipeButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 730)
        ])
        
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
//        return featureRecipes[0].count
        return featureSection.count
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return featureSection.count
        return featureRecipes[section].count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: recipieCellReuseIdentifier, for: indexPath) as! RecipeCollectionViewCell
        let recipie = featureRecipes[indexPath.section][indexPath.item]
        cell.configure(for: recipie)
        return cell
    }
}

class resultsController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 1, green: 0.947, blue: 0.867, alpha: 1)
    }
}

//MARK: Home page Controller
class SearchViewController: UIViewController,  UISearchBarDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate, updateRecipeDelegate, updateInstructionDelegate, updateIngredientsDelegate  {
    func updateName(newString: String) {
        featureRecipes[0][0].name = newString
    }
    
    
    func getRecipeList(allRecipies: [Recipie]) {
        var recipe: [Recipie] = []
        for recipes in featureRecipes {
            for reci in recipes {
                recipe.append(reci)
            }
        }
        recipe = allRecipies
    }
    
    func updateIngredients(newIngredients: [Ingredients]) {
        var ingredients: [Ingredients] = []
        for recipes in featureRecipes {
            for recipe in recipes {
                for ingredients1 in recipe.ingredients {
                    ingredients.append(ingredients1)
                    }
                }
            }
        ingredients = newIngredients
        }
    
    
    func updateInstructions(newInstructions: [Instructions]) {
        var instructions: [Instructions] = []
        for recipes in featureRecipes {
            for recipe in recipes {
                for instructions1 in recipe.instructions {
                    instructions.append(instructions1)
                    }
                }
            }
        instructions = newInstructions
        }

    let searchControl = UISearchBar()
    let titleLabel = UILabel()
    let filter = UIButton()
    let profile = UIButton()
    let logo = UIImageView()
    

//    var recipeData: [Recipie] = []
//    var instructionData: [Instructions]
//    var ingredientsData: [Ingredients]
    
    let popularLabel = UILabel()
    let featureLabel = UILabel()
//    var popularRecipes : [[Recipie]] = []
//    var recentlyRecipes : [[Recipie]] = []
    let recentlyLabel = UILabel()
    
    var featureCollectionView : UICollectionView!
    var feature2CollectionView : UICollectionView!
    var feature3CollectionView : UICollectionView!
    
    var featureSection = ["Featured"]
    
    var featureRecipe : [Recipie] = [Recipie(userId: 12, name: "Simone", time: 4, difficulty: "Begginer", mealType: "Lunch", cuisine: "Latin", ingredients: [Ingredients(id: 1, name: "eggs", amount: 3, unit: "Slices"), Ingredients(id: 1, name: "trouble", amount: 5, unit: "two")], instructions: [Instructions(id: 1, stepNumber: 1, step: "one"), Instructions(id: 1,stepNumber: 2, step: "two")], comments: [Comments(id: 12, userId: 12, text: "12")], numberOfLikes: 12, usersLiked: [User(id: 7, username: "one", email: "one", postedRecipes: [], likedRecipes: [], postedComments: ["one"])], usersCommented: [User(id: 2, username: "strg", email: "mail", postedRecipes: [], likedRecipes: [], postedComments: [])], createdAt: 2)]
    
    var featureRecipes : [[Recipie]] =
        [[Recipie(userId: 12, name: "Cereal", time: 4, difficulty: "Begginer", mealType: "Breakfast", cuisine: "American", ingredients: [Ingredients(id: 1, name: "Fruit Loops Cereal", amount: 3, unit: "Cups"), Ingredients(id: 1, name: "Almond Milk", amount: 5, unit: "Spoons")], instructions: [Instructions(id: 1, stepNumber: 1, step: "add milk to bowl"), Instructions(id: 1,stepNumber: 2, step: "add cereal to milk")], comments: [Comments(id: 12, userId: 12, text: "12")], numberOfLikes: 12, usersLiked: [User(id: 7, username: "one", email: "one", postedRecipes: [], likedRecipes: [], postedComments: ["one"])], usersCommented: [User(id: 2, username: "strg", email: "mail", postedRecipes: [], likedRecipes: [], postedComments: [])], createdAt: 2), Recipie(userId: 12, name: "Spagetti", time: 4, difficulty: "Begginer", mealType: "Lunch", cuisine: "Latin", ingredients: [Ingredients(id: 1,name: "eggs", amount: 3, unit: "Slices"), Ingredients(id: 1,name: "eggs", amount: 5, unit: "two")], instructions: [Instructions(id: 1,stepNumber: 1, step: "one"), Instructions(id: 1,stepNumber: 2, step: "two")], comments: [Comments(id: 12, userId: 12, text: "12")], numberOfLikes: 12, usersLiked: [User(id: 7, username: "one", email: "one", postedRecipes: [], likedRecipes: [], postedComments: ["one"])], usersCommented: [User(id: 2, username: "strg", email: "mail", postedRecipes: [], likedRecipes: [], postedComments: [])], createdAt: 2), Recipie(userId: 12, name: "Chicken Tenders", time: 4, difficulty: "Begginer", mealType: "Dinner", cuisine: "American", ingredients: [Ingredients(id: 1, name: "eggs", amount: 3, unit: "Slices"), Ingredients(id: 1,name: "trouble", amount: 5, unit: "two")], instructions: [Instructions(id: 1,stepNumber: 1, step: "one"), Instructions(id: 1,stepNumber: 2, step: "two")], comments: [Comments(id: 12, userId: 12, text: "12")], numberOfLikes: 12, usersLiked: [User(id: 7, username: "one", email: "one", postedRecipes: [], likedRecipes: [], postedComments: ["one"])], usersCommented: [User(id: 2, username: "strg", email: "mail", postedRecipes: [], likedRecipes: [], postedComments: [])], createdAt: 2), Recipie(userId: 12, name: "Butter Chicken", time: 4, difficulty: "Begginer", mealType: "Lunch", cuisine: "American", ingredients: [Ingredients(id: 1,name: "eggs", amount: 3, unit: "Slices"), Ingredients(id: 1, name: "trouble", amount: 5, unit: "two")], instructions: [Instructions(id: 1,stepNumber: 1, step: "one"), Instructions(id: 1,stepNumber: 2, step: "two")], comments: [Comments(id: 12, userId: 12, text: "12")], numberOfLikes: 12, usersLiked: [User(id: 7, username: "one", email: "one", postedRecipes: [], likedRecipes: [], postedComments: ["one"])], usersCommented: [User(id: 2, username: "strg", email: "mail", postedRecipes: [], likedRecipes: [], postedComments: [])], createdAt: 2)], [Recipie(userId: 12, name: "Rice & Beans", time: 4, difficulty: "Advanved", mealType: "Lunch", cuisine: "Latin", ingredients: [Ingredients(id: 1,name: "eggs", amount: 3, unit: "Slices"), Ingredients(id: 1,name: "trouble", amount: 5, unit: "two")], instructions: [Instructions(id: 1,stepNumber: 1, step: "one"), Instructions(id: 1,stepNumber: 2, step: "two")], comments: [Comments(id: 12, userId: 12, text: "12")], numberOfLikes: 12, usersLiked: [User(id: 7, username: "one", email: "one", postedRecipes: [], likedRecipes: [], postedComments: ["one"])], usersCommented: [User(id: 2, username: "strg", email: "mail", postedRecipes: [], likedRecipes: [], postedComments: [])], createdAt: 2), Recipie(userId: 12, name: "Simone", time: 4, difficulty: "Begginer", mealType: "Lunch", cuisine: "Latin", ingredients: [Ingredients(id: 1,name: "eggs", amount: 3, unit: "Slices"), Ingredients(id: 1,name: "trouble", amount: 5, unit: "two")], instructions: [Instructions(id: 1,stepNumber: 1, step: "one"), Instructions(id: 1,stepNumber: 2, step: "two")], comments: [Comments(id: 12, userId: 12, text: "12")], numberOfLikes: 12, usersLiked: [User(id: 7, username: "one", email: "one", postedRecipes: [], likedRecipes: [], postedComments: ["one"])], usersCommented: [User(id: 2, username: "strg", email: "mail", postedRecipes: [], likedRecipes: [], postedComments: [])], createdAt: 2), Recipie(userId: 12, name: "Salad", time: 4, difficulty: "Begginer", mealType: "Lunch", cuisine: "Latin", ingredients: [Ingredients(id: 1,name: "eggs", amount: 3, unit: "Slices"), Ingredients(id: 1,name: "trouble", amount: 5, unit: "two")], instructions: [Instructions(id: 1,stepNumber: 1, step: "one"), Instructions(id: 1,stepNumber: 2, step: "two")], comments: [Comments(id: 12, userId: 12, text: "12")], numberOfLikes: 12, usersLiked: [User(id: 7, username: "one", email: "one", postedRecipes: [], likedRecipes: [], postedComments: ["one"])], usersCommented: [User(id: 2, username: "strg", email: "mail", postedRecipes: [], likedRecipes: [], postedComments: [])], createdAt: 2)]]
    let recipieCellReuseIdentifier = "recipieCellReuseIdentifier"
    let cellPadding: CGFloat = 10
    let sectionPadding: CGFloat = 5
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        //MARK: UNCOMMENT LATER Only when there is data in the network
//        getData()
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        
        searchControl.searchBarStyle = UISearchBar.Style.default
        searchControl.placeholder = " Search..."

        searchControl.keyboardType = .default
        searchControl.isTranslucent = true
        searchControl.backgroundImage = UIImage()
        searchControl.delegate = self
//        searchControl.sele
        searchControl.translatesAutoresizingMaskIntoConstraints = false
        
        titleLabel.text = "Discover"
        titleLabel.font = UIFont(name: "Galvji-Bold", size: 30)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        popularLabel.text = "Popular"
        popularLabel.font = UIFont(name: "Galvji", size: 20)
        popularLabel.translatesAutoresizingMaskIntoConstraints = false
        
        featureLabel.text = "Featured"
        featureLabel.font = UIFont(name: "Galvji", size: 20)
        featureLabel.translatesAutoresizingMaskIntoConstraints = false

        recentlyLabel.text = "Recently Added"
        recentlyLabel.font = UIFont(name: "Galvji", size: 20)
        recentlyLabel.translatesAutoresizingMaskIntoConstraints = false
        
        logo.image = UIImage(named: "logo")
        logo.translatesAutoresizingMaskIntoConstraints = false
        
        filter.setTitle("Filter", for: .normal)
        filter.setTitleColor(.black, for: .normal)
        filter.translatesAutoresizingMaskIntoConstraints = false
        filter.addTarget(self, action: #selector(showFilters), for: .touchUpInside)
        
        profile.setImage(UIImage(named: "profile"), for: .normal)
        profile.translatesAutoresizingMaskIntoConstraints = false
        profile.addTarget(self, action: #selector(showProfile), for: .touchUpInside)
        
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = cellPadding
        layout.minimumInteritemSpacing = cellPadding
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 115, height: 115)
        
        featureCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        featureCollectionView.translatesAutoresizingMaskIntoConstraints = false
        featureCollectionView.backgroundColor = .clear
        featureCollectionView.register(RowCollectionViewCell.self, forCellWithReuseIdentifier: recipieCellReuseIdentifier)
        featureCollectionView.dataSource = self
        featureCollectionView.delegate = self
        
        feature2CollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        feature2CollectionView.translatesAutoresizingMaskIntoConstraints = false
        feature2CollectionView.backgroundColor = .clear
        feature2CollectionView.register(RowCollectionViewCell.self, forCellWithReuseIdentifier: recipieCellReuseIdentifier)
        feature2CollectionView.dataSource = self
        feature2CollectionView.delegate = self
        
        feature3CollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        feature3CollectionView.translatesAutoresizingMaskIntoConstraints = false
        feature3CollectionView.backgroundColor = .clear
        feature3CollectionView.register(RowCollectionViewCell.self, forCellWithReuseIdentifier: recipieCellReuseIdentifier)
        feature3CollectionView.dataSource = self
        feature3CollectionView.delegate = self
        
        view.addSubview(featureCollectionView)
        view.addSubview(feature2CollectionView)
        view.addSubview(feature3CollectionView)
        view.addSubview(searchControl)
        view.addSubview(titleLabel)
        view.addSubview(filter)
        view.addSubview(logo)
        view.addSubview(profile)
        
        view.addSubview(popularLabel)
        view.addSubview(featureLabel)
        view.addSubview(recentlyLabel)
        setupConstraints()
        
    }
    
    func getData() {
        NetworkManager.getAllRecipes{
            recipes in self.featureRecipes =
                [recipes]
//             [featureRecipe.append(recipes)]
//            print(recipes)
            DispatchQueue.main.async {
                self.featureCollectionView.reloadData()
            }
        }
    }
    
    @objc func showFilters() {
        let pop = FilterPopUp()
        view.addSubview(pop)
    }
    
    @objc func showProfile() {
        let rootVC = ProfileViewController()
//        rootVC.title = "Profile Name "
//        let navVC = UINavigationController(rootViewController: rootVC)
//        navVC.modalPresentationStyle = .fullScreen
//        present(navVC, animated: true)
        navigationController?.pushViewController(rootVC, animated: true)
    }
    
    func setupConstraints() {
        
        NSLayoutConstraint.activate([
            titleLabel.widthAnchor.constraint(equalToConstant: 134),
            titleLabel.heightAnchor.constraint(equalToConstant: 40),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 7),
            titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 84)
        ])
        
        NSLayoutConstraint.activate([
            filter.widthAnchor.constraint(equalToConstant: 40),
            filter.heightAnchor.constraint(equalToConstant: 23),
            filter.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 296),
            filter.topAnchor.constraint(equalTo: view.topAnchor, constant: 93)
        ])
        
        NSLayoutConstraint.activate([
            profile.widthAnchor.constraint(equalToConstant: 40),
            profile.heightAnchor.constraint(equalToConstant: 23),
            profile.leadingAnchor.constraint(equalTo: filter.trailingAnchor, constant: 5),
            profile.centerYAnchor.constraint(equalTo: filter.centerYAnchor)
        ])
        
        NSLayoutConstraint.activate([
            popularLabel.widthAnchor.constraint(equalToConstant: 101),
            popularLabel.heightAnchor.constraint(equalToConstant: 45),
            popularLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 13),
            popularLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 164)
        ])
        
        NSLayoutConstraint.activate([
            featureLabel.widthAnchor.constraint(equalToConstant: 160),
            featureLabel.heightAnchor.constraint(equalToConstant: 29),
            featureLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 9),
            featureLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 409)
        ])
        
        NSLayoutConstraint.activate([
            recentlyLabel.widthAnchor.constraint(equalToConstant: 160),
            recentlyLabel.heightAnchor.constraint(equalToConstant: 29),
            recentlyLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 7),
            recentlyLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 620)
        ])
        
        NSLayoutConstraint.activate([
//            searchControl.topAnchor.constraint(equalTo: titleLabel.bottomAnchor),
            searchControl.topAnchor.constraint(equalTo: view.topAnchor, constant: 125),
            searchControl.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 7),
//            searchControl.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -100),
            searchControl.heightAnchor.constraint(equalToConstant: 30),
            searchControl.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -7)
        ])
        
        NSLayoutConstraint.activate([
            logo.widthAnchor.constraint(equalToConstant: 100),
            logo.heightAnchor.constraint(equalToConstant: 63),
            logo.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 7),
            logo.topAnchor.constraint(equalTo: view.topAnchor, constant: 20)
        ])
        
        let collectionViewPadding: CGFloat = 12
        NSLayoutConstraint.activate([
            featureCollectionView.topAnchor.constraint(equalTo: popularLabel.bottomAnchor),
            featureCollectionView.bottomAnchor.constraint(equalTo: featureLabel.topAnchor),
            featureCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: collectionViewPadding),
            featureCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -collectionViewPadding)
        ])
        NSLayoutConstraint.activate([
            feature2CollectionView.topAnchor.constraint(equalTo: featureLabel.bottomAnchor),
            feature2CollectionView.bottomAnchor.constraint(equalTo: recentlyLabel.topAnchor),
            feature2CollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: collectionViewPadding),
            feature2CollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -collectionViewPadding)
        ])
        NSLayoutConstraint.activate([
            feature3CollectionView.topAnchor.constraint(equalTo: recentlyLabel.bottomAnchor),
            feature3CollectionView.heightAnchor.constraint(equalTo: feature2CollectionView.heightAnchor),
            feature3CollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: collectionViewPadding),
            feature3CollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -collectionViewPadding)
        ])
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
//        return featureRecipes[0].count
        return featureSection.count
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return featureSection.count
        return featureRecipes[section].count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: recipieCellReuseIdentifier, for: indexPath) as! RowCollectionViewCell
        let recipie = featureRecipes[indexPath.section][indexPath.item]
        cell.configure(for: recipie)
        return cell
    }
    
    func searchBarSearchButtonClicked(_searchBar: UISearchBar) {
        let vc = HomeViewController()
        present(vc, animated: true)
    }
    
    func searchBarTextDidBeginEditing(_searchBar: UISearchBar) {
        
    }
    
    func searchBarTextDidEndEditing(_searchBar: UISearchBar) {
        
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
    
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width / 2.5, height: collectionView.frame.height)
    }

//    present view controller
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        featureRecipes[indexPath.section][indexPath.item].isSelected.toggle()
        if featureRecipes[indexPath.section][indexPath.item].isSelected {
            let vc = PresentViewController(delegate: self, placeholderName: featureRecipes[indexPath.section][indexPath.item].name, placeholderIngredients: featureRecipes[indexPath.section][indexPath.item].ingredients, placeholderInstructions: featureRecipes[indexPath.section][indexPath.item].instructions, placeholderCuisine: featureRecipes[indexPath.section][indexPath.item].cuisine, placeholderMeal: featureRecipes[indexPath.section][indexPath.item].mealType, placeholderTime: featureRecipes[indexPath.section][indexPath.item].time, placeholderDifficulty: featureRecipes[indexPath.section][indexPath.item].difficulty)
            vc.modalPresentationStyle = .fullScreen
            navigationController?.present(vc, animated: true)
//            self.present(vc, animated: true, completion: nil)
        }
        collectionView.reloadData()
    }
    
}
//MARK: Deprecated Home Controller
class HomeViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate, updateRecipeDelegate  {
    func getRecipeList(allRecipies: [Recipie]) {
        var recipe: [Recipie] = []
        for recipes in recipies {
            for reci in recipes {
                recipe.append(reci)
            }
        }
        recipe = allRecipies
    }
    
    func updateIngredients(newIngredients: [Ingredients]) {
        recipies[0][0].ingredients = newIngredients
    }
    
    func updateInstructions(newInstructions: [Instructions]) {
        recipies[0][0].instructions = newInstructions
    }
    
    
    func updateName(newString: String) {
        recipies[0][0].name = newString
    }
    
    
    var recipieCollectionView : UICollectionView!
    var featureCollectionView : UICollectionView!
    
    var featureSection = ["Featured"]
    var sections = ["Breakfast", "Lunch", "Dinner", "Snack"]
    var featureRecipes : [[Recipie]] = []
    var recipies : [[Recipie]] =         [
        [Recipie(userId: 12, name: "Simone", time: 4, difficulty: "Begginer", mealType: "Lunch", cuisine: "Latin", ingredients: [Ingredients(id: 1, name: "eggs", amount: 3, unit: "Slices"), Ingredients(id: 1, name: "trouble", amount: 5, unit: "two")], instructions: [Instructions(id: 1, stepNumber: 1, step: "one"), Instructions(id: 1,stepNumber: 2, step: "two")], comments: [Comments(id: 12, userId: 12, text: "12")], numberOfLikes: 12, usersLiked: [User(id: 7, username: "one", email: "one", postedRecipes: [], likedRecipes: [], postedComments: ["one"])], usersCommented: [User(id: 2, username: "strg", email: "mail", postedRecipes: [], likedRecipes: [], postedComments: [])], createdAt: 2),
      Recipie(userId: 12, name: "Simone", time: 4, difficulty: "Begginer", mealType: "Lunch", cuisine: "Latin", ingredients: [Ingredients(id: 1,name: "eggs", amount: 3, unit: "Slices"), Ingredients(id: 1,name: "trouble", amount: 5, unit: "two")], instructions: [Instructions(id: 1,stepNumber: 1, step: "one"), Instructions(id: 1,stepNumber: 2, step: "two")], comments: [Comments(id: 12, userId: 12, text: "12")], numberOfLikes: 12, usersLiked: [User(id: 7, username: "one", email: "one", postedRecipes: [], likedRecipes: [], postedComments: ["one"])], usersCommented: [User(id: 2, username: "strg", email: "mail", postedRecipes: [], likedRecipes: [], postedComments: [])], createdAt: 2)], [Recipie(userId: 12, name: "Simone", time: 4, difficulty: "Begginer", mealType: "Lunch", cuisine: "Latin", ingredients: [Ingredients(id: 1, name: "eggs", amount: 3, unit: "Slices"), Ingredients(id: 1,name: "trouble", amount: 5, unit: "two")], instructions: [Instructions(id: 1,stepNumber: 1, step: "one"), Instructions(id: 1,stepNumber: 2, step: "two")], comments: [Comments(id: 12, userId: 12, text: "12")], numberOfLikes: 12, usersLiked: [User(id: 7, username: "one", email: "one", postedRecipes: [], likedRecipes: [], postedComments: ["one"])], usersCommented: [User(id: 2, username: "strg", email: "mail", postedRecipes: [], likedRecipes: [], postedComments: [])], createdAt: 2), Recipie(userId: 12, name: "Simone", time: 4, difficulty: "Begginer", mealType: "Lunch", cuisine: "Latin", ingredients: [Ingredients(id: 1,name: "eggs", amount: 3, unit: "Slices"), Ingredients(id: 1, name: "trouble", amount: 5, unit: "two")], instructions: [Instructions(id: 1,stepNumber: 1, step: "one"), Instructions(id: 1,stepNumber: 2, step: "two")], comments: [Comments(id: 12, userId: 12, text: "12")], numberOfLikes: 12, usersLiked: [User(id: 7, username: "one", email: "one", postedRecipes: [], likedRecipes: [], postedComments: ["one"])], usersCommented: [User(id: 2, username: "strg", email: "mail", postedRecipes: [], likedRecipes: [], postedComments: [])], createdAt: 2)], [Recipie(userId: 12, name: "Simone", time: 4, difficulty: "Begginer", mealType: "Lunch", cuisine: "Latin", ingredients: [Ingredients(id: 1,name: "eggs", amount: 3, unit: "Slices"), Ingredients(id: 1,name: "trouble", amount: 5, unit: "two")], instructions: [Instructions(id: 1,stepNumber: 1, step: "one"), Instructions(id: 1,stepNumber: 2, step: "two")], comments: [Comments(id: 12, userId: 12, text: "12")], numberOfLikes: 12, usersLiked: [User(id: 7, username: "one", email: "one", postedRecipes: [], likedRecipes: [], postedComments: ["one"])], usersCommented: [User(id: 2, username: "strg", email: "mail", postedRecipes: [], likedRecipes: [], postedComments: [])], createdAt: 2), Recipie(userId: 12, name: "Simone", time: 4, difficulty: "Begginer", mealType: "Lunch", cuisine: "Latin", ingredients: [Ingredients(id: 1,name: "eggs", amount: 3, unit: "Slices"), Ingredients(id: 1,name: "trouble", amount: 5, unit: "two")], instructions: [Instructions(id: 1,stepNumber: 1, step: "one"), Instructions(id: 1,stepNumber: 2, step: "two")], comments: [Comments(id: 12, userId: 12, text: "12")], numberOfLikes: 12, usersLiked: [User(id: 7, username: "one", email: "one", postedRecipes: [], likedRecipes: [], postedComments: ["one"])], usersCommented: [User(id: 2, username: "strg", email: "mail", postedRecipes: [], likedRecipes: [], postedComments: [])], createdAt: 2)], [Recipie(userId: 12, name: "Simone", time: 4, difficulty: "Begginer", mealType: "Lunch", cuisine: "Latin", ingredients: [Ingredients(id: 1,name: "eggs", amount: 3, unit: "Slices"), Ingredients(id: 1,name: "trouble", amount: 5, unit: "two")], instructions: [Instructions(id: 1,stepNumber: 1, step: "one"), Instructions(id: 1,stepNumber: 2, step: "two")], comments: [Comments(id: 12, userId: 12, text: "12")], numberOfLikes: 12, usersLiked: [User(id: 7, username: "one", email: "one", postedRecipes: [], likedRecipes: [], postedComments: ["one"])], usersCommented: [User(id: 2, username: "strg", email: "mail", postedRecipes: [], likedRecipes: [], postedComments: [])], createdAt: 2)],
        [Recipie(userId: 12, name: "Simone", time: 4, difficulty: "Begginer", mealType: "Lunch", cuisine: "Latin", ingredients: [Ingredients(id: 1, name: "eggs", amount: 3, unit: "Slices"), Ingredients(id: 1, name: "trouble", amount: 5, unit: "two")], instructions: [Instructions(id: 1, stepNumber: 1, step: "one"), Instructions(id: 1,stepNumber: 2, step: "two")], comments: [Comments(id: 12, userId: 12, text: "12")], numberOfLikes: 12, usersLiked: [User(id: 7, username: "one", email: "one", postedRecipes: [], likedRecipes: [], postedComments: ["one"])], usersCommented: [User(id: 2, username: "strg", email: "mail", postedRecipes: [], likedRecipes: [], postedComments: [])], createdAt: 2),
      Recipie(userId: 12, name: "Simone", time: 4, difficulty: "Begginer", mealType: "Lunch", cuisine: "Latin", ingredients: [Ingredients(id: 1,name: "eggs", amount: 3, unit: "Slices"), Ingredients(id: 1,name: "trouble", amount: 5, unit: "two")], instructions: [Instructions(id: 1,stepNumber: 1, step: "one"), Instructions(id: 1,stepNumber: 2, step: "two")], comments: [Comments(id: 12, userId: 12, text: "12")], numberOfLikes: 12, usersLiked: [User(id: 7, username: "one", email: "one", postedRecipes: [], likedRecipes: [], postedComments: ["one"])], usersCommented: [User(id: 2, username: "strg", email: "mail", postedRecipes: [], likedRecipes: [], postedComments: [])], createdAt: 2)], [Recipie(userId: 12, name: "Simone", time: 4, difficulty: "Begginer", mealType: "Lunch", cuisine: "Latin", ingredients: [Ingredients(id: 1, name: "eggs", amount: 3, unit: "Slices"), Ingredients(id: 1,name: "trouble", amount: 5, unit: "two")], instructions: [Instructions(id: 1,stepNumber: 1, step: "one"), Instructions(id: 1,stepNumber: 2, step: "two")], comments: [Comments(id: 12, userId: 12, text: "12")], numberOfLikes: 12, usersLiked: [User(id: 7, username: "one", email: "one", postedRecipes: [], likedRecipes: [], postedComments: ["one"])], usersCommented: [User(id: 2, username: "strg", email: "mail", postedRecipes: [], likedRecipes: [], postedComments: [])], createdAt: 2), Recipie(userId: 12, name: "Simone", time: 4, difficulty: "Begginer", mealType: "Lunch", cuisine: "Latin", ingredients: [Ingredients(id: 1,name: "eggs", amount: 3, unit: "Slices"), Ingredients(id: 1, name: "trouble", amount: 5, unit: "two")], instructions: [Instructions(id: 1,stepNumber: 1, step: "one"), Instructions(id: 1,stepNumber: 2, step: "two")], comments: [Comments(id: 12, userId: 12, text: "12")], numberOfLikes: 12, usersLiked: [User(id: 7, username: "one", email: "one", postedRecipes: [], likedRecipes: [], postedComments: ["one"])], usersCommented: [User(id: 2, username: "strg", email: "mail", postedRecipes: [], likedRecipes: [], postedComments: [])], createdAt: 2)], [Recipie(userId: 12, name: "Simone", time: 4, difficulty: "Begginer", mealType: "Lunch", cuisine: "Latin", ingredients: [Ingredients(id: 1,name: "eggs", amount: 3, unit: "Slices"), Ingredients(id: 1,name: "trouble", amount: 5, unit: "two")], instructions: [Instructions(id: 1,stepNumber: 1, step: "one"), Instructions(id: 1,stepNumber: 2, step: "two")], comments: [Comments(id: 12, userId: 12, text: "12")], numberOfLikes: 12, usersLiked: [User(id: 7, username: "one", email: "one", postedRecipes: [], likedRecipes: [], postedComments: ["one"])], usersCommented: [User(id: 2, username: "strg", email: "mail", postedRecipes: [], likedRecipes: [], postedComments: [])], createdAt: 2), Recipie(userId: 12, name: "Simone", time: 4, difficulty: "Begginer", mealType: "Lunch", cuisine: "Latin", ingredients: [Ingredients(id: 1,name: "eggs", amount: 3, unit: "Slices"), Ingredients(id: 1,name: "trouble", amount: 5, unit: "two")], instructions: [Instructions(id: 1,stepNumber: 1, step: "one"), Instructions(id: 1,stepNumber: 2, step: "two")], comments: [Comments(id: 12, userId: 12, text: "12")], numberOfLikes: 12, usersLiked: [User(id: 7, username: "one", email: "one", postedRecipes: [], likedRecipes: [], postedComments: ["one"])], usersCommented: [User(id: 2, username: "strg", email: "mail", postedRecipes: [], likedRecipes: [], postedComments: [])], createdAt: 2)], [Recipie(userId: 12, name: "Simone", time: 4, difficulty: "Begginer", mealType: "Lunch", cuisine: "Latin", ingredients: [Ingredients(id: 1,name: "eggs", amount: 3, unit: "Slices"), Ingredients(id: 1,name: "trouble", amount: 5, unit: "two")], instructions: [Instructions(id: 1,stepNumber: 1, step: "one"), Instructions(id: 1,stepNumber: 2, step: "two")], comments: [Comments(id: 12, userId: 12, text: "12")], numberOfLikes: 12, usersLiked: [User(id: 7, username: "one", email: "one", postedRecipes: [], likedRecipes: [], postedComments: ["one"])], usersCommented: [User(id: 2, username: "strg", email: "mail", postedRecipes: [], likedRecipes: [], postedComments: [])], createdAt: 2)],
        [Recipie(userId: 12, name: "Simone", time: 4, difficulty: "Begginer", mealType: "Lunch", cuisine: "Latin", ingredients: [Ingredients(id: 1, name: "eggs", amount: 3, unit: "Slices"), Ingredients(id: 1, name: "trouble", amount: 5, unit: "two")], instructions: [Instructions(id: 1, stepNumber: 1, step: "one"), Instructions(id: 1,stepNumber: 2, step: "two")], comments: [Comments(id: 12, userId: 12, text: "12")], numberOfLikes: 12, usersLiked: [User(id: 7, username: "one", email: "one", postedRecipes: [], likedRecipes: [], postedComments: ["one"])], usersCommented: [User(id: 2, username: "strg", email: "mail", postedRecipes: [], likedRecipes: [], postedComments: [])], createdAt: 2),
      Recipie(userId: 12, name: "Simone", time: 4, difficulty: "Begginer", mealType: "Lunch", cuisine: "Latin", ingredients: [Ingredients(id: 1,name: "eggs", amount: 3, unit: "Slices"), Ingredients(id: 1,name: "trouble", amount: 5, unit: "two")], instructions: [Instructions(id: 1,stepNumber: 1, step: "one"), Instructions(id: 1,stepNumber: 2, step: "two")], comments: [Comments(id: 12, userId: 12, text: "12")], numberOfLikes: 12, usersLiked: [User(id: 7, username: "one", email: "one", postedRecipes: [], likedRecipes: [], postedComments: ["one"])], usersCommented: [User(id: 2, username: "strg", email: "mail", postedRecipes: [], likedRecipes: [], postedComments: [])], createdAt: 2)], [Recipie(userId: 12, name: "Simone", time: 4, difficulty: "Begginer", mealType: "Lunch", cuisine: "Latin", ingredients: [Ingredients(id: 1, name: "eggs", amount: 3, unit: "Slices"), Ingredients(id: 1,name: "trouble", amount: 5, unit: "two")], instructions: [Instructions(id: 1,stepNumber: 1, step: "one"), Instructions(id: 1,stepNumber: 2, step: "two")], comments: [Comments(id: 12, userId: 12, text: "12")], numberOfLikes: 12, usersLiked: [User(id: 7, username: "one", email: "one", postedRecipes: [], likedRecipes: [], postedComments: ["one"])], usersCommented: [User(id: 2, username: "strg", email: "mail", postedRecipes: [], likedRecipes: [], postedComments: [])], createdAt: 2), Recipie(userId: 12, name: "Simone", time: 4, difficulty: "Begginer", mealType: "Lunch", cuisine: "Latin", ingredients: [Ingredients(id: 1,name: "eggs", amount: 3, unit: "Slices"), Ingredients(id: 1, name: "trouble", amount: 5, unit: "two")], instructions: [Instructions(id: 1,stepNumber: 1, step: "one"), Instructions(id: 1,stepNumber: 2, step: "two")], comments: [Comments(id: 12, userId: 12, text: "12")], numberOfLikes: 12, usersLiked: [User(id: 7, username: "one", email: "one", postedRecipes: [], likedRecipes: [], postedComments: ["one"])], usersCommented: [User(id: 2, username: "strg", email: "mail", postedRecipes: [], likedRecipes: [], postedComments: [])], createdAt: 2)], [Recipie(userId: 12, name: "Simone", time: 4, difficulty: "Begginer", mealType: "Lunch", cuisine: "Latin", ingredients: [Ingredients(id: 1,name: "eggs", amount: 3, unit: "Slices"), Ingredients(id: 1,name: "trouble", amount: 5, unit: "two")], instructions: [Instructions(id: 1,stepNumber: 1, step: "one"), Instructions(id: 1,stepNumber: 2, step: "two")], comments: [Comments(id: 12, userId: 12, text: "12")], numberOfLikes: 12, usersLiked: [User(id: 7, username: "one", email: "one", postedRecipes: [], likedRecipes: [], postedComments: ["one"])], usersCommented: [User(id: 2, username: "strg", email: "mail", postedRecipes: [], likedRecipes: [], postedComments: [])], createdAt: 2), Recipie(userId: 12, name: "Simone", time: 4, difficulty: "Begginer", mealType: "Lunch", cuisine: "Latin", ingredients: [Ingredients(id: 1,name: "eggs", amount: 3, unit: "Slices"), Ingredients(id: 1,name: "trouble", amount: 5, unit: "two")], instructions: [Instructions(id: 1,stepNumber: 1, step: "one"), Instructions(id: 1,stepNumber: 2, step: "two")], comments: [Comments(id: 12, userId: 12, text: "12")], numberOfLikes: 12, usersLiked: [User(id: 7, username: "one", email: "one", postedRecipes: [], likedRecipes: [], postedComments: ["one"])], usersCommented: [User(id: 2, username: "strg", email: "mail", postedRecipes: [], likedRecipes: [], postedComments: [])], createdAt: 2)], [Recipie(userId: 12, name: "Simone", time: 4, difficulty: "Begginer", mealType: "Lunch", cuisine: "Latin", ingredients: [Ingredients(id: 1,name: "eggs", amount: 3, unit: "Slices"), Ingredients(id: 1,name: "trouble", amount: 5, unit: "two")], instructions: [Instructions(id: 1,stepNumber: 1, step: "one"), Instructions(id: 1,stepNumber: 2, step: "two")], comments: [Comments(id: 12, userId: 12, text: "12")], numberOfLikes: 12, usersLiked: [User(id: 7, username: "one", email: "one", postedRecipes: [], likedRecipes: [], postedComments: ["one"])], usersCommented: [User(id: 2, username: "strg", email: "mail", postedRecipes: [], likedRecipes: [], postedComments: [])], createdAt: 2)],
        [Recipie(userId: 12, name: "Simone", time: 4, difficulty: "Begginer", mealType: "Lunch", cuisine: "Latin", ingredients: [Ingredients(id: 1, name: "eggs", amount: 3, unit: "Slices"), Ingredients(id: 1, name: "trouble", amount: 5, unit: "two")], instructions: [Instructions(id: 1, stepNumber: 1, step: "one"), Instructions(id: 1,stepNumber: 2, step: "two")], comments: [Comments(id: 12, userId: 12, text: "12")], numberOfLikes: 12, usersLiked: [User(id: 7, username: "one", email: "one", postedRecipes: [], likedRecipes: [], postedComments: ["one"])], usersCommented: [User(id: 2, username: "strg", email: "mail", postedRecipes: [], likedRecipes: [], postedComments: [])], createdAt: 2),
      Recipie(userId: 12, name: "Simone", time: 4, difficulty: "Begginer", mealType: "Lunch", cuisine: "Latin", ingredients: [Ingredients(id: 1,name: "eggs", amount: 3, unit: "Slices"), Ingredients(id: 1,name: "trouble", amount: 5, unit: "two")], instructions: [Instructions(id: 1,stepNumber: 1, step: "one"), Instructions(id: 1,stepNumber: 2, step: "two")], comments: [Comments(id: 12, userId: 12, text: "12")], numberOfLikes: 12, usersLiked: [User(id: 7, username: "one", email: "one", postedRecipes: [], likedRecipes: [], postedComments: ["one"])], usersCommented: [User(id: 2, username: "strg", email: "mail", postedRecipes: [], likedRecipes: [], postedComments: [])], createdAt: 2)], [Recipie(userId: 12, name: "Simone", time: 4, difficulty: "Begginer", mealType: "Lunch", cuisine: "Latin", ingredients: [Ingredients(id: 1, name: "eggs", amount: 3, unit: "Slices"), Ingredients(id: 1,name: "trouble", amount: 5, unit: "two")], instructions: [Instructions(id: 1,stepNumber: 1, step: "one"), Instructions(id: 1,stepNumber: 2, step: "two")], comments: [Comments(id: 12, userId: 12, text: "12")], numberOfLikes: 12, usersLiked: [User(id: 7, username: "one", email: "one", postedRecipes: [], likedRecipes: [], postedComments: ["one"])], usersCommented: [User(id: 2, username: "strg", email: "mail", postedRecipes: [], likedRecipes: [], postedComments: [])], createdAt: 2), Recipie(userId: 12, name: "Simone", time: 4, difficulty: "Begginer", mealType: "Lunch", cuisine: "Latin", ingredients: [Ingredients(id: 1,name: "eggs", amount: 3, unit: "Slices"), Ingredients(id: 1, name: "trouble", amount: 5, unit: "two")], instructions: [Instructions(id: 1,stepNumber: 1, step: "one"), Instructions(id: 1,stepNumber: 2, step: "two")], comments: [Comments(id: 12, userId: 12, text: "12")], numberOfLikes: 12, usersLiked: [User(id: 7, username: "one", email: "one", postedRecipes: [], likedRecipes: [], postedComments: ["one"])], usersCommented: [User(id: 2, username: "strg", email: "mail", postedRecipes: [], likedRecipes: [], postedComments: [])], createdAt: 2)], [Recipie(userId: 12, name: "Simone", time: 4, difficulty: "Begginer", mealType: "Lunch", cuisine: "Latin", ingredients: [Ingredients(id: 1,name: "eggs", amount: 3, unit: "Slices"), Ingredients(id: 1,name: "trouble", amount: 5, unit: "two")], instructions: [Instructions(id: 1,stepNumber: 1, step: "one"), Instructions(id: 1,stepNumber: 2, step: "two")], comments: [Comments(id: 12, userId: 12, text: "12")], numberOfLikes: 12, usersLiked: [User(id: 7, username: "one", email: "one", postedRecipes: [], likedRecipes: [], postedComments: ["one"])], usersCommented: [User(id: 2, username: "strg", email: "mail", postedRecipes: [], likedRecipes: [], postedComments: [])], createdAt: 2), Recipie(userId: 12, name: "Simone", time: 4, difficulty: "Begginer", mealType: "Lunch", cuisine: "Latin", ingredients: [Ingredients(id: 1,name: "eggs", amount: 3, unit: "Slices"), Ingredients(id: 1,name: "trouble", amount: 5, unit: "two")], instructions: [Instructions(id: 1,stepNumber: 1, step: "one"), Instructions(id: 1,stepNumber: 2, step: "two")], comments: [Comments(id: 12, userId: 12, text: "12")], numberOfLikes: 12, usersLiked: [User(id: 7, username: "one", email: "one", postedRecipes: [], likedRecipes: [], postedComments: ["one"])], usersCommented: [User(id: 2, username: "strg", email: "mail", postedRecipes: [], likedRecipes: [], postedComments: [])], createdAt: 2)], [Recipie(userId: 12, name: "Simone", time: 4, difficulty: "Begginer", mealType: "Lunch", cuisine: "Latin", ingredients: [Ingredients(id: 1,name: "eggs", amount: 3, unit: "Slices"), Ingredients(id: 1,name: "trouble", amount: 5, unit: "two")], instructions: [Instructions(id: 1,stepNumber: 1, step: "one"), Instructions(id: 1,stepNumber: 2, step: "two")], comments: [Comments(id: 12, userId: 12, text: "12")], numberOfLikes: 12, usersLiked: [User(id: 7, username: "one", email: "one", postedRecipes: [], likedRecipes: [], postedComments: ["one"])], usersCommented: [User(id: 2, username: "strg", email: "mail", postedRecipes: [], likedRecipes: [], postedComments: [])], createdAt: 2)]]

    
    

    let recipieCellReuseIdentifier = "recipieCellReuseIdentifier"
    let headerReuseIdentifier = "headerReuseIdentifer"
    let cellPadding: CGFloat = 10
    let sectionPadding: CGFloat = 5
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        title = "Home"
        // .orange
        view.backgroundColor = UIColor(red: 1, green: 0.947, blue: 0.867, alpha: 1)
        // Do any additional setup after loading the view.
        
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = cellPadding
        layout.minimumInteritemSpacing = cellPadding
        layout.scrollDirection = .vertical
        
        recipieCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        recipieCollectionView.translatesAutoresizingMaskIntoConstraints = false
        recipieCollectionView.backgroundColor = .clear
        
        
        recipieCollectionView.register(RecipeCollectionViewCell.self, forCellWithReuseIdentifier: recipieCellReuseIdentifier)
        
        recipieCollectionView.dataSource = self
        
        recipieCollectionView.delegate = self
        
        recipieCollectionView.register(HeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerReuseIdentifier)
        
        
        
        view.addSubview(recipieCollectionView)
//        view.addSubview(button)
        setupConstraints()
    }


    

    func setupConstraints() {
        let collectionViewPadding: CGFloat = 12
        NSLayoutConstraint.activate([
            recipieCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: collectionViewPadding),
            recipieCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: collectionViewPadding),
            recipieCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -collectionViewPadding),
            recipieCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -collectionViewPadding)
        ])
    }

        func numberOfSections(in collectionView: UICollectionView) -> Int {
            return sections.count
        }

        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return recipies[section].count
        }

        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: recipieCellReuseIdentifier, for: indexPath) as! RecipeCollectionViewCell
            let recipie = recipies[indexPath.section][indexPath.item]
            cell.configure(for: recipie)
            return cell
        }

        func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerReuseIdentifier, for: indexPath) as! HeaderView
            let section = sections[indexPath.section]
            header.configure(for: section)
            return header
        }

        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            let numItemsPerRow: CGFloat = 2.0
            let size = (collectionView.frame.width - cellPadding) / numItemsPerRow
            return CGSize(width: size, height: size)
        }

        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
            return CGSize(width: collectionView.frame.width, height: 50)
        }

    //MARK: Present View Controller Passing Delegate
    //present view controller reformat
//        func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//            recipies[indexPath.section][indexPath.item].isSelected.toggle()
//            if recipies[indexPath.section][indexPath.item].isSelected {
//                let vc = PresentViewController(delegate: self, placeholderName: recipies[indexPath.section][indexPath.item].name, placeholderIngredients: recipies[indexPath.section][indexPath.item].ingredients, placeholderInstructions: recipies[indexPath.section][indexPath.item].instructions)
//                self.present(vc, animated: true, completion: nil)
//            }
//            collectionView.reloadData()
//        }

//    }
}






//present view controller
//MARK: Recipe Controller
class PresentViewController: UIViewController, updateRecipeDelegate {
    func updateName(newString: String) {
        label.text = newString
    }
    
    

    // TODO 8: set up delegate
    weak var delegate: updateRecipeDelegate?

    private var button = UIButton()
    private var label = UILabel()
//    private var ingredientsField = UITextField()
    
    private var foodImage = UIImageView()
    
    private var diffcultyTag = UILabel()
    private var timeTag = UILabel()
    private var cuisineTag = UILabel()
    private var ingredientsButton = UIButton()
    private var methodLabel = UIButton()

    //    private var nameField = UITextField()
//    private var instructionsField = UITextView()

    var placeholderIngredients: [Ingredients]?
    var placeholderName: String?
    var placeholderInstructions: [Instructions]?
    var placeholderMeal: String?
    var placeholderCuisine: String?
    var placeholderDifficulty: String?
    var placeholderTime: Int?

    // TODO 10: initialize placeholder text
    
//    weak var delegate: updateRecipeDelegate?
    init(delegate: updateRecipeDelegate?, placeholderName: String, placeholderIngredients: [Ingredients], placeholderInstructions: [Instructions], placeholderCuisine: String, placeholderMeal: String, placeholderTime: Int, placeholderDifficulty: String) {
        self.delegate = delegate
        self.placeholderName = placeholderName
        self.placeholderIngredients = placeholderIngredients
        self.placeholderInstructions = placeholderInstructions
        self.placeholderMeal = placeholderMeal
        self.placeholderTime = placeholderTime
        self.placeholderCuisine = placeholderCuisine
        self.placeholderDifficulty = placeholderDifficulty
//        self.placeholderDifficulty = placeholderDifficulty
        super.init(nibName: nil, bundle: nil)
    }

    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white

        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = placeholderName
        label.font = UIFont.systemFont(ofSize: 18)
        label.textColor = .black
        view.addSubview(label)

        
        button.setImage(UIImage(named: "exit"), for: .normal)
        button.addTarget(self, action: #selector(dismissViewController), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        
        foodImage.image = UIImage(named: "\(placeholderMeal ?? "Dinner") 1")
//        print(foodImage.image)
        foodImage.translatesAutoresizingMaskIntoConstraints = false
        
        diffcultyTag.text = placeholderDifficulty
        diffcultyTag.textAlignment = .center
        diffcultyTag.font = UIFont(name: "Galvji", size: 12)
        diffcultyTag.layer.backgroundColor = UIColor(red: 0.942, green: 0.657, blue: 0.451, alpha: 1).cgColor
        diffcultyTag.layer.cornerRadius = 13.5
        diffcultyTag.translatesAutoresizingMaskIntoConstraints = false
        
        timeTag.text = "4 min"
        timeTag.textAlignment = .center
        timeTag.font = UIFont(name: "Galvji", size: 12)
        timeTag.layer.backgroundColor = UIColor(red: 0.942, green: 0.657, blue: 0.451, alpha: 1).cgColor
        timeTag.layer.cornerRadius = 13.5
        timeTag.translatesAutoresizingMaskIntoConstraints = false
        
        cuisineTag.text = placeholderCuisine
        cuisineTag.textAlignment = .center
        cuisineTag.font = UIFont(name: "Galvji", size: 12)
        cuisineTag.layer.backgroundColor = UIColor(red: 0.942, green: 0.657, blue: 0.451, alpha: 1).cgColor
        cuisineTag.layer.cornerRadius = 13.5
        cuisineTag.translatesAutoresizingMaskIntoConstraints = false
        
        ingredientsButton.setImage(UIImage(named: "ingredient"), for: .normal)
        ingredientsButton.addTarget(self, action: #selector(ingredientsTap), for: .touchUpInside)
        ingredientsButton.translatesAutoresizingMaskIntoConstraints = false
        
        
        methodLabel.setImage(UIImage(named: "methodnot"), for: .normal)
        methodLabel.addTarget(self, action: #selector(methodTap), for: .touchUpInside)
        methodLabel.translatesAutoresizingMaskIntoConstraints = false

        
        view.addSubview(foodImage)
        view.addSubview(diffcultyTag)
        view.addSubview(timeTag)
        view.addSubview(cuisineTag)
        
        view.addSubview(ingredientsButton)
        view.addSubview(methodLabel)
        view.addSubview(button)
        let vc = IngredientController(delegate: self, ingredientsPlace: placeholderIngredients!)
        view.addSubview(vc)
        
        setUpConstraints()
    }
    
    @objc func ingredientsTap () {
        if ingredientsButton.currentImage == UIImage(named: "ingredient") {
            ingredientsButton.setImage(UIImage(named: "ingredientnot"), for: .normal)
            methodLabel.setImage(UIImage(named: "method"), for: .normal)
            navigationController?.popViewController(animated: true)
//            present(vc, animated: true)
//            navigationController?.popViewController(vc, animated: true)
            let vc = MethodController(delegate: self, placeholderInstructions: placeholderInstructions!)
            view.addSubview(vc)
        } else {
            methodLabel.setImage(UIImage(named: "methodnot"), for: .normal)
            ingredientsButton.setImage(UIImage(named: "ingredient"), for: .normal)
            let vc = IngredientController(delegate: self, ingredientsPlace: placeholderIngredients!)
            view.addSubview(vc)
        }
    }
    
    @objc func methodTap () {
        if methodLabel.currentImage == UIImage(named: "method") {
            ingredientsButton.setImage(UIImage(named: "ingredient"), for: .normal)
            methodLabel.setImage(UIImage(named: "methodnot"), for: .normal)
            let vc = IngredientController(delegate: self, ingredientsPlace: placeholderIngredients!)
            view.addSubview(vc)
//            present(vc, animated: true)
//            navigationController?.pushViewController(vc, animated: true)
        } else {
            methodLabel.setImage(UIImage(named: "method"), for: .normal)
            ingredientsButton.setImage(UIImage(named: "ingredientnot"), for: .normal)
            let vc = MethodController(delegate: self, placeholderInstructions: placeholderInstructions!)
            view.addSubview(vc)
        }
    }

    func getIngredients(list: [Ingredients]) -> String {
        var strings = ""
        for ingredient in list {
            strings.append(ingredient.name)
//            strings.append(ingredient.amount)
        }
        return strings
    }
    
    func setUpConstraints() {
        
        NSLayoutConstraint.activate([
            foodImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            foodImage.topAnchor.constraint(equalTo: view.topAnchor),
            foodImage.heightAnchor.constraint(equalToConstant: 379),
            foodImage.widthAnchor.constraint(equalToConstant: 379),
        ])

        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.topAnchor.constraint(equalTo: foodImage.bottomAnchor, constant: 7),
            label.heightAnchor.constraint(equalToConstant: 32)
        ])
        
        NSLayoutConstraint.activate([
            diffcultyTag.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            diffcultyTag.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 5),
            diffcultyTag.widthAnchor.constraint(equalToConstant: 84),
            diffcultyTag.heightAnchor.constraint(equalToConstant: 22)
        ])
        
        NSLayoutConstraint.activate([
            timeTag.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            timeTag.topAnchor.constraint(equalTo: diffcultyTag.topAnchor),
//            timeTag.heightAnchor.constraint(equalToConstant: 32),
            timeTag.widthAnchor.constraint(equalToConstant: 84),
            timeTag.heightAnchor.constraint(equalToConstant: 22)
        ])
        
        NSLayoutConstraint.activate([
            cuisineTag.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            cuisineTag.topAnchor.constraint(equalTo: diffcultyTag.topAnchor),
            cuisineTag.widthAnchor.constraint(equalToConstant: 84),
            cuisineTag
                .heightAnchor.constraint(equalToConstant: 22)
        ])

        NSLayoutConstraint.activate([
            ingredientsButton.topAnchor.constraint(equalTo: cuisineTag.bottomAnchor, constant: 20),
            ingredientsButton.widthAnchor.constraint(equalToConstant: 142),
            ingredientsButton.heightAnchor.constraint(equalToConstant: 42),
            ingredientsButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20)
        ])
        
        NSLayoutConstraint.activate([
            methodLabel.topAnchor.constraint(equalTo: cuisineTag.bottomAnchor, constant: 20),
            methodLabel.widthAnchor.constraint(equalToConstant: 142),
            methodLabel.heightAnchor.constraint(equalToConstant: 42),
            methodLabel.leadingAnchor.constraint(equalTo: ingredientsButton.trailingAnchor, constant: 24)
        ])
        NSLayoutConstraint.activate([
            button.topAnchor.constraint(equalTo: view.topAnchor, constant: 40),
            button.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            button.widthAnchor.constraint(equalToConstant: 17),
            button.heightAnchor.constraint(equalToConstant: 17)
        ])
    }

    @objc func dismissViewController() {
        // TODO 9: call delegate function
//        delegate?.getRecipeList(allRecipies: new)
//        delegate?.updateTitle(newString: textField.text ?? "view controllers")
        // TODO 5: dismiss view controller
        dismiss(animated: true, completion: nil)
    }
    

}

//MARK: New Recipe

class NewViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    private var name = UILabel()
    private var ingredientsLabel = UILabel()
    private var methods = UILabel()
    private var tags = UILabel()
    private var photo = UILabel()
    private var photoLabel = UITextView()
    
    private var ingredientButton = UIButton()
    private var stepButton = UIButton()
    private var photoButton = UIButton()
    
    private var nameField = UITextField()
    var tableView = UITableView()
    var methodView = UITableView()
    let reuseIdentifier = "ingredientCellReuse"
    let methReuseIdentifier = "methodCellReuse"
    let cellHeight: CGFloat = 25
    
    var ingredients: [Ingredients] = []
    var instruction: [Instructions] = []
    
//    private var methodField = UITextField()
//    private var ingredientNameField = TextField()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Create New Recipe"
        view.backgroundColor = .white
        
        name.text = "Name"
        name.font = UIFont(name: "Galvji", size: 20)
        name.translatesAutoresizingMaskIntoConstraints = false
        
        ingredientsLabel.text = "Ingredients"
        ingredientsLabel.font = UIFont(name: "Galvji", size: 20)
        ingredientsLabel.translatesAutoresizingMaskIntoConstraints = false
        
        methods.text = "Method"
        methods.font = UIFont(name: "Galvji", size: 20)
        methods.translatesAutoresizingMaskIntoConstraints = false
        
        tags.text = "Tags"
        tags.font = UIFont(name: "Galvji", size: 20)
        tags.translatesAutoresizingMaskIntoConstraints = false
        
        photo.text = "Add Photo"
        photo.font = UIFont(name: "Galvji", size: 20)
        photo.translatesAutoresizingMaskIntoConstraints = false
        
        photoLabel.text = "Choose from one of our preset photos"
        photoLabel.font = UIFont(name: "Galvji", size: 12)
        photoLabel.translatesAutoresizingMaskIntoConstraints = false
        
        nameField.placeholder = "Name your culinary masterpiece"
        nameField.font = UIFont(name: "Galvji", size: 12)
        nameField.translatesAutoresizingMaskIntoConstraints = false
        
        ingredientButton.setImage(UIImage(named: "addIng"), for: .normal)
        ingredientButton.addTarget(self, action: #selector(addIngredient), for: .touchUpInside)
        ingredientButton.translatesAutoresizingMaskIntoConstraints = false
        
        stepButton.setImage(UIImage(named: "addStep"), for: .normal)
        stepButton.addTarget(self, action: #selector(addStep), for: .touchUpInside)
        stepButton.translatesAutoresizingMaskIntoConstraints = false
        
        photoButton.setTitle("Choose Photo", for: .normal)
        photoButton.setTitleColor(.black, for: .normal)
        photoButton.backgroundColor = UIColor(red: 1, green: 0.947, blue: 0.867, alpha: 1)
        photoButton.layer.cornerRadius = 18
        photoButton.translatesAutoresizingMaskIntoConstraints = false
        photoButton.addTarget(self, action: #selector(choosePhoto), for: .touchUpInside)
        
        tableView.separatorColor = .white
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(IngredientTableViewCell.self, forCellReuseIdentifier: reuseIdentifier)
        
        methodView.separatorColor = .white
        methodView.translatesAutoresizingMaskIntoConstraints = false
        methodView.dataSource = self
        methodView.delegate = self
        methodView.register(MethodTableViewCell.self, forCellReuseIdentifier: methReuseIdentifier)
        
        view.addSubview(nameField)
        view.addSubview(name)
        view.addSubview(ingredientsLabel)
        view.addSubview(methods)
        view.addSubview(tags)
        view.addSubview(photo)
        
        view.addSubview(tableView)
        view.addSubview(methodView)
        
        view.addSubview(stepButton)
        view.addSubview(ingredientButton)
        view.addSubview(photoButton)
        view.addSubview(photoLabel)
        
        setUpConstraints()
    }
    
    @objc func addIngredient() {
        let pop = IngredientPopUp()
        view.addSubview(pop)
    }
    
    @objc func addStep() {
        let pop = InstructionPopUp()
        view.addSubview(pop)
    }
    
    @objc func choosePhoto() {
        let vc = PhotoPopUp()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func setUpConstraints() {
        NSLayoutConstraint.activate([
            name.widthAnchor.constraint(equalToConstant: 67),
            name.heightAnchor.constraint(equalToConstant: 32),
            name.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            name.topAnchor.constraint(equalTo: view.topAnchor, constant: 131)
        ])
        NSLayoutConstraint.activate([
            ingredientsLabel.widthAnchor.constraint(equalToConstant: 132),
            ingredientsLabel.heightAnchor.constraint(equalToConstant: 32),
            ingredientsLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            ingredientsLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 203)
        ])
        NSLayoutConstraint.activate([
            methods.widthAnchor.constraint(equalToConstant: 119),
            methods.heightAnchor.constraint(equalToConstant: 32),
            methods.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 14),
            methods.topAnchor.constraint(equalTo: view.topAnchor, constant: 286)
        ])
        NSLayoutConstraint.activate([
            tags.widthAnchor.constraint(equalToConstant: 119),
            tags.heightAnchor.constraint(equalToConstant: 32),
            tags.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 13),
            tags.topAnchor.constraint(equalTo: view.topAnchor, constant: 374)
        ])
        NSLayoutConstraint.activate([
            nameField.heightAnchor.constraint(equalToConstant: 32),
            nameField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 93),
            nameField.widthAnchor.constraint(equalToConstant: 315),
            nameField.topAnchor.constraint(equalTo: name.topAnchor)
        ])
        NSLayoutConstraint.activate([
            ingredientButton.heightAnchor.constraint(equalToConstant: 16),
            ingredientButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            ingredientButton.widthAnchor.constraint(equalToConstant: 139),
            ingredientButton.bottomAnchor.constraint(equalTo: methods.topAnchor, constant: -20)
        ])
        NSLayoutConstraint.activate([
            stepButton.heightAnchor.constraint(equalToConstant: 16),
            stepButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            stepButton.widthAnchor.constraint(equalToConstant: 80),
            stepButton.bottomAnchor.constraint(equalTo: tags.topAnchor, constant: -20)
        ])
        
        NSLayoutConstraint.activate([
            photo.heightAnchor.constraint(equalToConstant: 32),
            photo.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 13),
            photo.widthAnchor.constraint(equalToConstant: 119),
            photo.topAnchor.constraint(equalTo: tags.bottomAnchor, constant: 20)
        ])
        
        NSLayoutConstraint.activate([
            photoButton.heightAnchor.constraint(equalToConstant: 40),
            photoButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            photoButton.widthAnchor.constraint(equalToConstant: 150),
            photoButton.topAnchor.constraint(equalTo: photo.bottomAnchor, constant: 20)
        ])
        
        NSLayoutConstraint.activate([
            photoLabel.heightAnchor.constraint(equalToConstant: 40),
            photoLabel.leadingAnchor.constraint(equalTo: photoButton.leadingAnchor),
            photoLabel.widthAnchor.constraint(equalTo: photoButton.widthAnchor),
            photoLabel.topAnchor.constraint(equalTo: photoButton.bottomAnchor, constant: 7)
        ])
        NSLayoutConstraint.activate([
            tableView.heightAnchor.constraint(equalToConstant: 40),
            tableView.leadingAnchor.constraint(equalTo: photoButton.leadingAnchor),
            tableView.widthAnchor.constraint(equalTo: photoButton.widthAnchor),
            tableView.topAnchor.constraint(equalTo: ingredientsLabel.bottomAnchor, constant: 7)
        ])
        NSLayoutConstraint.activate([
            methodView.heightAnchor.constraint(equalToConstant: 40),
            methodView.leadingAnchor.constraint(equalTo: photoButton.leadingAnchor),
            methodView.widthAnchor.constraint(equalTo: photoButton.widthAnchor),
            methodView.topAnchor.constraint(equalTo: methods.bottomAnchor, constant: 7)
        ])
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ingredients.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as? IngredientTableViewCell {
            let ingredients = ingredients[indexPath.row]
            cell.configure(ingredient: ingredients)
            cell.selectionStyle = .none
            return cell
        } else {
            return UITableViewCell()
        }
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 25
    }
}

//MARK: Ingredient Table Controller
class IngredientController: UIView, UITableViewDelegate, UITableViewDataSource{
    
    weak var delegate: updateRecipeDelegate?
    
    var tableView = UITableView()
    var image = UIImageView()

    let reuseIdentifier = "ingredientCellReuse"
    let cellHeight: CGFloat = 25
    let container: UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.backgroundColor = .white
        v.layer.cornerRadius = 24
        return v
    }()

    var ingredients: [Ingredients] = []
    
    override init (frame: CGRect) {
        super.init(frame: frame)
        self.frame = CGRect(x: 0, y: 550, width: 400, height: 304)
        
    }
    
    init (delegate: updateRecipeDelegate?, ingredientsPlace: [Ingredients]) {
//        super.init(coder: NSCoder.init())
        self.delegate = delegate
        self.ingredients = ingredientsPlace
//        print(self.ingredients)
        super.init(frame: CGRect(x: 0, y: 550, width: 400, height: 304))

        // Initialize tableView
//        var ingredients: [Ingredients] = []
        tableView.separatorColor = .white
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(IngredientTableViewCell.self, forCellReuseIdentifier: reuseIdentifier)
        
        self.addSubview(container)
        self.addSubview(tableView)

        container.heightAnchor.constraint(equalToConstant: 304).isActive = true
        container.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        container.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        container.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        
        
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: container.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: container.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: container.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: container.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ingredients.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as? IngredientTableViewCell {
            let ingredients = ingredients[indexPath.row]
//            print(ingredients)
            cell.configure(ingredient: ingredients)
            cell.selectionStyle = .none
            return cell
        } else {
            return UITableViewCell()
        }
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 25
    }

}

//MARK: Instruction Table Controller
class MethodController: UIView, UITableViewDelegate, UITableViewDataSource, updateInstructionDelegate {
    
    func updateInstructions(newInstructions: [Instructions]) {
        instructions = newInstructions
    }
    
    
    var tableView = UITableView()
    var methodLabel = UILabel()

    let reuseIdentifier = "methodCellReuse"
    let cellHeight: CGFloat = 25
    let container: UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.backgroundColor = .white
        v.layer.cornerRadius = 24
        return v
    }()

    var instructions: [Instructions] = []
    var instructions1: [Instructions] = []
    
    var placeholderName: String?
    var placeholderInstructions: [Instructions]?

    // TODO 10: initialize placeholder text
    
    weak var delegate: updateRecipeDelegate?
    
    init(delegate: updateRecipeDelegate?, placeholderInstructions: [Instructions]) {
        self.delegate = delegate
        self.placeholderInstructions = placeholderInstructions
//        super.init(nibName: nil, bundle: nil)
        super.init(frame: CGRect(x: 0, y: 550, width: 400, height: 304))
        
        
        methodLabel.text = "Instructions"
        methodLabel.font = UIFont(name: "Galvji", size: 20)
        instructions = placeholderInstructions

        // Initialize tableView
        tableView.separatorColor = .white
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(MethodTableViewCell.self, forCellReuseIdentifier: reuseIdentifier)
        
        self.addSubview(container)
        self.addSubview(tableView)

        
        container.heightAnchor.constraint(equalToConstant: 304).isActive = true
        container.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        container.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        container.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        
        
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: container.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: container.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: container.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: container.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        print(instructions.count)
        return instructions.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as? MethodTableViewCell {
            let ingredients = instructions[indexPath.row]
            cell.configure(instruction: ingredients)
            cell.selectionStyle = .none
            return cell
        } else {
            return UITableViewCell()
        }
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 21
    }

    
    override init (frame: CGRect) {
        super.init(frame: frame)
        self.frame = CGRect(x: 0, y: 550, width: 400, height: 304)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
}
