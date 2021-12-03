//
//  IngredientTableViewCell.swift
//  CornellCookbook
//
//  Created by Kayla Sprayberry on 12/2/21.
//

import UIKit

class IngredientTableViewCell: UITableViewCell {

    var nameLabel = UILabel()
    var unitLabel = UILabel()
    var amountLabel = UILabel()
    var coverImageView = UIImageView()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        nameLabel.font = UIFont(name: "Galvji", size: 15)
        nameLabel.textColor = .black
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(nameLabel)
        
        unitLabel.font = UIFont(name: "Galvji", size: 15)
        unitLabel.textColor = .black
        unitLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(unitLabel)
        
        amountLabel.font = UIFont(name: "Galvji", size: 15)
        amountLabel.textColor = .black
        amountLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(amountLabel)


        coverImageView.contentMode = .scaleAspectFit
        coverImageView.image = UIImage(named: "check")
        coverImageView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(coverImageView)

        setupConstraints()
    }

    func configure(ingredient: Ingredients) {
        nameLabel.text =  ingredient.name
//        print(nameLabel.text)
        unitLabel.text =  ingredient.unit
        amountLabel.text = String(ingredient.amount)
    }

    func setupConstraints() {
        let padding: CGFloat = 9
        let labelHeight: CGFloat = 20

        NSLayoutConstraint.activate([
            coverImageView.heightAnchor.constraint(equalToConstant: 20),
            coverImageView.widthAnchor.constraint(equalToConstant: 20),
            coverImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            coverImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding)
        ])
//
        NSLayoutConstraint.activate([
            nameLabel.leadingAnchor.constraint(equalTo: coverImageView.trailingAnchor, constant: padding),
            nameLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            nameLabel.heightAnchor.constraint(equalToConstant: labelHeight)
        ])
//
        NSLayoutConstraint.activate([
            amountLabel.leadingAnchor.constraint(equalTo: nameLabel.trailingAnchor, constant: padding),
            amountLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            amountLabel.heightAnchor.constraint(equalToConstant: labelHeight)
        ])
//
        NSLayoutConstraint.activate([
            unitLabel.leadingAnchor.constraint(equalTo: amountLabel.trailingAnchor, constant: padding),
            unitLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            unitLabel.heightAnchor.constraint(equalToConstant: labelHeight)
        ])
    }


    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
