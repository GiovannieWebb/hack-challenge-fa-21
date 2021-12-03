//
//  MethodTableViewCell.swift
//  CornellCookbook
//
//  Created by Kayla Sprayberry on 12/3/21.
//

import UIKit

class MethodTableViewCell: UITableViewCell {

    var stepLabel = UILabel()
    var amountLabel = UILabel()
//    var coverImageView = UIImageView()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        
        stepLabel.font =  UIFont(name: "Galvji", size: 15)
        stepLabel.textColor = .black
        stepLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(stepLabel)
        
        amountLabel.font =  UIFont(name: "Galvji", size: 15)
        amountLabel.textColor = .black
        amountLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(amountLabel)

        setupConstraints()
    }

    func configure(instruction: Instructions) {
//        nameLabel.text =  instruction.name
        stepLabel.text =  instruction.step
        amountLabel.text = String(instruction.stepNumber)
    }

    func setupConstraints() {
        let padding: CGFloat = 9
        let labelHeight: CGFloat = 25

        NSLayoutConstraint.activate([
            amountLabel.leadingAnchor.constraint(equalTo:contentView.leadingAnchor, constant: padding),
            amountLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            amountLabel.heightAnchor.constraint(equalToConstant: labelHeight)
        ])
        NSLayoutConstraint.activate([
            stepLabel.leadingAnchor.constraint(equalTo: amountLabel.trailingAnchor, constant: padding),
            stepLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            stepLabel.heightAnchor.constraint(equalToConstant: labelHeight)
        ])
    }


    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
