//
//  FavoritePresenter.swift
//  UnsplashTestTask
//
//  Created by Нагоев Магомед on 07.06.2022.
//

import UIKit

protocol FavoritePresenterProtocol: class {
    func getPictures() -> [FavoritePhoto]?
    func tapOntheFavoritePhoto(favoritePhoto: FavoritePhoto)
}

class FavoritePresenter: FavoritePresenterProtocol {
    private weak var view: FavoriteViewController?
    private var router: RouterProtocol?
    private var storeManager: DataStoreManager!
    private var favoritePhotoService: FavoritePhotoServiceProtocol!

    required init(view: FavoriteViewController,
                  storeManager: DataStoreManager,
                  favoritePhotoService: FavoritePhotoServiceProtocol,
                  router: RouterProtocol) {
        self.view = view
        self.storeManager = storeManager
        self.router = router
        self.favoritePhotoService = favoritePhotoService
    }

    public func getPictures() -> [FavoritePhoto]? {
        return favoritePhotoService.getFavoritePhotos()
    }

    public func tapOntheFavoritePhoto(favoritePhoto: FavoritePhoto) {
        if let imageData = favoritePhoto.photoData,
           let image = UIImage(data: imageData) {
            router?.showDetailedViewFromFavorite(favoritePhoto:
                                                    favoritePhoto,
                                                 image: image,
                                                 avatarImage: UIImage(data: favoritePhoto.avatarImage ?? Data()))
        }
    }
}
