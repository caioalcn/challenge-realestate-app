//
//  File.swift
//  RealEstateApp
//
//  Created by Bruno Vieira Souza on 12/04/22.
//

import Foundation

enum ErrorRequest: Error {
    case url
    case noResponse
    case noData
    case invalidJson
}

class RealEstateAPIClientFavorites {
    
    public static func fetchFavorites(completion: @escaping (Result<[Favorites], ErrorRequest>) -> (Void)) {
        
        let urlString = "https://raw.githubusercontent.com/devpass-tech/challenge-realestate-app/main/api/favorites.json"
        
        guard let url = URL(string: urlString) else {
            completion(.failure(ErrorRequest.url))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            
            guard let data = data else {
                completion(.failure(ErrorRequest.noData))
                return
            }
            do {
                let decoder = JSONDecoder()
                let favorites = try decoder.decode([Favorites].self, from: data)
                completion(.success(favorites))
            } catch {
                completion(.failure(ErrorRequest.invalidJson))
            }
        } .resume()
        
    }
    
}
