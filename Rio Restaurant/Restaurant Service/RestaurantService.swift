//
//  RestaurantService.swift
//  Rio Restaurant
//
//  Created by Mohamed Fawzy on 19/02/2021.
//

import Foundation

class RestaurantService: RestaurantServiceProtocol {

    func categoriesRequestURL(page: Int) -> URL? {
        guard let urlComponents = URLComponents(string: Constants.categoriesUrl) else {
            return nil
        }
        var components = urlComponents
        components.queryItems = [
            URLQueryItem(name: Constants.pageKey, value: String(page))
        ]
        return components.url
    }
    
    func productsRequestURL(page: Int, category: String) -> URL? {
        guard let urlComponents = URLComponents(string: Constants.productUrl) else {
            return nil
        }
        var components = urlComponents
        components.queryItems = [
            URLQueryItem(name: Constants.pageKey, value: String(page)),
            URLQueryItem(name: Constants.categoryKeyValue, value: category),
            //URLQueryItem(name: Constants.includeKey, value: Constants.categoryKeyValue),
        ]
        return components.url
    }
    
    func fetchCategories(count: Int, page: Int, completion: @escaping ([Category], String?) -> Void) {
        let cachedCategories = Category.categories(count: count, page: page)
        if !cachedCategories.isEmpty {
            completion(cachedCategories, nil)
            return
        }
        guard let url = categoriesRequestURL(page: page) else {
            return
        }
        var request = URLRequest(url: url)
        request.setValue(Constants.authorizationValue, forHTTPHeaderField: Constants.authorizationKey)
        let task = URLSession.shared.dataTask(with: request) { data,_,error in
            if let data = data {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let managedObjectContext = CoreDataManager.shared.managedObjectContext
                decoder.userInfo[.managedObjectContext] = managedObjectContext
                do {
                    _ = try decoder.decode(CategoriesResponse.self, from: data)
                    DispatchQueue.main.async {
                        completion(Category.categories(count: count, page: page), nil)
                    }
                } catch {
                    DispatchQueue.main.async {
                        completion([], error.localizedDescription)
                    }
                }
            } else {
                DispatchQueue.main.async {
                    completion([], error?.localizedDescription)
                }
            }
        }
        task.resume()
    }
    
    func fetchProducts(category: String, count: Int, page: Int, completion: @escaping ([Product], String?) -> Void) {
        let cachedProducts = Product.products(category: category, count: count, page: page)
        if !cachedProducts.isEmpty {
            completion(cachedProducts, nil)
            return
        }
        guard let url = productsRequestURL(page: page, category: category) else {
            return
        }
        var request = URLRequest(url: url)
        request.setValue(Constants.authorizationValue, forHTTPHeaderField: Constants.authorizationKey)
        let task = URLSession.shared.dataTask(with: request) { data,_,error in
            if let data = data {
                let decoder = JSONDecoder()
                let managedObjectContext = CoreDataManager.shared.managedObjectContext
                decoder.userInfo[.managedObjectContext] = managedObjectContext
                decoder.userInfo[.category] = category
                do {
                    _ = try decoder.decode(ProductsResponse.self, from: data)
                    DispatchQueue.main.async {
                        completion(Product.products(category: category, count: count, page: page), nil)
                    }
                } catch {
                    DispatchQueue.main.async {
                        completion([], error.localizedDescription)
                    }
                }
            } else {
                DispatchQueue.main.async {
                    completion([], error?.localizedDescription)
                }
            }
        }
        task.resume()
    }
    
}
