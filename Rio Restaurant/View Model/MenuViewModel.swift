//
//  MenuViewModel.swift
//  Rio Restaurant
//
//  Created by Mohamed Fawzy on 19/02/2021.
//

import Foundation

class MenuViewModel: MenuViewModeling {
    
    var service: RestaurantServiceProtocol?
    weak var delegate: MenuDelegate?
    var viewType: MenuViewType
    var caregories: [CategoryViewModel] = []
    var products: [ProductViewModeling] = []

    init(viewType: MenuViewType, service: RestaurantServiceProtocol) {
        self.service = service
        self.viewType = viewType
    }
    
    var numberOfItems: Int {
        switch viewType {
        case .category:
            return self.caregories.count
        case .product:
            return self.products.count
        }
    }
    
    func categoryAt(row: Int) -> CategoryViewModeling {
        return self.caregories[row]
    }
    
    func productAt(row: Int) -> ProductViewModeling {
        return self.products[row]
    }
    
    func didLoadViewController() {
        switch self.viewType {
        case .category:
            self.getNextCategories()
        case .product:
            self.getNextProducts()
        }
    }
    
    func getNextCategories() {
        self.service?.getNextCategories(completion: { [weak self] (categories, errorMessage) in
            guard let self = self else { return }
            if let errorMessage = errorMessage {
                self.delegate?.didGetError(message: errorMessage)
            } else if !categories.isEmpty {
                self.caregories = categories.map { CategoryViewModel(model: $0) }
                self.delegate?.didGetCategories(self.caregories)
            }
        })
    }
    
    func getNextProducts() {
        
    }
    
}
