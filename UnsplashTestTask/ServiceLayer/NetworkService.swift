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
        print(url)
        var request = URLRequest(url: url)
        request.allHTTPHeaderFields = prepareHeader()
        request.httpMethod = "get"

        URLSession.shared.dataTask(with: request) { data, _, error in
            guard let data = data else {
                return
            }

            do {
                let obj = try JSONDecoder().decode([RandomResult].self, from: data)
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
        if searchTerm != "" {
            parameters["query"] = searchTerm
        }
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
}
