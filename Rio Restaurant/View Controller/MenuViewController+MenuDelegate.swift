//
//  MenuViewController+MenuDelegate.swift
//  Rio Restaurant
//
//  Created by Mohamed Fawzy on 20/02/2021.
//

import Foundation

extension MenuViewController: MenuDelegate {
    
    func didGetCategories(_ categories: [CategoryViewModeling]) {
        self.activityIndicator.stopAnimating()
        self.collectionView.reloadData()
    }
    
    func didGetProducts(_ products: [ProductViewModeling]) {
        self.activityIndicator.stopAnimating()
        self.collectionView.reloadData()
    }
    
    func didGetFirstPage() {
        
    }
    
    func didGetLastPage() {
        
    }
    
    func didGetError(message: String) {
        self.activityIndicator.stopAnimating()
    }
    
}
