//
//  DetailedPresenter.swift
//  UnsplashTestTask
//
//  Created by Нагоев Магомед on 08.06.2022.
//

import UIKit

protocol DetailedPresenterProtocol: class {
    func deleteFavoritePhoto()
    func addToFavoritePhoto()
    func photoIsFavorite() -> Bool
    var authorName: String? { get }
    var dataPicture: UIImage? { get }
    var dateCreate: String? { get }
    var locationName: String? { get }
    var downloads: String? { get }
    var avatarImage: UIImage? { get }
}

class DetailedPresenter: DetailedPresenterProtocol {
    private weak var view: DetailedViewController?
    private var router: RouterProtocol?
    private var favoritePhotoService: FavoritePhotoServiceProtocol?
    public let idPhoto: String
    public let authorName: String?
    public let dataPicture: UIImage?
    public let avatarImage: UIImage?
    public let dateCreate: String?
    public let locationName: String?
    public let downloads: String?

    required init(view: DetailedViewController,
                  router: RouterProtocol,
                  favoritePhotoService: FavoritePhotoServiceProtocol,
                  idPhoto: String,
                  authorName: String?,
                  dataPicture: UIImage?,
                  dateCreate: String?,
                  avatarImage: UIImage?,
                  location: String?,
                  downloads: String?) {
        self.view = view
        self.router = router
        self.idPhoto = idPhoto
        self.authorName = authorName
        self.dataPicture = dataPicture
        self.dateCreate = dateCreate
        self.locationName = location
        self.downloads = downloads
        self.favoritePhotoService = favoritePhotoService
        self.avatarImage = avatarImage
    }

    public func photoIsFavorite() -> Bool {
        if let favoritePhotos = favoritePhotoService?.getFavoritePhotos() {
            return favoritePhotos.map { $0.idFavoritePhoto == idPhoto }.contains(true)
        }
        return false
    }

    public func addToFavoritePhoto() {
        let photoData = dataPicture?.pngData()
        let avatarData = avatarImage?.pngData()
            var parameters = [String: String]()
            parameters["idPhoto"] = idPhoto
            parameters["authorName"] = authorName
            parameters["dateCreate"] = dateCreate
            parameters["location"] = locationName
            parameters["downloads"] = downloads

        favoritePhotoService?.addFavoritePhoto(parameters: parameters,
                                               dataPicture: photoData,
                                               avatarImage: avatarData)

    }

    public func deleteFavoritePhoto() {
        if let favoritePhotos = favoritePhotoService?.getFavoritePhotos() {
            favoritePhotos.forEach { (photo) in
                if photo.idFavoritePhoto == idPhoto {
                    favoritePhotoService?.deleteFavoritePhoto(favoritePhoto: photo)
                }
            }
        }
    }
}
