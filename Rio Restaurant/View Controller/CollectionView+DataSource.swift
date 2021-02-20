//
//  CollectionViewDataSource.swift
//  Rio Restaurant
//
//  Created by Mohamed Fawzy on 17/02/2021.
//

import UIKit

extension MenuViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel?.numberOfItems ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let viewModel = self.viewModel else {
            return UICollectionViewCell()
        }
        var reuseIdentifier: String
        switch viewModel.viewType {
        case .category:
            reuseIdentifier = CategoryCell.reuseIdentifier
        case .product:
            reuseIdentifier = ProductCell.reuseIdentifier
        }
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
        switch viewModel.viewType {
        case .category:
            if let cell = cell as? CategoryCell {
                cell.config(viewModel: viewModel.categoryAt(row: indexPath.row))
            }
        case .product:
            if let cell = cell as? ProductCell {
                cell.config(viewModel: viewModel.productAt(row: indexPath.row))
            }        }
        return cell
    }
    
}
