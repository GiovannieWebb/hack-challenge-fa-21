//
//  PresentViewController.swift
//  CornellCookbook
//
//  Created by Kayla Sprayberry on 11/21/21.
//

import UIKit

class PresentViewController: UIViewController {

    // TODO 8: set up delegate
    weak var delegate: UpdateTitleDelegate?

    private var button = UIButton()
    private var label = UILabel()
    private var textField = UITextField()

    var placeholderText: String?

    // TODO 10: initialize placeholder text
    init(delegate: UpdateTitleDelegate?, placeholderText: String) {
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
        delegate?.updateTitle(newString: textField.text ?? "view controllers")
        // TODO 5: dismiss view controller
        dismiss(animated: true, completion: nil)
    }

}

