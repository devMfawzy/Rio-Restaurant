//
//  MenuViewModeling.swift
//  Rio Restaurant
//
//  Created by Mohamed Fawzy on 19/02/2021.
//

import Foundation

protocol MenuViewModeling {
    var service: RestaurantServiceProtocol? { get }
    var delegate: MenuDelegate? { get set }
    var viewType: MenuViewType { get }
    var numberOfItems: Int { get }
    func didLoadViewController()
    func categoryAt(row: Int) -> CategoryViewModeling
    func productAt(row: Int) -> ProductViewModeling
    func getNextPage()
    func getPreviousPage()
    func retry(page: Int)
}
