//
//  Router.swift
//  UnsplashTestTask
//
//  Created by Нагоев Магомед on 06.06.2022.
//

import UIKit

protocol RouterMain {
    var tabBarController: UITabBarController? { get set }
    var builder: BuilderProtocol? { get set }
}

protocol RouterProtocol: RouterMain {
    func configureViewControllers()
    func showDetailedViewFromMain(randomResult: RandomResult,
                                  image: UIImage,
                                  avatarImage: UIImage?)
    func showDetailedViewFromFavorite(favoritePhoto: FavoritePhoto,
                                      image: UIImage,
                                      avatarImage: UIImage?)
}

class Router: RouterProtocol {
    
    var tabBarController: UITabBarController?
    var builder: BuilderProtocol?
    var mainNavigationController = UINavigationController()
    var favoriteNavigationController = UINavigationController()
    
    
    init(tabBarController: UITabBarController, builder: BuilderProtocol) {
        self.tabBarController = tabBarController
        self.builder = builder
    }
    
    func templateNavigationController(image: UIImage,
                                      tabBarItemTitle: String,
                                      rootViewController: UIViewController) -> UINavigationController {
        let appearence = UINavigationBarAppearance()
        appearence.configureWithOpaqueBackground()
        appearence.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        
        let navigationController = UINavigationController(rootViewController: rootViewController)
        navigationController.tabBarItem.image = image
        navigationController.tabBarItem.title = tabBarItemTitle
//        navigationController.navigationBar.isTranslucent = false
//        navigationController.navigationBar.shadowImage = UIImage()
        
        navigationController.navigationBar.standardAppearance = appearence
        navigationController.navigationBar.scrollEdgeAppearance = navigationController.navigationBar.standardAppearance
        return navigationController
    }
    
    func configureViewControllers() {
        if let tabBarController = tabBarController {
            
            let configuration = UIImage.SymbolConfiguration(pointSize: 18, weight: .light, scale: .large)
            let imagePhoto = UIImage(systemName: "photo.on.rectangle.angled",
                                     withConfiguration: configuration)
            let imageStar = UIImage(systemName: "heart.circle",
                                    withConfiguration: configuration)
            guard let mainViewController = builder?.createMainModule(router: self),
                  let favoriteViewController = builder?.createFavoriteModule(router: self)
                  else { return }
            mainNavigationController = templateNavigationController(image:
                                                                        imagePhoto!,
                                         tabBarItemTitle: "Pictures",
                                         rootViewController: mainViewController)
            
            favoriteNavigationController = templateNavigationController(image:                                imageStar!,
                                         tabBarItemTitle: "Favorites",
                                         rootViewController: favoriteViewController)
            
            
            tabBarController.viewControllers = [mainNavigationController,favoriteNavigationController]
            
            tabBarController.tabBar.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            tabBarController.tabBar.barStyle = .default
            tabBarController.tabBar.tintColor = #colorLiteral(red: 0.2605174184, green: 0.2605243921, blue: 0.260520637, alpha: 1)
        }
    }
    
    func showDetailedViewFromMain(randomResult: RandomResult,
                                  image: UIImage,
                                  avatarImage: UIImage?) {
              let authorName = randomResult.user?.name
        let dateCreate = randomResult.createdAt?.asDate()
              let location = randomResult.location?.name
        let downloads = Formatter.currency.string(from:
                                                    NSNumber(value: randomResult.downloads ?? 0))
            guard let id = randomResult.id,
                  let detailedViewController =
                    builder?.createDetailedModule(router: self,
                                                  id: id,
                                                  authorName: authorName,
                                                  dataPicture: image,
                                                  avatarImage: avatarImage,
                                                  dateCreate: dateCreate,
                                                  location: location,
                                                  downloads: downloads)
            else { return }
        mainNavigationController.pushViewController(detailedViewController, animated: true)
        
    }
    
    func showDetailedViewFromFavorite(favoritePhoto: FavoritePhoto,
                                      image: UIImage,
                                      avatarImage: UIImage?) {
              let authorName = favoritePhoto.authorName
              let dateCreate = favoritePhoto.createdDate
              let location = favoritePhoto.locationName
              let downloads = favoritePhoto.downloads
            guard let id = favoritePhoto.id,
                  let detailedViewController =
                    builder?.createDetailedModule(router: self,
                                                  id: id,
                                                  authorName: authorName,
                                                  dataPicture: image,
                                                  avatarImage: avatarImage,
                                                  dateCreate: dateCreate,
                                                  location: location,
                                                  downloads: downloads)
            else { return }
        favoriteNavigationController.pushViewController(detailedViewController, animated: true)
    }
    
}
