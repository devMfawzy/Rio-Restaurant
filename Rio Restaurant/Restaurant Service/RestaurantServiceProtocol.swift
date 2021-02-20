//
//  RestaurantServiceProtocol.swift
//  Rio Restaurant
//
//  Created by Mohamed Fawzy on 19/02/2021.
//

import Foundation

protocol RestaurantServiceProtocol {
    var categoriesRequestURL: URL? { get }
    var productsRequestURL: URL? { get }
    func getNextCategories(completion: @escaping ([Category], String?)->Void)
    func getNextProducts(category: String, completion: @escaping ([Product], String?)->Void)
}
