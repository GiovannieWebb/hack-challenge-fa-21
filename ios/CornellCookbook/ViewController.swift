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


class ViewController: UIViewController {
    
//    var homeView = HomeViewController()
    
    private let button: UIButton = {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 200, height: 52))
        button.setTitle("Click to open", for: .normal)
        button.layer.borderWidth = 5
        button.layer.cornerRadius = 8
        button.layer.borderColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1).cgColor
        button.backgroundColor = .white
        button.setTitleColor(.black, for: .normal)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 1, green: 0.947, blue: 0.867, alpha: 1)
        title = "Welcome to Cornell Cookbook"
        //button
        button.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
        
        view.addSubview(button)
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        button.center = view.center
    }
    
    @objc func didTapButton() {
        button.backgroundColor = UIColor(red: 0.162, green: 0.162, blue: 0.162, alpha: 1)
        let tabBarVC = UITabBarController()
        let vc3 = SearchViewController()
        let vc1 = HomeViewController()
        let vc2 = ProfileViewController()
        
//        vc3.title = "Search"
//        vc1.title = "Home"
//        vc2.title = "Profile"
        
        tabBarVC.setViewControllers([vc3, vc1, vc2], animated: false)
        
        guard let items1 = tabBarVC.tabBar.items else {
            return
        }
        
        let images = ["search", "home","profile" ]

        for x in 0..<items1.count {
            items1[x].image = UIImage(named: images[x])
        }
        
        tabBarVC.tabBar.barTintColor = UIColor(red: 0.267, green: 0.259, blue: 0.259, alpha: 1)
//       wrong color fix later
        tabBarVC.modalPresentationStyle = .fullScreen
        present(tabBarVC, animated: true)
        tabBarVC.selectedIndex = 1
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
        view.backgroundColor = UIColor(red: 1, green: 0.947, blue: 0.867, alpha: 1)
//        title = "Profile"
        titleLabel.text = "Karen C"
        titleLabel.font = UIFont(name: "Galvji-Bold", size: 30)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        
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
        setupConstraints()
    }
    
    @objc func showFilters() {
        let pop = FilterPopUp()
        view.addSubview(pop)
    }
    
    @objc func newRecipe() {
//        let pop = FilterPopUp()
//        view.addSubview(pop)
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
    
    let popularLabel = UILabel()
    let featureLabel = UILabel()
    let recentlyLabel = UILabel()
    
    var featureCollectionView : UICollectionView!
    
    var featureSection = ["Featured"]
//    getAllRecipes()
    var featureRecipes : [[Recipie]] =
        [[Recipie(userId: 12, name: "Simone", time: 4, difficulty: "Begginer", mealType: "Lunch", cuisine: "Latin", ingredients: [Ingredients(name: "eggs", amount: 3, unit: "Slices"), Ingredients(name: "trouble", amount: 5, unit: "two")], instructions: [Instructions(stepNumber: 1, step: "one"), Instructions(stepNumber: 2, step: "two")], comments: [Comments(id: 12, userId: 12, text: "12")], numberOfLikes: 12, usersLiked: [User(id: 7, username: "one", email: "one", postedRecipes: [], likedRecipes: [], postedComments: ["one"])], usersCommented: [User(id: 2, username: "strg", email: "mail", postedRecipes: [], likedRecipes: [], postedComments: [])], createdAt: 2)]]
        
    let recipieCellReuseIdentifier = "recipieCellReuseIdentifier"
//    let headerReuseIdentifier = "headerReuseIdentifer"
    let cellPadding: CGFloat = 10
    let sectionPadding: CGFloat = 5
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 1, green: 0.947, blue: 0.867, alpha: 1)
        
        searchControl.searchBarStyle = UISearchBar.Style.default
        searchControl.placeholder = " Search..."

        searchControl.keyboardType = .default
        searchControl.isTranslucent = true
        searchControl.backgroundImage = UIImage()
        searchControl.delegate = self
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
        
        
        filter.setTitle("Filter", for: .normal)
        filter.setTitleColor(.black, for: .normal)
        filter.translatesAutoresizingMaskIntoConstraints = false
        filter.addTarget(self, action: #selector(showFilters), for: .touchUpInside)
        
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
        
        view.addSubview(popularLabel)
        view.addSubview(featureLabel)
        view.addSubview(recentlyLabel)
        setupConstraints()
    }
    
    @objc func showFilters() {
        let pop = FilterPopUp()
        view.addSubview(pop)
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
        
        let collectionViewPadding: CGFloat = 12
        NSLayoutConstraint.activate([
            featureCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 164),
            featureCollectionView.heightAnchor.constraint(equalToConstant: 217),
            featureCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: collectionViewPadding),
//            featureCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -collectionViewPadding),
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
        
    }
    
    func searchBarTextDidBeginEditing(_searchBar: UISearchBar) {
        
    }
    
    func searchBarTextDidEndEditing(_searchBar: UISearchBar) {
        
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
    
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 115, height: 115)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 200)
    }

    
    //present view controller
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        featureRecipes[indexPath.section][indexPath.item].isSelected.toggle()
//        if featureRecipes[indexPath.section][indexPath.item].isSelected {
//            let vc = PresentViewController(delegate: self, placeholderName: featureRecipes[indexPath.section][indexPath.item].name, placeholderIngredients: featureRecipes[indexPath.section][indexPath.item].ingredients, placeholderInstructions: featureRecipes[indexPath.section][indexPath.item].instructions)
//            self.present(vc, animated: true, completion: nil)
//        }
//        collectionView.reloadData()
//    }
    
}

class HomeViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate, UpdateIngredientsDelegate  {
    
    func updateInstructions(newString: String) {
        recipies[1][1].name = newString
    }
    
    func updateName(newString: String) {
        recipies[1][1].name = newString
    }
    
    
    func updateIngredients(newString: String) {
        recipies[1][1].ingredients = newString
    }
    
    
    var recipieCollectionView : UICollectionView!
    var featureCollectionView : UICollectionView!
    
    var featureSection = ["Featured"]
    var sections = ["Breakfast", "Lunch", "Dinner", "Snack"]
    var featureRecipes : [[Recipie]] = []
    var recipies : [[Recipie]] = [
        [Recipie(name: "Name: Baked Oatmeal", instructions: "Instructions: Preheat the oven to 375 degrees. Grease a 9-inch square baking dish. Once the oven has finished preheating, pour the nuts onto a rimmed baking sheet.Toast for 4 to 5 minutes, until fragrant. In a medium mixing bowl, combine the oats, toasted nuts, cinnamon, baking powder, salt and nutmeg. Whisk to combine. In a smaller mixing bowl, combine the milk, maple syrup or honey, egg, half of the butter or coconut oil, and vanilla. Whisk until blended. (If you used coconut oil and it solidified in contact with the cold ingredients, briefly microwave the bowl in 30 second increments, just until the coconut oil melts again.) Reserve about ½ cup of the berries for topping the baked oatmeal, then arrange the remaining berries evenly over the bottom of the baking dish (no need to defrost frozen fruit first). Cover the fruit with the dry oat mixture, then drizzle the wet ingredients over the oats. Wiggle the baking dish to make sure the milk moves down through the oats, then gently pat down any dry oats resting on top. Scatter the remaining berries across the top. Sprinkle some raw sugar on top if you’d like some extra sweetness and crunch. Bake for 42 to 45 minutes (if using frozen berries, 45 to 50 minutes), until the top is nice and golden. Remove your baked oatmeal from the oven and let it cool for a few minutes. Drizzle the remaining melted butter on the top before serving. Serve as-is or with toppings of your choice. I prefer this baked oatmeal served warm, but it is also good at room temperature or chilled. This oatmeal keeps well in the refrigerator, covered, for 4 to 5 days. If desired, simply reheat individual portions in the microwave before serving.", ingredients: "Ingredients: oats, milk, butter, sugar", cuisine: "Breakfast"),Recipie(name: "Baked Oatmeal", instructions: "Bake at 350 in oven 20 minutes ..", ingredients: "oats, milk, butter, sugar", cuisine: "Breakfast"), Recipie(name: "Baked Oatmeal", instructions: "Bake at 350 in oven 20 minutes ..", ingredients: "oats, milk, butter, sugar", cuisine: "Breakfast")  ],
        [ Recipie(name: "Fillet Chicken", instructions: "ajfhjerhuerhfjkbf gmdbfhjgberjgeq", ingredients: "jfkaglherguhg", cuisine:"Lunch"), Recipie(name: "Fillet Chicken", instructions: "ajfhjerhuerhfjkbf gmdbfhjgberjgeq", ingredients: "jfkaglherguhg", cuisine:"Lunch")],
        [ Recipie(name: "Lobster Tail", instructions: "Cook until medium brown", ingredients: "lobster, butter, pan, pot, eggs fun ...", cuisine: "Dinner"), Recipie(name: "Lobster Tail", instructions: "Cook until medium brown", ingredients: "lobster, butter, pan, pot, eggs fun ...", cuisine: "Dinner"), Recipie(name: "Lobster Tail", instructions: "Cook until medium brown", ingredients: "lobster, butter, pan, pot, eggs fun ...", cuisine: "Dinner")],
        [ Recipie(name: "Fillet Chicken", instructions: "ajfhjerhuerhfjkbf gmdbfhjgberjgeq", ingredients: "jfkaglherguhg", cuisine: "Snack"), Recipie(name: "Fillet Chicken", instructions: "ajfhjerhuerhfjkbf gmdbfhjgberjgeq", ingredients: "jfkaglherguhg", cuisine: "Snack"), Recipie(name: "Fillet Chicken", instructions: "ajfhjerhuerhfjkbf gmdbfhjgberjgeq", ingredients: "jfkaglherguhg", cuisine: "Snack")]]

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

        func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
            recipies[indexPath.section][indexPath.item].isSelected.toggle()
            if recipies[indexPath.section][indexPath.item].isSelected {
                let vc = PresentViewController(delegate: self, placeholderName: recipies[indexPath.section][indexPath.item].name, placeholderIngredients: recipies[indexPath.section][indexPath.item].ingredients, placeholderInstructions: recipies[indexPath.section][indexPath.item].instructions)
                self.present(vc, animated: true, completion: nil)
            }
            collectionView.reloadData()
        }

//    }
}






//present view controller

class PresentViewController: UIViewController {

    // TODO 8: set up delegate
    weak var delegate: UpdateIngredientsDelegate?

    private var button = UIButton()
    private var label = UILabel()
    private var ingredientsField = UITextField()
//    private var nameField = UITextField()
    private var instructionsField = UITextView()

    var placeholderIngredients: String?
    var placeholderName: String?
    var placeholderInstructions: String?

    // TODO 10: initialize placeholder text
    init(delegate: UpdateIngredientsDelegate?, placeholderName: String, placeholderIngredients: String, placeholderInstructions: String) {
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

        view.backgroundColor = .lightGray

        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = placeholderName
        label.font = UIFont.systemFont(ofSize: 18)
        label.textColor = .black
        view.addSubview(label)

        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Done", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = UIColor(red: 240/255, green: 240/255, blue: 240/255, alpha: 1)
        button.layer.cornerRadius = 4
        button.addTarget(self, action: #selector(dismissViewController), for: .touchUpInside)
        view.addSubview(button)

        ingredientsField.translatesAutoresizingMaskIntoConstraints = false
        ingredientsField.font = UIFont.systemFont(ofSize: 18)
        // TODO 10: set placeholder text
        ingredientsField.text = placeholderIngredients
        ingredientsField.borderStyle = .roundedRect
        ingredientsField.textAlignment = .center
        view.addSubview(ingredientsField)
        
        instructionsField.translatesAutoresizingMaskIntoConstraints = false
        instructionsField.font = UIFont.systemFont(ofSize: 18)
        // TODO 10: set placeholder text
        instructionsField.text = placeholderInstructions
        instructionsField.layer.cornerRadius = 4
//        instructionsField.layer
        instructionsField.textAlignment = .center
        view.addSubview(instructionsField)
        
//        nameField.translatesAutoresizingMaskIntoConstraints = false
//        nameField.font = UIFont.systemFont(ofSize: 18)
//        nameField.text = placeholderName
//        nameField.borderStyle = .roundedRect
//        nameField.textAlignment = .center
//        view.addSubview(nameField)

        setUpConstraints()
    }

    func setUpConstraints() {
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
            label.heightAnchor.constraint(equalToConstant: 32)
//            label.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
//            label.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
        ])

        
//        NSLayoutConstraint.activate([
//            nameField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//            nameField.centerYAnchor.constraint(equalTo: view.centerYAnchor),
//            nameField.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -24),
//            nameField.heightAnchor.constraint(equalToConstant: 32)
//        ])

        NSLayoutConstraint.activate([
            ingredientsField.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 20),
//            ingredientsField.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20),
            ingredientsField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            ingredientsField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
//            ingredientsField.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -24),
            ingredientsField.heightAnchor.constraint(equalToConstant: 32)
        ])
        
        NSLayoutConstraint.activate([
            instructionsField.topAnchor.constraint(equalTo: ingredientsField.bottomAnchor, constant: 20),
            instructionsField.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -60),
            instructionsField.leadingAnchor.constraint(equalTo: ingredientsField.leadingAnchor),
            instructionsField.trailingAnchor.constraint(equalTo: ingredientsField.trailingAnchor)
//            instructionsField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//            instructionsField.centerYAnchor.constraint(equalTo: view.centerYAnchor),
//            instructionsField.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -24),
//            instructionsField.heightAnchor.constraint(equalToConstant: 32)
        ])
        NSLayoutConstraint.activate([
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20),
            button.leadingAnchor.constraint(equalTo: ingredientsField.leadingAnchor),
            button.trailingAnchor.constraint(equalTo: ingredientsField.trailingAnchor)
//            button.widthAnchor.constraint(equalToConstant: 120),
//            button.heightAnchor.constraint(equalToConstant: 32)
        ])
        
    }

    @objc func dismissViewController() {
        // TODO 9: call delegate function
//        delegate?.updateTitle(newString: textField.text ?? "view controllers")
        // TODO 5: dismiss view controller
        dismiss(animated: true, completion: nil)
    }

}

