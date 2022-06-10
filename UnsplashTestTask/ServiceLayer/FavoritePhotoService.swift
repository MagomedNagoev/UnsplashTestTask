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
    func addFavoritePhoto (id: String,
                  authorName: String?,
                  dataPicture: Data?,
                  avatarImage: Data?,
                  dateCreate: String?,
                  location: String?,
                  downloads: String?) -> FavoritePhoto
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
    func addFavoritePhoto(id: String, authorName: String?, dataPicture: Data?, avatarImage: Data? ,dateCreate: String?, location: String?, downloads: String?) -> FavoritePhoto {
        let favoritePhoto = FavoritePhoto(context: managedObjectContext)
        
        favoritePhoto.authorName = authorName
        favoritePhoto.createdDate = dateCreate
        favoritePhoto.date = Date()
        favoritePhoto.downloads = downloads
        favoritePhoto.id = id
        favoritePhoto.locationName = location
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
