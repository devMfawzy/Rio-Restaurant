//
//  CategoriesResponse.swift
//  Rio Restaurant
//
//  Created by Mohamed Fawzy on 19/02/2021.
//

import Foundation

struct CategoriesResponse: Decodable {
    var data: [Category]
    var meta: MetaData
}
