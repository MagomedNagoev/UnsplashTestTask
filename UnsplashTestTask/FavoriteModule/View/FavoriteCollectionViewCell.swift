//
//  FavoriteCollectionViewCell.swift
//  UnsplashTestTask
//
//  Created by Нагоев Магомед on 08.06.2022.
//

import UIKit

class FavoriteCollectionViewCell: UICollectionViewCell {

    static let reuseId = "LikesCollectionViewCell"

    private var photoImageView: UIImageView = {
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

    private var authorNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.textAlignment = .left
        return label
    }()

    private var whiteView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.alpha = 0.7
        view.layer.cornerRadius = 4
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private var avatarImageView: UIImageView = {
       let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 45/2
        return imageView
    }()

    private func setupImageView() {
        addSubview(photoImageView)
        photoImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        photoImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        photoImageView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        photoImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
    }

    private func setupAvatarView() {
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

        addSubview(authorNameLabel)
        NSLayoutConstraint.activate([
            authorNameLabel.leftAnchor.constraint(equalTo: avatarImageView.rightAnchor, constant: 8),
            authorNameLabel.rightAnchor.constraint(equalTo: whiteView.rightAnchor),
            authorNameLabel.centerYAnchor.constraint(equalTo: avatarImageView.centerYAnchor)
        ])
    }

    public func setDataCell(authorName: String?,
                            photoImage: UIImage?,
                            avatarImage: UIImage?) {
        authorNameLabel.text = authorName
        photoImageView.image = photoImage
        avatarImageView.image = avatarImage

    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
