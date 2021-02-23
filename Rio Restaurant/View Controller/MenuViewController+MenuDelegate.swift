//
//  MenuViewController+MenuDelegate.swift
//  Rio Restaurant
//
//  Created by Mohamed Fawzy on 20/02/2021.
//

import UIKit

extension MenuViewController: MenuDelegate {
    
    func didGetCategories(_ categories: [CategoryViewModeling]) {
        self.activityIndicator.stopAnimating()
        self.collectionView.reloadData()
        self.enableButtons()
    }
    
    func didGetProducts(_ products: [ProductViewModeling]) {
        self.activityIndicator.stopAnimating()
        self.collectionView.reloadData()
        self.enableButtons()
    }
    
    func didGetEmptySet() {
        self.activityIndicator.stopAnimating()
        self.enableButtons()
    }
    
    func didGetError(message: String, page: Int) {
        self.activityIndicator.stopAnimating()
        self.enableButtons()
        let aletControl = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        aletControl.addAction(UIAlertAction(title: "Ok", style: .cancel))
        let retryAction = UIAlertAction(title: "Retry", style: .default, handler: { [weak self] _ in
            self?.viewModel?.retry(page: page)
        })
        aletControl.addAction(retryAction)
        self.present(aletControl, animated: true)
    }
    
    private func enableButtons() {
        self.nextButton.isEnabled = true
        self.previousButton.isEnabled = true
    }
    
}
