//
//  NetworkService.swift
//  UnsplashTestTask
//
//  Created by Нагоев Магомед on 06.06.2022.
//

import Foundation

protocol NetworkServiceProtocol: class {
    func getData(searchTerm: String, completion: @escaping (Result<[RandomResult]?, Error>) -> Void)
}

class NetworkService: NetworkServiceProtocol {
    
    func getData(searchTerm: String, completion: @escaping (Result<[RandomResult]?, Error>) -> Void) {
        let parameters = self.prepareParaments(searchTerm: searchTerm)
        let url = self.url(parameters: parameters)
        var request = URLRequest(url: url)
        request.allHTTPHeaderFields = prepareHeader()
        request.httpMethod = "get"
//        if let cachedRates = getCachedData(from: request) {
//            completion(.success(cachedRates))
//        }
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, let _ = response else {
                return
            }
            
            do {
                let obj = try JSONDecoder().decode([RandomResult].self, from: data)
//                self.saveDataToCache(with: data, and: response)
                completion(.success(obj))
            } catch let error {
                completion(.failure(error))
            }
        }.resume()
    }
    
    private func prepareHeader() -> [String: String]? {
        var headers = [String: String]()
        headers["Authorization"] = "Client-ID IMTWVQzZjzRO0sRxUD6gtMf03l72z-DLrMBguhkJORM"
        return headers
    }
    
    private func prepareParaments(searchTerm: String?) -> [String: String] {
        var parameters = [String: String]()
        parameters["query"] = searchTerm
        parameters["count"] = String(30)
        return parameters
    }
    
    private func url(parameters: [String: String]) -> URL {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.unsplash.com"
        components.path = "/photos/random"
        components.queryItems = parameters.map { URLQueryItem(name: $0, value: $1)}
        return components.url!
    }
    
//    private func getCachedData(from urlRequest: URLRequest) -> [RandomResult]? {
//        if let cachedResponse = URLCache.shared.cachedResponse(for: urlRequest) {
//            do {
//                let obj = try JSONDecoder().decode([RandomResult].self, from: cachedResponse.data)
//                print("загрузка кэша")
//                return obj
//            } catch let error {
//                print(error)
//            }
//        }
//        return nil
//    }
//
//    private func saveDataToCache(with data: Data, and response: URLResponse) {
//            guard let url = response.url else { return }
//            let urlRequest = URLRequest(url: url)
//            let cachedResponse = CachedURLResponse(response: response, data: data)
//            URLCache.shared.storeCachedResponse(cachedResponse, for: urlRequest)
//        print("закэшилось")
//        }
}

