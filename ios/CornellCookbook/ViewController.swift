//
//  ViewController.swift
//  CornellCookbook
//
//  Created by Kayla Sprayberry on 11/18/21.
//

import UIKit

protocol UpdateIngredientsDelegate: class {
    func updateIngredients(newString: String)
}

class ViewController: UIViewController {
    
//    var homeView = HomeViewController()
    
    private let button: UIButton = {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 200, height: 52))
        button.setTitle("Log in", for: .normal)
        button.layer.borderWidth = 5
        button.layer.cornerRadius = 8
        button.layer.borderColor = CGColor(red: 1.0, green: 0.36, blue: 0.01, alpha: 1.0)
        button.backgroundColor = .white
        button.setTitleColor(.black, for: .normal)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
        button.backgroundColor = .lightGray
        let tabBarVC = UITabBarController()
//        let vc2 = SecondViewController()
        let vc1 = HomeViewController()
        let vc2 = SecondViewController()
        tabBarVC.setViewControllers([vc1, vc2], animated: false)
        tabBarVC.modalPresentationStyle = .fullScreen
        
        present(tabBarVC, animated: true)
    }

}
class SecondViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .yellow
        title = "Profile"
    }
}


class HomeViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate, UpdateIngredientsDelegate  {
    
    func updateIngredients(newString: String) {
        recipies[1][1].ingredients = newString
    }
    
    
    var recipieCollectionView : UICollectionView!
    
    var sections = ["Breakfast", "Lunch", "Dinner", "Snack"]
    var recipies : [[Recipie]] = [
        [Recipie(name: "Baked Oatmeal", instructions: "Bake at 350 in oven 20 minutes ..", ingredients: "oats, milk, butter, sugar", cuisine: "Breakfast"),Recipie(name: "Baked Oatmeal", instructions: "Bake at 350 in oven 20 minutes ..", ingredients: "oats, milk, butter, sugar", cuisine: "Breakfast"), Recipie(name: "Baked Oatmeal", instructions: "Bake at 350 in oven 20 minutes ..", ingredients: "oats, milk, butter, sugar", cuisine: "Breakfast")  ],
        [ Recipie(name: "Fillet Chicken", instructions: "ajfhjerhuerhfjkbf gmdbfhjgberjgeq", ingredients: "jfkaglherguhg", cuisine:"Lunch"), Recipie(name: "Fillet Chicken", instructions: "ajfhjerhuerhfjkbf gmdbfhjgberjgeq", ingredients: "jfkaglherguhg", cuisine:"Lunch")],
        [ Recipie(name: "Lobster Tail", instructions: "Cook until medium brown", ingredients: "lobster, butter, pan, pot, eggs fun ...", cuisine: "Dinner"), Recipie(name: "Lobster Tail", instructions: "Cook until medium brown", ingredients: "lobster, butter, pan, pot, eggs fun ...", cuisine: "Dinner"), Recipie(name: "Lobster Tail", instructions: "Cook until medium brown", ingredients: "lobster, butter, pan, pot, eggs fun ...", cuisine: "Dinner")],
        [ Recipie(name: "Fillet Chicken", instructions: "ajfhjerhuerhfjkbf gmdbfhjgberjgeq", ingredients: "jfkaglherguhg", cuisine: "Snack"), Recipie(name: "Fillet Chicken", instructions: "ajfhjerhuerhfjkbf gmdbfhjgberjgeq", ingredients: "jfkaglherguhg", cuisine: "Snack"), Recipie(name: "Fillet Chicken", instructions: "ajfhjerhuerhfjkbf gmdbfhjgberjgeq", ingredients: "jfkaglherguhg", cuisine: "Snack")]]

    let recipieCellReuseIdentifier = "recipieCellReuseIdentifier"
    let headerReuseIdentifier = "headerReuseIdentifer"
    let cellPadding: CGFloat = 10
    let sectionPadding: CGFloat = 5
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Home"
        // .orange
        view.backgroundColor = .systemTeal
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
            return CGSize(width: size, height: size)
        }

        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
            return CGSize(width: collectionView.frame.width, height: 50)
        }

        func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
            recipies[indexPath.section][indexPath.item].isSelected.toggle()
            if recipies[indexPath.section][indexPath.item].isSelected {
                let vc = PresentViewController(delegate: self, placeholderText: recipies[indexPath.section][indexPath.item].ingredients)
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
    private var textField = UITextField()

    var placeholderText: String?

    // TODO 10: initialize placeholder text
    init(delegate: UpdateIngredientsDelegate?, placeholderText: String) {
        self.delegate = delegate
        self.placeholderText = placeholderText
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white

        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Recipie"
        label.font = UIFont.systemFont(ofSize: 18)
        label.textColor = .black
        view.addSubview(label)

        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Save", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = UIColor(red: 240/255, green: 240/255, blue: 240/255, alpha: 1)
        button.layer.cornerRadius = 4
        button.addTarget(self, action: #selector(dismissViewController), for: .touchUpInside)
        view.addSubview(button)

        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.font = UIFont.systemFont(ofSize: 18)
        // TODO 10: set placeholder text
        textField.text = placeholderText
        textField.borderStyle = .roundedRect
        textField.textAlignment = .center
        view.addSubview(textField)

        setUpConstraints()
    }

    func setUpConstraints() {
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.topAnchor.constraint(equalTo: view.topAnchor, constant: 24)
        ])

        NSLayoutConstraint.activate([
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -12),
            button.widthAnchor.constraint(equalToConstant: 120),
            button.heightAnchor.constraint(equalToConstant: 32)
        ])

        NSLayoutConstraint.activate([
            textField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            textField.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            textField.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -24),
            textField.heightAnchor.constraint(equalToConstant: 32)
        ])
    }

    @objc func dismissViewController() {
        // TODO 9: call delegate function
//        delegate?.updateTitle(newString: textField.text ?? "view controllers")
        // TODO 5: dismiss view controller
        dismiss(animated: true, completion: nil)
    }

}

