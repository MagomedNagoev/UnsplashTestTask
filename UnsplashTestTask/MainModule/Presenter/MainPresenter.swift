//
//  MainPresenter.swift
//  UnsplashTestTask
//
//  Created by Нагоев Магомед on 06.06.2022.
//

import UIKit

protocol MainViewProtocol: class {
    func success()
    func failure(error: Error)
}

protocol MainPresenterProtocol: class {
    func getPictures() -> [RandomResult]
    func fetchData(searchTerm: String)
    func tapOnthePhoto(randomResult: RandomResult,
                       image: UIImage,
                       avatarImage: UIImage?)
}

class MainPresenter: MainPresenterProtocol {
    weak var view: MainViewProtocol?
    private var randomResults: [RandomResult]?
    private let networkService: NetworkServiceProtocol!
    private var router: RouterProtocol?

    required init(view: MainViewProtocol,
                  networkService: NetworkServiceProtocol,
                  router: RouterProtocol) {
        self.view = view
        self.networkService = networkService
        self.router = router
        fetchData(searchTerm: "")
    }

    public func fetchData(searchTerm: String) {
        networkService.getData(searchTerm: searchTerm) { [weak self] result in
            guard let self = self else { return }
            DispatchQueue.main.async {
                switch result {
                case .success(let data):
                    self.randomResults = data
                    self.view?.success()
                case .failure(let error):
                    self.view?.failure(error: error)
                }
            }
        }
    }

    public func getPictures() -> [RandomResult] {
        guard let results = randomResults  else {
            return [RandomResult]()
        }
        return results
    }

    public func tapOnthePhoto(randomResult: RandomResult,
                              image: UIImage,
                              avatarImage: UIImage?) {
        router?.showDetailedViewFromMain(randomResult: randomResult, image: image, avatarImage: avatarImage)
    }
}
