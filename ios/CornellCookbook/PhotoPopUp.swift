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
    
    var Av1 = UIButton()
    var Av2 = UIButton()
    var Av3 = UIButton()
    var Av4 = UIButton()
    var Av5 = UIButton()
    var Av6 = UIButton()
    var Av7 = UIButton()
    var Av8 = UIButton()
    
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
        Av1.setImage(UIImage(named: "Avatar 1"), for: .normal)
        Av1.addTarget(self, action: #selector(Av1Pressed), for: .touchUpInside)
        view.addSubview(Av1)
        
        //2
        Av2.translatesAutoresizingMaskIntoConstraints = false
        Av2.layer.cornerRadius = 40
        Av2.setImage(UIImage(named: "Avatar 2"), for: .normal)
        Av2.addTarget(self, action: #selector(Av2Pressed), for: .touchUpInside)
        view.addSubview(Av2)
        
        //3
        Av3.translatesAutoresizingMaskIntoConstraints = false
        Av3.layer.cornerRadius = 40
        Av3.setImage(UIImage(named: "Avatar 3"), for: .normal)
        Av3.addTarget(self, action: #selector(Av3Pressed), for: .touchUpInside)
        view.addSubview(Av3)
        
        //4
        Av4.translatesAutoresizingMaskIntoConstraints = false
        Av4.layer.cornerRadius = 40
        Av4.setImage(UIImage(named: "Avatar 4"), for: .normal)
        Av4.addTarget(self, action: #selector(Av4Pressed), for: .touchUpInside)
        view.addSubview(Av4)
        
        //5
        Av5.translatesAutoresizingMaskIntoConstraints = false
        Av5.layer.cornerRadius = 40
        Av5.setImage(UIImage(named: "Avatar 5"), for: .normal)
        Av5.addTarget(self, action: #selector(Av5Pressed), for: .touchUpInside)
        view.addSubview(Av5)
        
        
        Av6.translatesAutoresizingMaskIntoConstraints = false
        Av6.layer.cornerRadius = 40
        Av6.setImage(UIImage(named: "Avatar 6"), for: .normal)
        Av6.addTarget(self, action: #selector(Av6Pressed), for: .touchUpInside)
        view.addSubview(Av6)
        
        Av7.translatesAutoresizingMaskIntoConstraints = false
        Av7.layer.cornerRadius = 40
        Av7.setImage(UIImage(named: "Avatar 8"), for: .normal)
        Av7.addTarget(self, action: #selector(Av5Pressed), for: .touchUpInside)
        view.addSubview(Av7)
        
        
        Av8.translatesAutoresizingMaskIntoConstraints = false
        Av8.layer.cornerRadius = 40
        Av8.setImage(UIImage(named: "Avatar 7"), for: .normal)
        Av8.addTarget(self, action: #selector(Av6Pressed), for: .touchUpInside)
        view.addSubview(Av8)
        
        
//        save.setImage(UIImage(named: "save"), for: .normal)
//        save.translatesAutoresizingMaskIntoConstraints = false
//        save.addTarget(self, action: #selector(savePressed), for: .touchUpInside)
//        view.addSubview(save)
        
//        view.addSubview(photoCollectionView)
        
        setupConstraints()
    }
    
    func setupConstraints() {
//        let collectionViewPadding: CGFloat = 512
//        NSLayoutConstraint.activate([
//            photoCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: collectionViewPadding),
//            photoCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: collectionViewPadding),
//            photoCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -collectionViewPadding),
//            photoCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -collectionViewPadding)
//        ])
        
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
        //av6
        NSLayoutConstraint.activate([
            Av8.centerXAnchor.constraint(equalTo: view.rightAnchor, constant: -96.5),
            Av8.centerYAnchor.constraint(equalTo: Av5.centerYAnchor, constant: 181),
            Av8.widthAnchor.constraint(equalToConstant: 145),
            Av8.heightAnchor.constraint(equalToConstant: 145)
        ])
        
//        NSLayoutConstraint.activate([
////            save.centerXAnchor.constraint(equalTo: view.rightAnchor, constant: -96.5),
//            save.topAnchor.constraint(equalTo: view.topAnchor, constant: 40),
////            save.centerYAnchor.constraint(equalTo: Av5.centerYAnchor, constant: 181),
//            save.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
//            save.widthAnchor.constraint(equalToConstant: 30),
//            save.heightAnchor.constraint(equalToConstant: 20)
//        ])
    }
    
    @objc func Av1Pressed() {
//        profileImage.image = UIImage(named: "image1")
    }
    
    @objc func Av2Pressed() {
//        profileImage.image = UIImage(named: "image2")
    }
    @objc func Av3Pressed() {
//        profileImage.image = UIImage(named: "image3")
    }
    
    @objc func Av4Pressed() {
//        profileImage.image = UIImage(named: "image4")
    }
    @objc func Av5Pressed() {
//        profileImage.image = UIImage(named: "image5")
    }
    @objc func Av6Pressed() {
//        profileImage.image = UIImage(named: "image6")
    }

    @objc func savePressed() {
//        profileImage.image = UIImage(named: "image6")
        navigationController?.popViewController(animated: true)
//        dismiss(animated: true, completion: nil)
    }
}
