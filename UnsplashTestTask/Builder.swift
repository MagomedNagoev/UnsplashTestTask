//
//  Builder.swift
//  UnsplashTestTask
//
//  Created by Нагоев Магомед on 06.06.2022.
//

import UIKit

protocol BuilderProtocol: class {
    func createMainModule(router: RouterProtocol) -> UIViewController
    func createFavoriteModule(router: RouterProtocol) -> UIViewController
    func createDetailedModule(router: RouterProtocol,
                              id: String,
                              authorName: String?,
                              dataPicture: UIImage?,
                              avatarImage: UIImage?,
                              dateCreate: String?,
                              location: String?,
                              downloads: String?) -> UIViewController

}

class ModelBuilder: BuilderProtocol {
    
    
    let dataStoreManager = DataStoreManager()
    
    func createMainModule(router: RouterProtocol) -> UIViewController {
        let view = MainViewController(collectionViewLayout: WaterfallLayout())
        let networkService = NetworkService()
        let presenter = MainPresenter(view: view,
                                      networkService: networkService,
                                      router: router)
        view.presenter = presenter
        return view
    }
    
    func createFavoriteModule(router: RouterProtocol) -> UIViewController {
        let view = FavoriteViewController(collectionViewLayout: UICollectionViewFlowLayout())
        let favoritePhotoService = FavoritePhotoService(managedObjectContext: dataStoreManager.mainContext, dataStoreManager: dataStoreManager)
        let presenter = FavoritePresenter(view: view, storeManager: dataStoreManager, favoritePhotoService: favoritePhotoService, router: router)
        view.presenter = presenter
        return view
    }
    
    func createDetailedModule(router: RouterProtocol,
                              id: String,
                              authorName: String?,
                              dataPicture: UIImage?,
                              avatarImage: UIImage?,
                              dateCreate: String?,
                              location: String?,
                              downloads: String?) -> UIViewController {
        let view = DetailedViewController()
        let favoritePhotoService = FavoritePhotoService(managedObjectContext: dataStoreManager.mainContext, dataStoreManager: dataStoreManager)
        let presenter = DetailedPresenter(view: view,
                                          router: router,
                                          favoritePhotoService: favoritePhotoService,
                                          id: id,
                                          authorName: authorName,
                                          dataPicture: dataPicture,
                                          dateCreate: dateCreate,
                                          avatarImage: avatarImage,
                                          location: location,
                                          downloads: downloads)
        
        view.presenter = presenter
        return view
    }
    
    
}

