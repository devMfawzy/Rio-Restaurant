//
//  MenuViewController+UICollectionViewDelegate.swift
//  Rio Restaurant
//
//  Created by Mohamed Fawzy on 19/02/2021.
//

import UIKit

extension MenuViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if viewModel?.viewType != MenuViewType.category {
            return
        }
        guard let category = viewModel?.categoryAt(row: indexPath.row).id else {
            return
        }
        let viewModel = MenuViewModel(viewType: .product(category: category), service: self.service)
        guard let menuViewController = MenuViewController.instance(viewModel: viewModel) else { return }
        self.navigationController?.pushViewController(menuViewController, animated: true)
    }
    
}
