//
//  FavoriteView.swift
//  RealEstateApp
//
//  Created by Caio Alcântara on 27/04/22.
//

import Foundation
import UIKit

final class FavoriteView: BaseView {
    
    private lazy var tableView: UITableView = {
        var table = UITableView(frame: .zero)
        table.translatesAutoresizingMaskIntoConstraints = false
        table.register(PropertyTableViewCell.self, forCellReuseIdentifier: PropertyTableViewCell.identifier)
        table.dataSource = self
        table.delegate = self
        return table
    }()
    
    private var listItems: [Favorites] = []
    
    override func setupSubviews() {
        setUpHierarchy()
        setUpConstraints()
    }
    
    private func setUpHierarchy() {
        self.addSubview(tableView)
    }
    
    private func setUpConstraints() {
        NSLayoutConstraint.activate([
            self.tableView.leftAnchor.constraint(equalTo: self.leftAnchor),
            self.tableView.rightAnchor.constraint(equalTo: self.rightAnchor),
            self.tableView.topAnchor.constraint(equalTo: self.topAnchor),
            self.tableView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
    
    func updateView(with repositories: [Favorites]) {
            self.listItems = repositories
            self.tableView.reloadData()
    }
}

extension FavoriteView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.listItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let propertyCell = tableView.dequeueReusableCell(withIdentifier: PropertyTableViewCell.identifier, for: indexPath) as? PropertyTableViewCell else { return UITableViewCell() }
        
        propertyCell.setup(favorite: listItems[indexPath.row])
        
        return propertyCell
    }
}

extension FavoriteView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
