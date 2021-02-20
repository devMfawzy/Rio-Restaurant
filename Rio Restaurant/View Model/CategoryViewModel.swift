//
//  CategoryViewModel.swift
//  Rio Restaurant
//
//  Created by Mohamed Fawzy on 19/02/2021.
//

import Foundation

class CategoryViewModel: CategoryViewModeling {
    
    var id: String
    var name: String
    
    init(model: Category) {
        self.id = model.id
        self.name = model.name
    }
    
}
