//
//  FavoritesViewController.swift
//  ViewCodeChallenge-RealEstate
//
//  Created by Rodrigo Borges on 06/12/21.
//

import UIKit

class FavoritesViewController: UIViewController {
    
    private let favoriteView: FavoriteView = {
        var view = FavoriteView()
        return view
    }()
    
    private let viewModel: FavoritesViewModelProtocol
    
    override func loadView() {
        self.view = favoriteView
    }
    
    init(viewModel: FavoritesViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        
        self.configureViewModel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Favorites 🏡"
        self.addLoadingView(with: "Fetching favorites...")
        viewModel.fetchListFavoriteProperty()
    }
    
    private func configureViewModel() {
        viewModel.favoriteBind.bind = { result in
            guard let result = result else { return }
            
            DispatchQueue.main.async {
                self.favoriteView.updateView(with: result)
                self.removeLoadingView()
            }
        }
    }
}
