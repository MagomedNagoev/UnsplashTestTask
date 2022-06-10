//
//  FavoriteViewController.swift
//  UnsplashTestTask
//
//  Created by Нагоев Магомед on 07.06.2022.
//

import UIKit

class FavoriteViewController: UICollectionViewController {
    
    var presenter: FavoritePresenter?
    
    private let enterSearchTermLabel: UILabel = {
        let label = UILabel()
        label.text = "You haven't added pictures yet"
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.backgroundColor = .white
        collectionView.register(FavoriteCollectionViewCell.self, forCellWithReuseIdentifier: FavoriteCollectionViewCell.reuseId)
        collectionView.contentInset = UIEdgeInsets(top: 2, left: 2, bottom: 2, right: 2)
        
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.minimumInteritemSpacing = 2
        layout.minimumLineSpacing = 2
        
        setupEnterLabel()
        setupNavigationBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        collectionView.reloadData()
    }
    
    // MARK: - Setup UI Elements
    
    private func setupEnterLabel() {
        collectionView.addSubview(enterSearchTermLabel)
        enterSearchTermLabel.centerXAnchor.constraint(equalTo: collectionView.centerXAnchor).isActive = true
        enterSearchTermLabel.topAnchor.constraint(equalTo: collectionView.topAnchor, constant: 50).isActive = true
    }
    
    private func setupNavigationBar() {
        let titleLabel = UILabel(text: "Favorite pictures", font: .systemFont(ofSize: 15, weight: .medium), textColor: #colorLiteral(red: 0.5, green: 0.5, blue: 0.5, alpha: 1))
        navigationItem.leftBarButtonItem = UIBarButtonItem.init(customView: titleLabel)
    }
    
    // MARK: - UICollectionViewDataSource
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let photoCount = presenter?.getPictures()?.count
        enterSearchTermLabel.isHidden = photoCount != 0
        return photoCount ?? 0
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FavoriteCollectionViewCell.reuseId, for: indexPath) as! FavoriteCollectionViewCell
        
        let unsplashPhoto = presenter?.getPictures()?[indexPath.item]
        
        cell.myImageView.image = UIImage(data: unsplashPhoto!.photoData!)
        if let data = unsplashPhoto?.avatarImage,
           let image = UIImage(data: data) {
          cell.avatarImageView.image = image
        }
        
        cell.nameLabel.text = unsplashPhoto?.authorName
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let unsplashPhoto = presenter?.getPictures()?[indexPath.item] else {
            return
        }
        presenter?.tapOntheFavoritePhoto(favoritePhoto: unsplashPhoto)
    }
}

    // MARK: - UICollectionViewDelegateFlowLayout
extension FavoriteViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width
        return CGSize(width: width/2 - 3, height: width/2 - 3)
    }
}
