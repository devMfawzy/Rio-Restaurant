//
//  ProductsResponse.swift
//  Rio Restaurant
//
//  Created by Mohamed Fawzy on 19/02/2021.
//

import Foundation

struct ProductsResponse: Decodable {
    var data: [Product]
    var meta: MetaData
}
