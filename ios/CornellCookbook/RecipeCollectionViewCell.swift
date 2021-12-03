//
//  RecipeCollectionViewCell.swift
//  CornellCookbook
//
//  Created by Kayla Sprayberry on 11/20/21.
//

import UIKit

class RecipeCollectionViewCell: UICollectionViewCell {
    private var recipieImageView = UIImageView()
    private var recipeName = UILabel()

    private var time = UILabel()
    private var cuisine = UILabel()
    private var difficulty = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)

//        contentView.leadingAnchor = superview?.leadingAnchor
//        contentView.clipsToBounds = true
//        contentView.backgroundColor = .red
        contentView.contentMode = .left
        contentView.translatesAutoresizingMaskIntoConstraints = false

        recipieImageView.layer.borderColor = UIColor(red: 0.69, green: 0.082, blue: 0.192, alpha: 1).cgColor
//        recipieImageView.layer.masksToBounds = true
        recipieImageView.clipsToBounds = true
        recipieImageView.translatesAutoresizingMaskIntoConstraints = false
        recipieImageView.layer.cornerRadius = 8
        recipieImageView.layer.borderWidth = 1

        recipeName.text = "Cereal"
        recipeName.font = UIFont(name: "Galvji", size: 12)
        recipeName.translatesAutoresizingMaskIntoConstraints = false

        time.text = "5 min"
        time.textAlignment = .center
        time.font = UIFont(name: "Galvji", size: 8)
        time.layer.cornerRadius = 9
        time.layer.backgroundColor = UIColor(red: 0.942, green: 0.657, blue: 0.451, alpha: 1).cgColor
        time.translatesAutoresizingMaskIntoConstraints = false

        cuisine.text = "American"
        cuisine.font = UIFont(name: "Galvji", size: 8)
        cuisine.layer.cornerRadius = 9
        cuisine.layer.backgroundColor = UIColor(red: 0.942, green: 0.657, blue: 0.451, alpha: 1).cgColor
        cuisine.textAlignment = .center
        cuisine.translatesAutoresizingMaskIntoConstraints = false

        difficulty.text = "Beginner"
        difficulty.textAlignment = .center
        difficulty.layer.cornerRadius = 9
        difficulty.layer.backgroundColor = UIColor(red: 0.942, green: 0.657, blue: 0.451, alpha: 1).cgColor
        difficulty.font = UIFont(name: "Galvji", size: 8)
        difficulty.translatesAutoresizingMaskIntoConstraints = false

        contentView.addSubview(recipieImageView)
        contentView.addSubview(recipeName)

        contentView.addSubview(difficulty)
        contentView.addSubview(cuisine)
        contentView.addSubview(time)

        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(for recipie: Recipie) {
        recipieImageView.image = UIImage(named: "\(recipie.mealType) 1")
        difficulty.text = recipie.difficulty
        cuisine.text = recipie.cuisine
        time.text = "\(String(recipie.time)) min"
        recipeName.text = recipie.name
    }



    func setupConstraints() {
        NSLayoutConstraint.activate([
            recipieImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            recipieImageView.heightAnchor.constraint(equalToConstant: 140),
            recipieImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            recipieImageView.widthAnchor.constraint(equalToConstant: 140),
        ])

        NSLayoutConstraint.activate([
            recipeName.topAnchor.constraint(equalTo: recipieImageView.bottomAnchor),
            recipeName.heightAnchor.constraint(equalToConstant: 17),
            recipeName.centerXAnchor.constraint(equalTo: recipieImageView.centerXAnchor)
        ])
        NSLayoutConstraint.activate([
            time.topAnchor.constraint(equalTo: recipeName.bottomAnchor, constant: 2),
            time.heightAnchor.constraint(equalToConstant: 17),
            time.centerXAnchor.constraint(equalTo: recipieImageView.centerXAnchor, constant: 32),
            time.widthAnchor.constraint(equalToConstant: 48),
//            time.leadingAnchor.constraint(equalTo: contentView.leadingAnchor)
        ])
        NSLayoutConstraint.activate([
            difficulty.topAnchor.constraint(equalTo: recipeName.bottomAnchor, constant: 2),
            difficulty.heightAnchor.constraint(equalToConstant: 17),
            difficulty.widthAnchor.constraint(equalToConstant: 48),
//            difficulty.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -17)
            difficulty.centerXAnchor.constraint(equalTo: recipieImageView.centerXAnchor, constant: -32)
        ])
        NSLayoutConstraint.activate([
            cuisine.topAnchor.constraint(equalTo: time.bottomAnchor, constant: 2),
            cuisine.heightAnchor.constraint(equalToConstant: 17),
            cuisine.widthAnchor.constraint(equalToConstant: 48),
            cuisine.centerXAnchor.constraint(equalTo: recipieImageView.centerXAnchor)
        ])

    }

}
