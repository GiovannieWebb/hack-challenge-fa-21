//
//  PhotoPopUp.swift
//  CornellCookbook
//
//  Created by Kayla Sprayberry on 12/2/21.
//

import UIKit

class PhotoPopUp: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos[section].count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: photoReuseIdentifier, for: indexPath) as! PhotoCollectionViewCell
        let photo = photos[indexPath.section][indexPath.item]
        cell.configure(for: photo)
        return cell
    }

//    weak var delegateImage: UpdateImageDelegate?
    
    private var button = UIButton()
    //title
    private var label = UILabel()
    var savedImage = UIImageView()
    
    var Av1 = UIButton()
    var Av2 = UIButton()
    var Av3 = UIButton()
    var Av4 = UIButton()
    var Av5 = UIButton()
    var Av6 = UIButton()
    var Av7 = UIButton()
    var Av8 = UIButton()
    
//    var save = UIButton()
    
    var save = UIBarButtonItem(image: UIImage(named: "save"), style: .plain, target: self, action: #selector(savePressed))
    
//    save.image = UIImage(named: "save")
//    save.target = self
//    save.action = #selector(savePressed)
//    save.style = .plain
//    navigationController?.navigationItem.rightBarButtonItem = save
    
    var photoCollectionView: UICollectionView!
    var section = ["Photos"]
    var photos: [[UIImageView]] = [[UIImageView(image: UIImage(named: "home")), UIImageView(image: UIImage(named: "home")), UIImageView(image: UIImage(named: "home"))]]
    
    let photoReuseIdentifier = "photoReuseIdentifer"
    let cellPadding: CGFloat = 10
    let sectionPadding: CGFloat = 5

    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = save
        title = "Choose Photo"
        view.backgroundColor = .white
        
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = cellPadding
        layout.minimumInteritemSpacing = cellPadding
        layout.scrollDirection = .vertical
        
        photoCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        photoCollectionView.translatesAutoresizingMaskIntoConstraints = false
        photoCollectionView.backgroundColor = .clear
        
        
        photoCollectionView.register(PhotoCollectionViewCell.self, forCellWithReuseIdentifier: photoReuseIdentifier)
        photoCollectionView.dataSource = self
        photoCollectionView.delegate = self
        
        
        Av1.translatesAutoresizingMaskIntoConstraints = false
        Av1.layer.cornerRadius = 40
        Av1.setImage(UIImage(named: "Breakfast 1"), for: .normal)
        Av1.addTarget(self, action: #selector(Av1Pressed), for: .touchUpInside)
        view.addSubview(Av1)
        
        //2
        Av2.translatesAutoresizingMaskIntoConstraints = false
        Av2.layer.cornerRadius = 40
        Av2.setImage(UIImage(named: "Breakfast 2"), for: .normal)
        Av2.addTarget(self, action: #selector(Av2Pressed), for: .touchUpInside)
        view.addSubview(Av2)
        
        //3
        Av3.translatesAutoresizingMaskIntoConstraints = false
        Av3.layer.cornerRadius = 40
        Av3.setImage(UIImage(named: "Lunch 1"), for: .normal)
        Av3.addTarget(self, action: #selector(Av3Pressed), for: .touchUpInside)
        view.addSubview(Av3)
        savedImage.image = UIImage(named: "Breakfast 1")
        //4
        Av4.translatesAutoresizingMaskIntoConstraints = false
        Av4.layer.cornerRadius = 40
        Av4.setImage(UIImage(named: "Lunch 2"), for: .normal)
        Av4.addTarget(self, action: #selector(Av4Pressed), for: .touchUpInside)
        view.addSubview(Av4)
        
        //5
        Av5.translatesAutoresizingMaskIntoConstraints = false
        Av5.layer.cornerRadius = 40
        Av5.setImage(UIImage(named: "Dinner 1"), for: .normal)
        Av5.addTarget(self, action: #selector(Av5Pressed), for: .touchUpInside)
        view.addSubview(Av5)
        
        
        Av6.translatesAutoresizingMaskIntoConstraints = false
        Av6.layer.cornerRadius = 40
        Av6.setImage(UIImage(named: "Dinner 2"), for: .normal)
        Av6.addTarget(self, action: #selector(Av6Pressed), for: .touchUpInside)
        view.addSubview(Av6)
        
        Av7.translatesAutoresizingMaskIntoConstraints = false
        Av7.layer.cornerRadius = 40
        Av7.setImage(UIImage(named: "Avatar 8"), for: .normal)
        Av7.addTarget(self, action: #selector(Av7Pressed), for: .touchUpInside)
        view.addSubview(Av7)
        
        
        Av8.translatesAutoresizingMaskIntoConstraints = false
        Av8.layer.cornerRadius = 40
        Av8.setImage(UIImage(named: "Avatar 7"), for: .normal)
        Av8.addTarget(self, action: #selector(Av8Pressed), for: .touchUpInside)
        view.addSubview(Av8)
        
        
//        save.setImage(UIImage(named: "save"), for: .normal)
//        save.translatesAutoresizingMaskIntoConstraints = false
//        save.addTarget(self, action: #selector(savePressed), for: .touchUpInside)
        
        
        view.addSubview(photoCollectionView)
//        view.addSubview(save)
        setupConstraints()
    }
    
    func setupConstraints() {
        
        NSLayoutConstraint.activate([
            Av1.centerXAnchor.constraint(equalTo: view.leftAnchor, constant: 96.5),
//            Av1.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 50),
            Av1.topAnchor.constraint(equalTo: view.topAnchor, constant: 111),
            Av1.widthAnchor.constraint(equalToConstant: 145),
            Av1.heightAnchor.constraint(equalToConstant: 145)
        ])
        //av2
        NSLayoutConstraint.activate([
            Av2.centerXAnchor.constraint(equalTo: view.rightAnchor, constant: -96.5),
            Av2.topAnchor.constraint(equalTo: view.topAnchor, constant: 111),
//            Av2.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 181),
            Av2.widthAnchor.constraint(equalToConstant: 145),
            Av2.heightAnchor.constraint(equalToConstant: 145)
        ])
        
        //av3
        NSLayoutConstraint.activate([
            Av3.centerXAnchor.constraint(equalTo: view.leftAnchor, constant: 96.5),
            Av3.centerYAnchor.constraint(equalTo: Av1.centerYAnchor, constant: 181),
            Av3.widthAnchor.constraint(equalToConstant: 145),
            Av3.heightAnchor.constraint(equalToConstant: 145)
        ])
        //av4
        NSLayoutConstraint.activate([
            Av4.centerXAnchor.constraint(equalTo: view.rightAnchor, constant: -96.5),
            Av4.centerYAnchor.constraint(equalTo: Av1.centerYAnchor, constant: 181),
            Av4.widthAnchor.constraint(equalToConstant: 145),
            Av4.heightAnchor.constraint(equalToConstant: 145)
        ])
        
        //av5
        NSLayoutConstraint.activate([
            Av5.centerXAnchor.constraint(equalTo: view.leftAnchor, constant: 96.5),
            Av5.centerYAnchor.constraint(equalTo: Av3.centerYAnchor, constant: 181),
            Av5.widthAnchor.constraint(equalToConstant: 145),
            Av5.heightAnchor.constraint(equalToConstant: 145)
        ])
        //av6
        NSLayoutConstraint.activate([
            Av6.centerXAnchor.constraint(equalTo: view.rightAnchor, constant: -96.5),
            Av6.centerYAnchor.constraint(equalTo: Av3.centerYAnchor, constant: 181),
            Av6.widthAnchor.constraint(equalToConstant: 145),
            Av6.heightAnchor.constraint(equalToConstant: 145)
        ])
        
        NSLayoutConstraint.activate([
            Av7.centerXAnchor.constraint(equalTo: view.leftAnchor, constant: 96.5),
            Av7.centerYAnchor.constraint(equalTo: Av5.centerYAnchor, constant: 181),
            Av7.widthAnchor.constraint(equalToConstant: 145),
            Av7.heightAnchor.constraint(equalToConstant: 145)
        ])

        NSLayoutConstraint.activate([
            Av8.centerXAnchor.constraint(equalTo: view.rightAnchor, constant: -96.5),
            Av8.centerYAnchor.constraint(equalTo: Av5.centerYAnchor, constant: 181),
            Av8.widthAnchor.constraint(equalToConstant: 145),
            Av8.heightAnchor.constraint(equalToConstant: 145)
        ])
        
//        NSLayoutConstraint.activate([
//            save.topAnchor.constraint(equalTo: view.topAnchor, constant: 60),
//            save.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
//            save.widthAnchor.constraint(equalToConstant: 30),
//            save.heightAnchor.constraint(equalToConstant: 20)
//        ])
    }
    
    @objc func Av1Pressed() {
        Av1.layer.borderWidth = 1
        Av2.layer.borderWidth = 0
        Av3.layer.borderWidth = 0
        Av4.layer.borderWidth = 0
        Av5.layer.borderWidth = 0
        Av6.layer.borderWidth = 0
        Av7.layer.borderWidth = 0
        Av8.layer.borderWidth = 0
        Av1.layer.borderColor = UIColor(red: 0.69, green: 0.082, blue: 0.192, alpha: 1).cgColor
        savedImage.image = Av1.image(for: .normal)
    }
    
    @objc func Av2Pressed() {
        Av1.layer.borderWidth = 0
        Av2.layer.borderWidth = 1
        Av3.layer.borderWidth = 0
        Av4.layer.borderWidth = 0
        Av5.layer.borderWidth = 0
        Av6.layer.borderWidth = 0
        Av7.layer.borderWidth = 0
        Av8.layer.borderWidth = 0
        Av2.layer.borderColor = UIColor(red: 0.69, green: 0.082, blue: 0.192, alpha: 1).cgColor
        savedImage.image = Av2.image(for: .normal)
    }
    @objc func Av3Pressed() {
        Av1.layer.borderWidth = 0
        Av2.layer.borderWidth = 0
        Av3.layer.borderWidth = 1
        Av4.layer.borderWidth = 0
        Av5.layer.borderWidth = 0
        Av6.layer.borderWidth = 0
        Av7.layer.borderWidth = 0
        Av8.layer.borderWidth = 0
        Av3.layer.borderColor = UIColor(red: 0.69, green: 0.082, blue: 0.192, alpha: 1).cgColor
        savedImage.image = Av3.image(for: .normal)
    }
    
    @objc func Av4Pressed() {
        Av1.layer.borderWidth = 0
        Av2.layer.borderWidth = 0
        Av3.layer.borderWidth = 0
        Av4.layer.borderWidth = 1
        Av5.layer.borderWidth = 0
        Av6.layer.borderWidth = 0
        Av7.layer.borderWidth = 0
        Av8.layer.borderWidth = 0
        Av4.layer.borderColor = UIColor(red: 0.69, green: 0.082, blue: 0.192, alpha: 1).cgColor
        savedImage.image = Av4.image(for: .normal)
    }
    @objc func Av5Pressed() {
        Av1.layer.borderWidth = 0
        Av2.layer.borderWidth = 0
        Av3.layer.borderWidth = 0
        Av4.layer.borderWidth = 0
        Av5.layer.borderWidth = 1
        Av6.layer.borderWidth = 0
        Av7.layer.borderWidth = 0
        Av8.layer.borderWidth = 0
        Av5.layer.borderColor = UIColor(red: 0.69, green: 0.082, blue: 0.192, alpha: 1).cgColor
        savedImage.image = Av5.image(for: .normal)
    }
    @objc func Av6Pressed() {
        Av1.layer.borderWidth = 0
        Av2.layer.borderWidth = 0
        Av3.layer.borderWidth = 0
        Av4.layer.borderWidth = 0
        Av5.layer.borderWidth = 0
        Av6.layer.borderWidth = 1
        Av7.layer.borderWidth = 0
        Av8.layer.borderWidth = 0
        Av6.layer.borderColor = UIColor(red: 0.69, green: 0.082, blue: 0.192, alpha: 1).cgColor
        savedImage.image = Av6.image(for: .normal)
    }
    
    @objc func Av7Pressed() {
        Av1.layer.borderWidth = 0
        Av2.layer.borderWidth = 0
        Av3.layer.borderWidth = 0
        Av4.layer.borderWidth = 0
        Av5.layer.borderWidth = 0
        Av6.layer.borderWidth = 0
        Av7.layer.borderWidth = 1
        Av8.layer.borderWidth = 0
        Av7.layer.borderColor = UIColor(red: 0.69, green: 0.082, blue: 0.192, alpha: 1).cgColor
        savedImage.image = Av7.image(for: .normal)}
    
    @objc func Av8Pressed() {
        Av1.layer.borderWidth = 0
        Av2.layer.borderWidth = 0
        Av3.layer.borderWidth = 0
        Av4.layer.borderWidth = 0
        Av5.layer.borderWidth = 0
        Av6.layer.borderWidth = 0
        Av7.layer.borderWidth = 0
        Av8.layer.borderWidth = 1
        Av8.layer.borderColor = UIColor(red: 0.69, green: 0.082, blue: 0.192, alpha: 1).cgColor
        savedImage.image = Av8.image(for: .normal)
    }

    @objc func savePressed() {
//        print(1)
//        profileImage.image = UIImage(named: "image6")
        
        navigationController?.popViewController(animated: true)
//        dismiss(animated: true, completion: nil)
    }
}
