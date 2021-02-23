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
    var categories: [CategoryViewModel] = []
    var products: [ProductViewModeling] = []
    var categoriesPage = 0
    var productsPage = 0
    var itemPerPage = 20
    
    init(viewType: MenuViewType, service: RestaurantServiceProtocol) {
        self.service = service
        self.viewType = viewType
    }
    
    var numberOfItems: Int {
        switch viewType {
        case .category:
            return self.categories.count
        case .product:
            return self.products.count
        }
    }
    
    func categoryAt(row: Int) -> CategoryViewModeling {
        return self.categories[row]
    }
    
    func productAt(row: Int) -> ProductViewModeling {
        return self.products[row]
    }
    
    func didLoadViewController() {
        self.getNextPage()
    }
    
    func getNextPage() {
        switch self.viewType {
        case .category:
            self.getCategories(page: self.categoriesPage+1)
        case .product:
            self.getProducts(page: self.productsPage+1)
        }
    }
    
    func getPreviousPage() {
        switch self.viewType {
        case .category:
            self.getCategories(page: max(self.categoriesPage-1, 1))
        case .product:
            self.getProducts(page: max(self.productsPage-1, 1))
        }
    }
    
    func getCategories(page: Int) {
        self.service?.fetchCategories(count: itemPerPage, page: page, completion: { [weak self] (categories, errorMessage) in
            guard let self = self else { return }
            if let errorMessage = errorMessage {
                self.delegate?.didGetError(message: errorMessage, page: page)
            } else if !categories.isEmpty {
                self.categories = categories.map { CategoryViewModel(model: $0) }
                self.delegate?.didGetCategories(self.categories)
                self.categoriesPage = page
            } else {
                self.delegate?.didGetEmptySet()
            }
        })
    }
    
    func getProducts(page: Int) {
        switch viewType {
        case .product(category: let category):
            self.service?.fetchProducts(category: category, count: itemPerPage, page: page, completion: { [weak self] (products, errorMessage) in
                guard let self = self else { return }
                if let errorMessage = errorMessage {
                    self.delegate?.didGetError(message: errorMessage, page: page)
                } else if !products.isEmpty {
                    self.products = products.map { ProductViewModel(model: $0) }
                    self.delegate?.didGetProducts(self.products)
                    self.productsPage = page
                } else {
                    self.delegate?.didGetEmptySet()
                }
            })
        default:
            return
        }
    }
    
    func retry(page: Int) {
        switch self.viewType {
        case .category:
            self.getCategories(page: page)
        case .product:
            self.getProducts(page: page)
        }
    }
    
}
