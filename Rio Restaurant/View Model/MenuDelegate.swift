//
//  MenuDelegate.swift
//  Rio Restaurant
//
//  Created by Mohamed Fawzy on 19/02/2021.
//

import Foundation

protocol MenuDelegate: class {
    func didGetCategories(_ categories: [CategoryViewModeling])
    func didGetProducts(_ products: [ProductViewModeling])
    func didGetFirstPage()
    func didGetLastPage()
    func didGetError(message: String)
}
