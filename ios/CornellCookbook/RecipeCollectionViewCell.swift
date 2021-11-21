//
//  RecipeCollectionViewCell.swift
//  CornellCookbook
//
//  Created by Kayla Sprayberry on 11/20/21.
//

import UIKit

class RecipeCollectionViewCell: UICollectionViewCell {
    private var recipieImageView = UIImageView()

    override init(frame: CGRect) {
        super.init(frame: frame)

        contentView.layer.cornerRadius = 8
        contentView.clipsToBounds = true
        contentView.backgroundColor = .red
//        contentView.border

        recipieImageView.contentMode = .center
        
        recipieImageView.layer.borderColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0).cgColor
//        recipieImageView.layer.border
        recipieImageView.layer.masksToBounds = true
//        recipieImageView.contentMode = .scaleToFill
        recipieImageView.layer.borderWidth = 5
        recipieImageView.clipsToBounds = true
//        recipieImageView.addTarget
        recipieImageView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(recipieImageView)

        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(for recipie: Recipie) {
       recipieImageView.image = recipie.getImage()
    }
    


    func setupConstraints() {
        NSLayoutConstraint.activate([
            recipieImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            recipieImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            recipieImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            recipieImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])
    }

}
