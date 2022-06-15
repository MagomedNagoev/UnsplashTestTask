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
    var location: String? { get }
    var downloads: String? { get }
    var avatarImage: UIImage? { get }
}

class DetailedPresenter: DetailedPresenterProtocol {

    weak var view: DetailedViewController?
    var router: RouterProtocol?
    var favoritePhotoService: FavoritePhotoServiceProtocol?
    let idPhoto: String
    let authorName: String?
    let dataPicture: UIImage?
    let avatarImage: UIImage?
    let dateCreate: String?
    let location: String?
    let downloads: String?

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
        self.location = location
        self.downloads = downloads
        self.favoritePhotoService = favoritePhotoService
        self.avatarImage = avatarImage
    }

    func photoIsFavorite() -> Bool {
        if let favoritePhotos = favoritePhotoService?.getFavoritePhotos() {
            return favoritePhotos.map { $0.idFavoritePhoto == idPhoto }.contains(true)
        }
        return false
    }

    func addToFavoritePhoto() {
        let photoData = dataPicture?.pngData()
        let avatarData = avatarImage?.pngData()
            var parameters = [String: String]()
            parameters["idPhoto"] = idPhoto
            parameters["authorName"] = authorName
            parameters["dateCreate"] = dateCreate
            parameters["location"] = location
            parameters["downloads"] = downloads

        favoritePhotoService?.addFavoritePhoto(parameters: parameters,
                                               dataPicture: photoData,
                                               avatarImage: avatarData)

    }

    func deleteFavoritePhoto() {
        if let favoritePhotos = favoritePhotoService?.getFavoritePhotos() {
            favoritePhotos.forEach { (photo) in
                if photo.idFavoritePhoto == idPhoto {
                    favoritePhotoService?.deleteFavoritePhoto(favoritePhoto: photo)
                }
            }
        }
    }
}
