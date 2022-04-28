//
//  FavoritesViewModel.swift
//  RealEstateApp
//
//  Created by Bruno Vieira Souza on 12/04/22.
//

import Foundation

protocol FavoritesViewModelProtocol: AnyObject {
    var favoriteBind: Bindable<[Favorites]> { get set }
    func fetchListFavoriteProperty()
}

final class FavoritesViewModel: FavoritesViewModelProtocol {
    var favoriteBind: Bindable<[Favorites]> = Bindable([])
    private let apiClient: RealEstateAPIClientFavoritesProtocol
    
    init(apiClient: RealEstateAPIClientFavoritesProtocol) {
        self.apiClient = apiClient
    }
    
    func fetchListFavoriteProperty() {
        apiClient.fetchFavorites { [weak self] response in
            switch response {
            case .success(let result):
                self?.favoriteBind.value = result
            case .failure(let err):
                dump(err)
            }
        }
    }
}
