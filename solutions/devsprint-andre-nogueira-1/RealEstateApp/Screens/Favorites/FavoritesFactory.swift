//
//  FavoritesFactory.swift
//  RealEstateApp
//
//  Created by Caio Alcântara on 27/04/22.
//

import Foundation

struct FavoritesFactory {
    
    static func createFavorite() -> FavoritesViewController {
        let managerUrl = ManagerGetURL()
        let apiClientFavorites = RealEstateAPIClientFavorites(url: managerUrl)
        let favoriteViewModel = FavoritesViewModel(apiClient: apiClientFavorites)
        let favoriteController = FavoritesViewController(viewModel: favoriteViewModel)
        return favoriteController
    }
}
