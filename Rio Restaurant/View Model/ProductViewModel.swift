//
//  ProductViewModel.swift
//  Rio Restaurant
//
//  Created by Mohamed Fawzy on 19/02/2021.
//

import Foundation

struct ProductViewModel: ProductViewModeling {
    
    var name: String
    var price: String
    var image: String?
    
    init(model: Product) {
        self.name = model.name ?? ""
        self.price = "$\(String(model.price))"
        self.image = model.image
    }
    
}
