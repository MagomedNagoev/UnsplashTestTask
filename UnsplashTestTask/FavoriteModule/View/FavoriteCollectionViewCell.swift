//
//  FavoriteCollectionViewCell.swift
//  UnsplashTestTask
//
//  Created by Нагоев Магомед on 08.06.2022.
//

import UIKit

class FavoriteCollectionViewCell: UICollectionViewCell {

    static let reuseId = "LikesCollectionViewCell"

    var myImageView: UIImageView = {
       let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupImageView()
        setupAvatarView()
    }

    var nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.textAlignment = .left
        return label
    }()

    var whiteView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.alpha = 0.7
        view.layer.cornerRadius = 4
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    var avatarImageView: UIImageView = {
       let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 45/2
        return imageView
    }()

    func setupImageView() {
        addSubview(myImageView)
        myImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        myImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        myImageView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        myImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
    }

    func setupAvatarView() {
        addSubview(whiteView)

        NSLayoutConstraint.activate([
            whiteView.leftAnchor.constraint(equalTo: leftAnchor),
            whiteView.rightAnchor.constraint(equalTo: rightAnchor),
            whiteView.bottomAnchor.constraint(equalTo: bottomAnchor),
            whiteView.topAnchor.constraint(equalTo: bottomAnchor, constant: -50)
        ])

        addSubview(avatarImageView)
        NSLayoutConstraint.activate([
            avatarImageView.leftAnchor.constraint(equalTo: whiteView.leftAnchor, constant: 2.5),
            avatarImageView.rightAnchor.constraint(equalTo: whiteView.leftAnchor, constant: 47.5),
            avatarImageView.bottomAnchor.constraint(equalTo: whiteView.bottomAnchor, constant: -2.5),
            avatarImageView.topAnchor.constraint(equalTo: whiteView.topAnchor, constant: 2.5)
        ])

        addSubview(nameLabel)
        NSLayoutConstraint.activate([
            nameLabel.leftAnchor.constraint(equalTo: avatarImageView.rightAnchor, constant: 8),
            nameLabel.rightAnchor.constraint(equalTo: whiteView.rightAnchor),
            nameLabel.centerYAnchor.constraint(equalTo: avatarImageView.centerYAnchor)
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
