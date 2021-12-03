//
//  ViewController.swift
//  CornellCookbook
//
//  Created by Kayla Sprayberry on 11/18/21.
//

import UIKit

protocol UpdateIngredientsDelegate: class {
    func updateIngredients(newString: String)
    func updateInstructions(newString: String)
    func updateName(newString: String)
}

var hasUserID = false

class ViewController: UIViewController {
    
    
    private let button: UIButton = {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 200, height: 52))
        button.setTitle("Click to open", for: .normal)
        button.layer.borderWidth = 5
        button.layer.cornerRadius = 8
        button.layer.borderColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1).cgColor
        button.backgroundColor = .white
        button.setTitleColor(.black, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let firstImage : UIImageView = {
        let firstImage = UIImageView(image: UIImage(named: "screen1"))
//        firstImage.
        firstImage.sizeToFit()
        firstImage.translatesAutoresizingMaskIntoConstraints = false
        return firstImage
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        view.back
        view.backgroundColor = UIColor(red: 1, green: 0.947, blue: 0.867, alpha: 1)
//        title = "Welcome to Cornell Cookbook"
        //button
        button.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
//        view.addSubview(firstImage)
        
        view.addSubview(button)
        onboarding()
        setUpConstraints()
    }
    
    func onboarding(){
        if hasUserID {
            view.addSubview(firstImage)
        } else {
            view.addSubview(firstImage)
        }
    }
    
    func setUpConstraints (){
        NSLayoutConstraint.activate([
            firstImage.topAnchor.constraint(equalTo: view.topAnchor),
            firstImage.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            firstImage.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            firstImage.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        button.center = view.center
    }
    
    @objc func didTapButton() {
        button.backgroundColor = UIColor(red: 0.162, green: 0.162, blue: 0.162, alpha: 1)
//        let tabBarVC = UITabBarController()
        let vc3 = SearchViewController()
        let navVC = UINavigationController(rootViewController: vc3)
        navVC.modalPresentationStyle = .fullScreen
        present(navVC, animated: true)
    }

}
class ProfileViewController: UIViewController {

    let titleLabel = UILabel()
    let yourRecipes = UIButton()
    let savedRecipes = UIButton()
    let newRecipeButton = UIButton()
    let filter = UIButton()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
//        title = "Profile"
        titleLabel.text = "Karen's Cookbook'"
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
        

        if let image = UIImage(named: "new") {
                newRecipeButton.setImage(image, for: .normal)
        }
        newRecipeButton.translatesAutoresizingMaskIntoConstraints = false
        newRecipeButton.addTarget(self, action: #selector(newRecipe), for: .touchUpInside)

        
        
        view.addSubview(filter)
        view.addSubview(titleLabel)
        view.addSubview(newRecipeButton)
        
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
//        present(vc, animated: true)
        
//        let vc = PhotoPopUp()
//        navigationController?.pushViewController(vc, animated: true)
        
//        let pop = FilterPopUp()
//        view.addSubview(pop)
    }
    
    @objc func showYour() {
        yourRecipes.setTitleColor(UIColor(red: 0.692, green: 0.084, blue: 0.157, alpha: 1), for: .normal)
        savedRecipes.setTitleColor(.black, for: .normal)
        yourRecipes.layer.borderWidth = 2
        savedRecipes.layer.borderWidth = 0
        yourRecipes.layer.borderColor = UIColor(red: 0.692, green: 0.084, blue: 0.157, alpha: 1).cgColor
        let pop = FilterPopUp()
        
        let vc = HomeViewController()
        present(vc, animated: true)
        
        view.addSubview(pop)
    }
    
    @objc func showSaved() {
        savedRecipes.setTitleColor(UIColor(red: 0.692, green: 0.084, blue: 0.157, alpha: 1), for: .normal)
        yourRecipes.setTitleColor(.black, for: .normal)
        savedRecipes.layer.borderWidth = 2
        savedRecipes.layer.borderColor = UIColor(red: 0.692, green: 0.084, blue: 0.157, alpha: 1).cgColor
        yourRecipes.layer.borderWidth = 0
        
        let vc = HomeViewController()
        present(vc, animated: true)
        
        let pop = FilterPopUp()
        view.addSubview(pop)
    }
    
    func setupConstraints() {
        
        NSLayoutConstraint.activate([
            titleLabel.widthAnchor.constraint(equalToConstant: 268),
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
            savedRecipes.widthAnchor.constraint(equalToConstant: 119.53),
            savedRecipes.heightAnchor.constraint(equalToConstant: 33),
            savedRecipes.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 193),
            savedRecipes.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 1)
        ])
        
        NSLayoutConstraint.activate([
            yourRecipes.widthAnchor.constraint(equalToConstant: 108),
            yourRecipes.heightAnchor.constraint(equalToConstant: 33),
            yourRecipes.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 57),
            yourRecipes.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 1)
        ])
        
        NSLayoutConstraint.activate([
            newRecipeButton.widthAnchor.constraint(equalToConstant: 85),
            newRecipeButton.heightAnchor.constraint(equalToConstant: 85),
            newRecipeButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 145),
            newRecipeButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 730)
        ])
        
    }
}

class resultsController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 1, green: 0.947, blue: 0.867, alpha: 1)
    }
}

class SearchViewController: UIViewController,  UISearchBarDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate, UpdateIngredientsDelegate  {
    func updateIngredients(newString: String) {
        featureRecipes[1][1].name = newString
    }
    
    func updateInstructions(newString: String) {
        featureRecipes[1][1].name = newString
    }
    
    
//    func updateInstructions(newInstruction: Instructions) {
//        featureRecipes[1][1].name = [newInstruction]
//    }
    
    func updateName(newString: String) {
        featureRecipes[1][1].name = newString
    }
    
    
//    func updateIngredients(newIngredient: Ingredients) {
//        featureRecipes[1][1].ingredients = [newIngredient]
//    }

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
    let recentlyLabel = UILabel()
    
    var featureCollectionView : UICollectionView!
    
    var featureSection = ["Featured"]
    
//    func sortData() {
//        postData.sort { (leftPost, rightPost) -> Bool in
//            return leftPost.id > rightPost.id
//        }
//    }
//    getAllRecipes()
    var featureRecipes : [[Recipie]] =
        [
         [Recipie(userId: 12, name: "Simone", time: 4, difficulty: "Begginer", mealType: "Lunch", cuisine: "Latin", ingredients: [Ingredients(name: "eggs", amount: 3, unit: "Slices"), Ingredients(name: "trouble", amount: 5, unit: "two")], instructions: [Instructions(stepNumber: 1, step: "one"), Instructions(stepNumber: 2, step: "two")], comments: [Comments(id: 12, userId: 12, text: "12")], numberOfLikes: 12, usersLiked: [User(id: 7, username: "one", email: "one", postedRecipes: [], likedRecipes: [], postedComments: ["one"])], usersCommented: [User(id: 2, username: "strg", email: "mail", postedRecipes: [], likedRecipes: [], postedComments: [])], createdAt: 2),
          Recipie(userId: 12, name: "Simone", time: 4, difficulty: "Begginer", mealType: "Lunch", cuisine: "Latin", ingredients: [Ingredients(name: "eggs", amount: 3, unit: "Slices"), Ingredients(name: "trouble", amount: 5, unit: "two")], instructions: [Instructions(stepNumber: 1, step: "one"), Instructions(stepNumber: 2, step: "two")], comments: [Comments(id: 12, userId: 12, text: "12")], numberOfLikes: 12, usersLiked: [User(id: 7, username: "one", email: "one", postedRecipes: [], likedRecipes: [], postedComments: ["one"])], usersCommented: [User(id: 2, username: "strg", email: "mail", postedRecipes: [], likedRecipes: [], postedComments: [])], createdAt: 2)], [Recipie(userId: 12, name: "Simone", time: 4, difficulty: "Begginer", mealType: "Lunch", cuisine: "Latin", ingredients: [Ingredients(name: "eggs", amount: 3, unit: "Slices"), Ingredients(name: "trouble", amount: 5, unit: "two")], instructions: [Instructions(stepNumber: 1, step: "one"), Instructions(stepNumber: 2, step: "two")], comments: [Comments(id: 12, userId: 12, text: "12")], numberOfLikes: 12, usersLiked: [User(id: 7, username: "one", email: "one", postedRecipes: [], likedRecipes: [], postedComments: ["one"])], usersCommented: [User(id: 2, username: "strg", email: "mail", postedRecipes: [], likedRecipes: [], postedComments: [])], createdAt: 2), Recipie(userId: 12, name: "Simone", time: 4, difficulty: "Begginer", mealType: "Lunch", cuisine: "Latin", ingredients: [Ingredients(name: "eggs", amount: 3, unit: "Slices"), Ingredients(name: "trouble", amount: 5, unit: "two")], instructions: [Instructions(stepNumber: 1, step: "one"), Instructions(stepNumber: 2, step: "two")], comments: [Comments(id: 12, userId: 12, text: "12")], numberOfLikes: 12, usersLiked: [User(id: 7, username: "one", email: "one", postedRecipes: [], likedRecipes: [], postedComments: ["one"])], usersCommented: [User(id: 2, username: "strg", email: "mail", postedRecipes: [], likedRecipes: [], postedComments: [])], createdAt: 2)], [Recipie(userId: 12, name: "Simone", time: 4, difficulty: "Begginer", mealType: "Lunch", cuisine: "Latin", ingredients: [Ingredients(name: "eggs", amount: 3, unit: "Slices"), Ingredients(name: "trouble", amount: 5, unit: "two")], instructions: [Instructions(stepNumber: 1, step: "one"), Instructions(stepNumber: 2, step: "two")], comments: [Comments(id: 12, userId: 12, text: "12")], numberOfLikes: 12, usersLiked: [User(id: 7, username: "one", email: "one", postedRecipes: [], likedRecipes: [], postedComments: ["one"])], usersCommented: [User(id: 2, username: "strg", email: "mail", postedRecipes: [], likedRecipes: [], postedComments: [])], createdAt: 2), Recipie(userId: 12, name: "Simone", time: 4, difficulty: "Begginer", mealType: "Lunch", cuisine: "Latin", ingredients: [Ingredients(name: "eggs", amount: 3, unit: "Slices"), Ingredients(name: "trouble", amount: 5, unit: "two")], instructions: [Instructions(stepNumber: 1, step: "one"), Instructions(stepNumber: 2, step: "two")], comments: [Comments(id: 12, userId: 12, text: "12")], numberOfLikes: 12, usersLiked: [User(id: 7, username: "one", email: "one", postedRecipes: [], likedRecipes: [], postedComments: ["one"])], usersCommented: [User(id: 2, username: "strg", email: "mail", postedRecipes: [], likedRecipes: [], postedComments: [])], createdAt: 2)], [Recipie(userId: 12, name: "Simone", time: 4, difficulty: "Begginer", mealType: "Lunch", cuisine: "Latin", ingredients: [Ingredients(name: "eggs", amount: 3, unit: "Slices"), Ingredients(name: "trouble", amount: 5, unit: "two")], instructions: [Instructions(stepNumber: 1, step: "one"), Instructions(stepNumber: 2, step: "two")], comments: [Comments(id: 12, userId: 12, text: "12")], numberOfLikes: 12, usersLiked: [User(id: 7, username: "one", email: "one", postedRecipes: [], likedRecipes: [], postedComments: ["one"])], usersCommented: [User(id: 2, username: "strg", email: "mail", postedRecipes: [], likedRecipes: [], postedComments: [])], createdAt: 2)]]
        
    let recipieCellReuseIdentifier = "recipieCellReuseIdentifier"
//    let headerReuseIdentifier = "headerReuseIdentifer"
    let cellPadding: CGFloat = 10
    let sectionPadding: CGFloat = 5
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
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
//        featureCollectionView.layer.contents.
        
        
        featureCollectionView.register(RowCollectionViewCell.self, forCellWithReuseIdentifier: recipieCellReuseIdentifier)
        
        featureCollectionView.dataSource = self
        
        featureCollectionView.delegate = self
//
//        featureCollectionView.register(HeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerReuseIdentifier)
        
        view.addSubview(featureCollectionView)
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
//            profile.topAnchor.constraint(equalTo: view.topAnchor, constant: 93)
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
            featureLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 406)
        ])
        
        NSLayoutConstraint.activate([
            recentlyLabel.widthAnchor.constraint(equalToConstant: 160),
            recentlyLabel.heightAnchor.constraint(equalToConstant: 29),
            recentlyLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 7),
            recentlyLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 647)
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

//    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
//        let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerReuseIdentifier, for: indexPath) as! HeaderView
//        let section = featureSection[indexPath.section]
//        header.configure(for: section)
//        return header
//    }
    
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
            let vc = PresentViewController(delegate: self, placeholderName: featureRecipes[indexPath.section][indexPath.item].name, placeholderIngredients: featureRecipes[indexPath.section][indexPath.item].ingredients, placeholderInstructions: featureRecipes[indexPath.section][indexPath.item].instructions)
            vc.modalPresentationStyle = .fullScreen
            navigationController?.present(vc, animated: true)
//            self.present(vc, animated: true, completion: nil)
        }
        collectionView.reloadData()
    }
    
}

class HomeViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate, UpdateIngredientsDelegate  {
    
    func updateInstructions(newString: String) {
        recipies[1][1].name = newString
    }
    
    func updateName(newString: String) {
        recipies[1][1].name = newString
    }
    
    
    func updateIngredients(newString: String) {
        recipies[1][1].name = newString
    }
    
    
    var recipieCollectionView : UICollectionView!
    var featureCollectionView : UICollectionView!
    
    var featureSection = ["Featured"]
    var sections = ["Breakfast", "Lunch", "Dinner", "Snack"]
    var featureRecipes : [[Recipie]] = []
    var recipies : [[Recipie]] = [[Recipie(userId: 12, name: "Simone", time: 4, difficulty: "Begginer", mealType: "Lunch", cuisine: "Latin", ingredients: [Ingredients(name: "eggs", amount: 3, unit: "Slices"), Ingredients(name: "trouble", amount: 5, unit: "two")], instructions: [Instructions(stepNumber: 1, step: "one"), Instructions(stepNumber: 2, step: "two")], comments: [Comments(id: 12, userId: 12, text: "12")], numberOfLikes: 12, usersLiked: [User(id: 7, username: "one", email: "one", postedRecipes: [], likedRecipes: [], postedComments: ["one"])], usersCommented: [User(id: 2, username: "strg", email: "mail", postedRecipes: [], likedRecipes: [], postedComments: [])], createdAt: 2)], [Recipie(userId: 12, name: "Simone", time: 4, difficulty: "Begginer", mealType: "Lunch", cuisine: "Latin", ingredients: [Ingredients(name: "eggs", amount: 3, unit: "Slices"), Ingredients(name: "trouble", amount: 5, unit: "two")], instructions: [Instructions(stepNumber: 1, step: "one"), Instructions(stepNumber: 2, step: "two")], comments: [Comments(id: 12, userId: 12, text: "12")], numberOfLikes: 12, usersLiked: [User(id: 7, username: "one", email: "one", postedRecipes: [], likedRecipes: [], postedComments: ["one"])], usersCommented: [User(id: 2, username: "strg", email: "mail", postedRecipes: [], likedRecipes: [], postedComments: [])], createdAt: 2)], [Recipie(userId: 12, name: "Simone", time: 4, difficulty: "Begginer", mealType: "Lunch", cuisine: "Latin", ingredients: [Ingredients(name: "eggs", amount: 3, unit: "Slices"), Ingredients(name: "trouble", amount: 5, unit: "two")], instructions: [Instructions(stepNumber: 1, step: "one"), Instructions(stepNumber: 2, step: "two")], comments: [Comments(id: 12, userId: 12, text: "12")], numberOfLikes: 12, usersLiked: [User(id: 7, username: "one", email: "one", postedRecipes: [], likedRecipes: [], postedComments: ["one"])], usersCommented: [User(id: 2, username: "strg", email: "mail", postedRecipes: [], likedRecipes: [], postedComments: [])], createdAt: 2)], [Recipie(userId: 12, name: "Simone", time: 4, difficulty: "Begginer", mealType: "Lunch", cuisine: "Latin", ingredients: [Ingredients(name: "eggs", amount: 3, unit: "Slices"), Ingredients(name: "trouble", amount: 5, unit: "two")], instructions: [Instructions(stepNumber: 1, step: "one"), Instructions(stepNumber: 2, step: "two")], comments: [Comments(id: 12, userId: 12, text: "12")], numberOfLikes: 12, usersLiked: [User(id: 7, username: "one", email: "one", postedRecipes: [], likedRecipes: [], postedComments: ["one"])], usersCommented: [User(id: 2, username: "strg", email: "mail", postedRecipes: [], likedRecipes: [], postedComments: [])], createdAt: 2)], [Recipie(userId: 12, name: "Simone", time: 4, difficulty: "Begginer", mealType: "Lunch", cuisine: "Latin", ingredients: [Ingredients(name: "eggs", amount: 3, unit: "Slices"), Ingredients(name: "trouble", amount: 5, unit: "two")], instructions: [Instructions(stepNumber: 1, step: "one"), Instructions(stepNumber: 2, step: "two")], comments: [Comments(id: 12, userId: 12, text: "12")], numberOfLikes: 12, usersLiked: [User(id: 7, username: "one", email: "one", postedRecipes: [], likedRecipes: [], postedComments: ["one"])], usersCommented: [User(id: 2, username: "strg", email: "mail", postedRecipes: [], likedRecipes: [], postedComments: [])], createdAt: 2)], [Recipie(userId: 12, name: "Simone", time: 4, difficulty: "Begginer", mealType: "Lunch", cuisine: "Latin", ingredients: [Ingredients(name: "eggs", amount: 3, unit: "Slices"), Ingredients(name: "trouble", amount: 5, unit: "two")], instructions: [Instructions(stepNumber: 1, step: "one"), Instructions(stepNumber: 2, step: "two")], comments: [Comments(id: 12, userId: 12, text: "12")], numberOfLikes: 12, usersLiked: [User(id: 7, username: "one", email: "one", postedRecipes: [], likedRecipes: [], postedComments: ["one"])], usersCommented: [User(id: 2, username: "strg", email: "mail", postedRecipes: [], likedRecipes: [], postedComments: [])], createdAt: 2)], [Recipie(userId: 12, name: "Simone", time: 4, difficulty: "Begginer", mealType: "Lunch", cuisine: "Latin", ingredients: [Ingredients(name: "eggs", amount: 3, unit: "Slices"), Ingredients(name: "trouble", amount: 5, unit: "two")], instructions: [Instructions(stepNumber: 1, step: "one"), Instructions(stepNumber: 2, step: "two")], comments: [Comments(id: 12, userId: 12, text: "12")], numberOfLikes: 12, usersLiked: [User(id: 7, username: "one", email: "one", postedRecipes: [], likedRecipes: [], postedComments: ["one"])], usersCommented: [User(id: 2, username: "strg", email: "mail", postedRecipes: [], likedRecipes: [], postedComments: [])], createdAt: 2)], [Recipie(userId: 12, name: "Simone", time: 4, difficulty: "Begginer", mealType: "Lunch", cuisine: "Latin", ingredients: [Ingredients(name: "eggs", amount: 3, unit: "Slices"), Ingredients(name: "trouble", amount: 5, unit: "two")], instructions: [Instructions(stepNumber: 1, step: "one"), Instructions(stepNumber: 2, step: "two")], comments: [Comments(id: 12, userId: 12, text: "12")], numberOfLikes: 12, usersLiked: [User(id: 7, username: "one", email: "one", postedRecipes: [], likedRecipes: [], postedComments: ["one"])], usersCommented: [User(id: 2, username: "strg", email: "mail", postedRecipes: [], likedRecipes: [], postedComments: [])], createdAt: 2)], [Recipie(userId: 12, name: "Simone", time: 4, difficulty: "Begginer", mealType: "Lunch", cuisine: "Latin", ingredients: [Ingredients(name: "eggs", amount: 3, unit: "Slices"), Ingredients(name: "trouble", amount: 5, unit: "two")], instructions: [Instructions(stepNumber: 1, step: "one"), Instructions(stepNumber: 2, step: "two")], comments: [Comments(id: 12, userId: 12, text: "12")], numberOfLikes: 12, usersLiked: [User(id: 7, username: "one", email: "one", postedRecipes: [], likedRecipes: [], postedComments: ["one"])], usersCommented: [User(id: 2, username: "strg", email: "mail", postedRecipes: [], likedRecipes: [], postedComments: [])], createdAt: 2)], [Recipie(userId: 12, name: "Simone", time: 4, difficulty: "Begginer", mealType: "Lunch", cuisine: "Latin", ingredients: [Ingredients(name: "eggs", amount: 3, unit: "Slices"), Ingredients(name: "trouble", amount: 5, unit: "two")], instructions: [Instructions(stepNumber: 1, step: "one"), Instructions(stepNumber: 2, step: "two")], comments: [Comments(id: 12, userId: 12, text: "12")], numberOfLikes: 12, usersLiked: [User(id: 7, username: "one", email: "one", postedRecipes: [], likedRecipes: [], postedComments: ["one"])], usersCommented: [User(id: 2, username: "strg", email: "mail", postedRecipes: [], likedRecipes: [], postedComments: [])], createdAt: 2)], [Recipie(userId: 12, name: "Simone", time: 4, difficulty: "Begginer", mealType: "Lunch", cuisine: "Latin", ingredients: [Ingredients(name: "eggs", amount: 3, unit: "Slices"), Ingredients(name: "trouble", amount: 5, unit: "two")], instructions: [Instructions(stepNumber: 1, step: "one"), Instructions(stepNumber: 2, step: "two")], comments: [Comments(id: 12, userId: 12, text: "12")], numberOfLikes: 12, usersLiked: [User(id: 7, username: "one", email: "one", postedRecipes: [], likedRecipes: [], postedComments: ["one"])], usersCommented: [User(id: 2, username: "strg", email: "mail", postedRecipes: [], likedRecipes: [], postedComments: [])], createdAt: 2)], [Recipie(userId: 12, name: "Simone", time: 4, difficulty: "Begginer", mealType: "Lunch", cuisine: "Latin", ingredients: [Ingredients(name: "eggs", amount: 3, unit: "Slices"), Ingredients(name: "trouble", amount: 5, unit: "two")], instructions: [Instructions(stepNumber: 1, step: "one"), Instructions(stepNumber: 2, step: "two")], comments: [Comments(id: 12, userId: 12, text: "12")], numberOfLikes: 12, usersLiked: [User(id: 7, username: "one", email: "one", postedRecipes: [], likedRecipes: [], postedComments: ["one"])], usersCommented: [User(id: 2, username: "strg", email: "mail", postedRecipes: [], likedRecipes: [], postedComments: [])], createdAt: 2)]]

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
    
    //  Conform to UICollectionViewDataSource
//    ViewController: UICollectionViewDataSource {

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

//    }

    //  Conform to UICollectionViewDelegateFlowLayout
    //  Conform to UICollectionViewDelegate, implement interaction
//    ViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDelegate {

        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            let numItemsPerRow: CGFloat = 2.0
            let size = (collectionView.frame.width - cellPadding) / numItemsPerRow
//            let numItemsPerRow
            return CGSize(width: size, height: size)
        }

        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
            return CGSize(width: collectionView.frame.width, height: 50)
        }

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

class PresentViewController: UIViewController {

    // TODO 8: set up delegate
    weak var delegate: UpdateIngredientsDelegate?

    private var button = UIButton()
    private var label = UILabel()
    private var ingredientsField = UITextField()
    
    private var foodImage = UIImageView()
    
    private var diffcultyTag = UILabel()
    private var timeTag = UILabel()
    private var cuisineTag = UILabel()
    private var ingredientsButton = UIButton()
    private var methodLabel = UIButton()

    //    private var nameField = UITextField()
    private var instructionsField = UITextView()

    var placeholderIngredients: [Ingredients]?
    var placeholderName: String?
    var placeholderInstructions: [Instructions]?

    // TODO 10: initialize placeholder text
    init(delegate: UpdateIngredientsDelegate?, placeholderName: String, placeholderIngredients: [Ingredients], placeholderInstructions: [Instructions]) {
        self.delegate = delegate
        self.placeholderName = placeholderName
        self.placeholderIngredients = placeholderIngredients
        self.placeholderInstructions = placeholderInstructions
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
//        button.setTitle("Done", for: .normal)
//        button.setTitleColor(.black, for: .normal)
//        button.backgroundColor = UIColor(red: 240/255, green: 240/255, blue: 240/255, alpha: 1)
//        button.layer.cornerRadius = 4
        button.addTarget(self, action: #selector(dismissViewController), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(button)

        ingredientsField.translatesAutoresizingMaskIntoConstraints = false
        ingredientsField.font = UIFont.systemFont(ofSize: 18)
        // TODO 10: set placeholder text
        ingredientsField.text = getIngredients(list: placeholderIngredients!)
        ingredientsField.borderStyle = .roundedRect
        
        ingredientsField.textAlignment = .center
        view.addSubview(ingredientsField)
        
        instructionsField.translatesAutoresizingMaskIntoConstraints = false
        instructionsField.font = UIFont.systemFont(ofSize: 18)
        // TODO 10: set placeholder text
        instructionsField.text = "instruction Placeholder"
        instructionsField.layer.cornerRadius = 4
//        instructionsField.layer
        instructionsField.textAlignment = .center
        view.addSubview(instructionsField)
        
        foodImage.image = UIImage(named: "Avatar 1")
        foodImage.translatesAutoresizingMaskIntoConstraints = false
        
        diffcultyTag.text = "Beginner"
        diffcultyTag.textAlignment = .center
        diffcultyTag.font = UIFont(name: "Galvji", size: 12)
        diffcultyTag.layer.backgroundColor = UIColor(red: 0.942, green: 0.657, blue: 0.451, alpha: 1).cgColor
        diffcultyTag.layer.cornerRadius = 13.5
        diffcultyTag.translatesAutoresizingMaskIntoConstraints = false
        
        timeTag.text = "10 min"
        timeTag.textAlignment = .center
        timeTag.font = UIFont(name: "Galvji", size: 12)
        timeTag.layer.backgroundColor = UIColor(red: 0.942, green: 0.657, blue: 0.451, alpha: 1).cgColor
        timeTag.layer.cornerRadius = 13.5
        timeTag.translatesAutoresizingMaskIntoConstraints = false
        
        cuisineTag.text = "Asian"
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
        
        
        setUpConstraints()
    }
    
    @objc func ingredientsTap () {
        if ingredientsButton.currentImage == UIImage(named: "ingredient") {
            ingredientsButton.setImage(UIImage(named: "ingredientnot"), for: .normal)
            methodLabel.setImage(UIImage(named: "method"), for: .normal)
        } else {
            methodLabel.setImage(UIImage(named: "methodnot"), for: .normal)
            ingredientsButton.setImage(UIImage(named: "ingredient"), for: .normal)
            let vc = IngredientController()
            view.addSubview(vc)
            
//            present(vc, animated: true)
//            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    @objc func methodTap () {
        if methodLabel.currentImage == UIImage(named: "method") {
            ingredientsButton.setImage(UIImage(named: "ingredient"), for: .normal)
            methodLabel.setImage(UIImage(named: "methodnot"), for: .normal)
            let vc = IngredientController()
            view.addSubview(vc)
//            present(vc, animated: true)
//            navigationController?.pushViewController(vc, animated: true)
        } else {
            methodLabel.setImage(UIImage(named: "method"), for: .normal)
            ingredientsButton.setImage(UIImage(named: "ingredientnot"), for: .normal)
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
            ingredientsButton.leadingAnchor.constraint(equalTo: ingredientsField.leadingAnchor)
        ])
        
        NSLayoutConstraint.activate([
            methodLabel.topAnchor.constraint(equalTo: cuisineTag.bottomAnchor, constant: 20),
            methodLabel.widthAnchor.constraint(equalToConstant: 142),
            methodLabel.heightAnchor.constraint(equalToConstant: 42),
            methodLabel.leadingAnchor.constraint(equalTo: ingredientsButton.trailingAnchor, constant: 24)
        ])
        
        
        NSLayoutConstraint.activate([
            ingredientsField.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 20),
            ingredientsField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            ingredientsField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            ingredientsField.heightAnchor.constraint(equalToConstant: 32)
        ])
        
        NSLayoutConstraint.activate([
            instructionsField.topAnchor.constraint(equalTo: ingredientsField.bottomAnchor, constant: 20),
            instructionsField.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -60),
            instructionsField.leadingAnchor.constraint(equalTo: ingredientsField.leadingAnchor),
            instructionsField.trailingAnchor.constraint(equalTo: ingredientsField.trailingAnchor)
        ])
        
        NSLayoutConstraint.activate([
            button.topAnchor.constraint(equalTo: view.topAnchor, constant: -40),
            button.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 30),
            button.widthAnchor.constraint(equalToConstant: 17),
            button.heightAnchor.constraint(equalToConstant: 17)
        ])
        
        
        
    }

    @objc func dismissViewController() {
        // TODO 9: call delegate function
//        delegate?.updateTitle(newString: textField.text ?? "view controllers")
        // TODO 5: dismiss view controller
        dismiss(animated: true, completion: nil)
    }

}

class NewViewController: UIViewController {
    
    private var name = UILabel()
    private var ingredients = UILabel()
    private var methods = UILabel()
    private var tags = UILabel()
    private var photo = UILabel()
    private var photoLabel = UITextView()
    
    private var ingredientButton = UIButton()
    private var stepButton = UIButton()
    private var photoButton = UIButton()
    
    private var nameField = UITextField()
//    private var methodField = UITextField()
//    private var ingredientNameField = TextField()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Create New Recipe"
        view.backgroundColor = .white
        
        name.text = "Name"
        name.font = UIFont(name: "Galvji", size: 20)
        name.translatesAutoresizingMaskIntoConstraints = false
        
        ingredients.text = "Ingredients"
        ingredients.font = UIFont(name: "Galvji", size: 20)
        ingredients.translatesAutoresizingMaskIntoConstraints = false
        
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
        
        view.addSubview(nameField)
        view.addSubview(name)
        view.addSubview(ingredients)
        view.addSubview(methods)
        view.addSubview(tags)
        view.addSubview(photo)
        
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
            ingredients.widthAnchor.constraint(equalToConstant: 132),
            ingredients.heightAnchor.constraint(equalToConstant: 32),
            ingredients.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            ingredients.topAnchor.constraint(equalTo: view.topAnchor, constant: 203)
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
        
    }
}


class IngredientController: UIView, UITableViewDelegate, UITableViewDataSource {
    var tableView = UITableView()
    var image = UIImageView()

    let reuseIdentifier = "ingredientCellReuse"
    let cellHeight: CGFloat = 22
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
        self.frame = UIScreen.main.bounds
//        self.backgroundColor = .white
        
//        view.frame = CGRect(x: 1, y: 2, width: 3, height: 5)
        
        let ingredient1 = Ingredients(name: "Beans", amount: 2, unit: "String")
        let ingredient2 = Ingredients(name: "Beans", amount: 2, unit: "String")
        let ingredient3 = Ingredients(name: "Beans", amount: 2, unit: "String")
        let ingredient4 = Ingredients(name: "Beans", amount: 2, unit: "String")
        let ingredient5 = Ingredients(name: "Beans", amount: 2, unit: "String")
        let ingredient6 = Ingredients(name: "Beans", amount: 2, unit: "String")
        
        
        ingredients = [ingredient1, ingredient2, ingredient3, ingredient4,ingredient5, ingredient6,]

        // Initialize tableView
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
            cell.configure(ingredient: ingredients)
            cell.selectionStyle = .none
            return cell
        } else {
            return UITableViewCell()
        }
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 21
    }

}
