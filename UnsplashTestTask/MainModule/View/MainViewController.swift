//
//  ViewController.swift
//  UnsplashTestTask
//
//  Created by Нагоев Магомед on 06.06.2022.
//

import UIKit
import SDWebImage

class MainViewController: UICollectionViewController {

    public var presenter: MainPresenterProtocol!
    private var timer: Timer?

    private let spinnerView: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView(style: .medium)
        spinner.translatesAutoresizingMaskIntoConstraints = false
        return spinner
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupCollectionView()
        setupSearchBar()
        setupSpinner()
    }

    // MARK: - Setup UI Elements

    private func setupCollectionView() {
        collectionView.backgroundColor = .white

        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "CellId")
        collectionView.register(PhotosCell.self, forCellWithReuseIdentifier: PhotosCell.reuseId)

        collectionView.layoutMargins = UIEdgeInsets(top: 0, left: 2, bottom: 0, right: 2)
        collectionView.contentInsetAdjustmentBehavior = .automatic

        if let waterfallLayout = collectionViewLayout as? WaterfallLayout {
            waterfallLayout.delegate = self
        }
    }

    private func setupSpinner() {
        view.addSubview(spinnerView)
        spinnerView.centerXAnchor.constraint(equalTo: collectionView.centerXAnchor).isActive = true
        spinnerView.centerYAnchor.constraint(equalTo: collectionView.centerYAnchor).isActive = true
    }

    private func setupNavigationBar() {
        let titleLabel = UILabel(text: "Random pictures", font: .systemFont(ofSize: 15, weight: .medium), textColor: #colorLiteral(red: 0.5019607843, green: 0.4980392157, blue: 0.4980392157, alpha: 1))
        navigationItem.leftBarButtonItem = UIBarButtonItem.init(customView: titleLabel)
        navigationController?.hidesBarsOnSwipe = true
    }

    private func setupSearchBar() {
        let seacrhController = UISearchController(searchResultsController: nil)
        navigationItem.searchController = seacrhController
        navigationItem.hidesSearchBarWhenScrolling = false
        seacrhController.hidesNavigationBarDuringPresentation = false
        seacrhController.obscuresBackgroundDuringPresentation = false
        seacrhController.searchBar.delegate = self
    }

    // MARK: - UICollecionViewDataSource, UICollecionViewDelegate

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter.getPictures().count
    }

    override func collectionView(_ collectionView: UICollectionView,
                                 cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotosCell.reuseId,
                                                            for: indexPath) as? PhotosCell else {
            return PhotosCell()
        }

        let unsplashPhoto = presenter.getPictures()[indexPath.item]

        let photoUrl = unsplashPhoto.urls?.regular
        guard let imageUrl = photoUrl, let url = URL(string: imageUrl) else { return PhotosCell()}

        cell.photoImageView.sd_setImage(with: url, completed: nil)

        return cell
    }

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let randomResult = presenter.getPictures()[indexPath.item]
        let photoUrl = randomResult.urls?.regular
        let imageView =  UIImageView()

        guard let imageUrl = photoUrl,
              let url = URL(string: imageUrl),
              let avatarUrlString = randomResult.user?.profileImage?.medium,
              let avatarUrl = URL(string: avatarUrlString) else { return }
        imageView.sd_setImage(with: url)

        var avatarImage = UIImage()

        if let data = try? Data(contentsOf: avatarUrl),
           let image = UIImage(data: data) {
            avatarImage = image
        }

        presenter?.tapOnthePhoto(randomResult: randomResult,
                                 image: imageView.image ?? UIImage(),
                                 avatarImage: avatarImage)

    }
}

// MARK: - UISearchBarDelegate

extension MainViewController: UISearchBarDelegate {

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.spinnerView.startAnimating()
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false, block: {[presenter, spinnerView] (_) in
            presenter?.fetchData(searchTerm: searchText)
            spinnerView.stopAnimating()
        })
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        presenter?.fetchData(searchTerm: "")
    }
}

// MARK: - WaterfallLayoutDelegate
extension MainViewController: WaterfallLayoutDelegate {
    func waterfallLayout(_ layout: WaterfallLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        let photo = presenter.getPictures()[indexPath.item]
        guard let width = photo.width, let height = photo.height else { return CGSize()}
        return CGSize(width: width, height: height)
    }
}

extension MainViewController: MainViewProtocol {
    func success() {
        collectionView.reloadData()
    }

    func failure(error: Error) {

    }
}
