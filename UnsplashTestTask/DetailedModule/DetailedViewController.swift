//
//  DetailedViewController.swift
//  UnsplashTestTask
//
//  Created by Нагоев Магомед on 08.06.2022.
//

import UIKit

class DetailedViewController: UIViewController {

    var presenter: DetailedPresenterProtocol!
    let stackView = UIStackView()
    var photoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .white
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()

    var favoriteButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "suit.heart"), for: .normal)
        button.addTarget(self, action: #selector(tapButton), for: .touchUpInside)
        return button
    }()

    var authorNameLabel: UILabel = {
        let label = UILabel(text: "👤 N/A",
                            font: .systemFont(ofSize: 15),
                            textAlignment: .left)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    var dateCreateLabel: UILabel = {
        let label = UILabel(text: "📅 N/A",
                            font: .systemFont(ofSize: 15),
                            textAlignment: .left)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    var locationLabel: UILabel = {
        let label = UILabel(text: "📍 N/A",
                            font: .systemFont(ofSize: 15),
                            textAlignment: .left)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    var downloadsLabel: UILabel = {
        let label = UILabel(text: "📥 N/A",
                            font: .systemFont(ofSize: 15),
                            textAlignment: .left)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        UIConfig()
        setupDataFromPresenter()

    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setButton()
    }

    @objc
    func tapButton() {
        if presenter.photoIsFavorite() {
            callAlert(message: "Delete a picture from favourites?") { [favoriteButton, presenter] in
                favoriteButton.heartButton()
                presenter?.deleteFavoritePhoto()
            }

        } else {
            callAlert(message: "Add a picture to favourites?") { [favoriteButton, presenter] in
                favoriteButton.heartButtonFill()
                presenter?.addToFavoritePhoto()
            }
        }

    }

    func setupDataFromPresenter() {
        photoImageView.image = presenter.dataPicture
        if let string = presenter.authorName {
            stackView.addArrangedSubview(authorNameLabel)
            authorNameLabel.text = "👤  \(string)"
        }

        if let string = presenter.dateCreate {
            stackView.addArrangedSubview(dateCreateLabel)
            dateCreateLabel.text = "📅  \(string)"
        }

        if let string = presenter.location {
            stackView.addArrangedSubview(locationLabel)
            locationLabel.text = "📍  \(string)"
        }

        if let string = presenter.downloads {
            stackView.addArrangedSubview(downloadsLabel)
            downloadsLabel.text = "📥  \(string)"
        }
    }

    func setButton() {
        if presenter.photoIsFavorite() {
            favoriteButton.heartButtonFill()
        } else {
            favoriteButton.heartButton()
        }
    }

    func callAlert(message: String, complition: @escaping () -> Void) {
        let alertController = UIAlertController(title: "", message: message, preferredStyle: .alert)
        let add = UIAlertAction(title: "Yes", style: .default) {_ in
            complition()
        }
        let cancel = UIAlertAction(title: "No", style: .cancel) {_ in
        }
        alertController.addAction(add)
        alertController.addAction(cancel)
        present(alertController, animated: true)
    }

    func UIConfig() {

        let saveAreaView = view.safeAreaLayoutGuide

        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution  = UIStackView.Distribution.fillEqually
        stackView.alignment = UIStackView.Alignment.leading
        stackView.axis = .vertical
        stackView.spacing = 0

        view.addSubview(photoImageView)
        NSLayoutConstraint.activate([
            photoImageView.topAnchor.constraint(equalTo: saveAreaView.topAnchor, constant: 2),
            photoImageView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 2),
            photoImageView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -2),
            photoImageView.bottomAnchor.constraint(equalTo: saveAreaView.bottomAnchor, constant: -300)

        ])

        view.addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: photoImageView.bottomAnchor, constant: 20),
            stackView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 5),
            stackView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -5),
            stackView.bottomAnchor.constraint(equalTo: saveAreaView.bottomAnchor, constant: -100)

        ])

        view.addSubview(favoriteButton)
        NSLayoutConstraint.activate([
            favoriteButton.topAnchor.constraint(equalTo: stackView.topAnchor, constant: -5),
            favoriteButton.leftAnchor.constraint(equalTo: photoImageView.rightAnchor, constant: -55),
            favoriteButton.rightAnchor.constraint(equalTo: photoImageView.rightAnchor, constant: -5),
            favoriteButton.bottomAnchor.constraint(equalTo: stackView.topAnchor, constant: 50)

        ])
    }
}
