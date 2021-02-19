//
//  UICollectionViewCell+ReusableIdentifier.swift
//  Rio Restaurant
//
//  Created by Mohamed Fawzy on 18/02/2021.
//

import UIKit

extension UICollectionViewCell {
    
    static var reuseIdentifier: String {
        return String(describing: self)
    }
    
}
