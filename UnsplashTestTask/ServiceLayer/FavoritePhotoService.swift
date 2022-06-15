//
//  PhotoService.swift
//  UnsplashTestTask
//
//  Created by Нагоев Магомед on 08.06.2022.
//

import Foundation
import CoreData

protocol FavoritePhotoServiceProtocol {
    @discardableResult
    func addFavoritePhoto (parameters: [String: String],
                           dataPicture: Data?,
                           avatarImage: Data?) -> FavoritePhoto
    func deleteFavoritePhoto(favoritePhoto: FavoritePhoto)
    func getFavoritePhotos() -> [FavoritePhoto]?
}

class FavoritePhotoService: FavoritePhotoServiceProtocol {

    // MARK: Properties
    let managedObjectContext: NSManagedObjectContext
    let dataStoreManager: DataStoreManager

    // MARK: - Initializers
    public init(managedObjectContext: NSManagedObjectContext, dataStoreManager: DataStoreManager) {
        self.managedObjectContext = managedObjectContext
        self.dataStoreManager = dataStoreManager
    }

    @discardableResult
    func addFavoritePhoto(parameters: [String: String],
                          dataPicture: Data?,
                          avatarImage: Data?) -> FavoritePhoto {
        let favoritePhoto = FavoritePhoto(context: managedObjectContext)

        favoritePhoto.authorName = parameters["authorName"]
        favoritePhoto.createdDate = parameters["dateCreate"]
        favoritePhoto.date = Date()
        favoritePhoto.downloads = parameters["downloads"]
        favoritePhoto.idFavoritePhoto = parameters["idPhoto"]
        favoritePhoto.locationName = parameters["location"]
        favoritePhoto.photoData = dataPicture
        favoritePhoto.avatarImage = avatarImage
        dataStoreManager.saveContext(managedObjectContext)
        return favoritePhoto
    }

    func deleteFavoritePhoto(favoritePhoto: FavoritePhoto) {
        managedObjectContext.delete(favoritePhoto)
        dataStoreManager.saveContext(managedObjectContext)
    }

    func getFavoritePhotos() -> [FavoritePhoto]? {
        let favoritePhotoFetch: NSFetchRequest<FavoritePhoto> = FavoritePhoto.fetchRequest()
        do {
            let rates = try managedObjectContext.fetch(favoritePhotoFetch)
            return rates
        } catch let error as NSError {
            print("Fetch error: \(error) description: \(error.userInfo)")
        }
        return nil
    }
}
