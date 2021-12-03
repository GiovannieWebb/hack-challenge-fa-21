//
//  PhotoCollectionViewCell.swift
//  CornellCookbook
//
//  Created by Kayla Sprayberry on 12/2/21.
//

import UIKit

class PhotoCollectionViewCell: UICollectionViewCell {
    private var photoImageView = UIImageView()

    override init(frame: CGRect) {
        super.init(frame: frame)

        contentView.layer.cornerRadius = 8
        contentView.clipsToBounds = true
        contentView.backgroundColor = .lightGray
        contentView.contentMode = .left
//        contentView.translatesAutoresizingMaskIntoConstraints = false
//        contentView.border

        photoImageView.contentMode = .left
        
        photoImageView.layer.borderColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0).cgColor
//        recipieImageView.layer.border
        photoImageView.layer.masksToBounds = true
//        recipieImageView.contentMode = .scaleToFill
        photoImageView.layer.borderWidth = 5
        photoImageView.clipsToBounds = true
//        recipieImageView.addTarget
        photoImageView.translatesAutoresizingMaskIntoConstraints = false
        

        contentView.addSubview(photoImageView)

        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(for photo: UIImageView) {
        photoImageView.image = photo.image
    }

    func setupConstraints() {
        NSLayoutConstraint.activate([
            photoImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
//            recipieImageView.heightAnchor.constraint(equalTo: contentView.),
            photoImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            photoImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            photoImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])
        
    }
}
