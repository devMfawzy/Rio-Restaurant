//
//  RestaurantServiceProtocol.swift
//  Rio Restaurant
//
//  Created by Mohamed Fawzy on 19/02/2021.
//

import Foundation

protocol RestaurantServiceProtocol {
    func categoriesRequestURL(page: Int) ->  URL?
    func productsRequestURL(page: Int, category: String) ->  URL? 
    func fetchCategories(count: Int, page: Int, completion: @escaping ([Category], String?)->Void)
    func fetchProducts(category: String, count: Int, page: Int, completion: @escaping ([Product], String?)->Void)
}
