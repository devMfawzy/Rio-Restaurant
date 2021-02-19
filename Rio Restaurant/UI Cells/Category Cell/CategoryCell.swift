//
//  CategoryCell.swift
//  Rio Restaurant
//
//  Created by Mohamed Fawzy on 18/02/2021.
//

import UIKit

class CategoryCell: UICollectionViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setupView()
    }
    
    private func setupView() {
        let layer = self.contentView.layer
        layer.cornerRadius = 5
        layer.borderWidth = 1
        layer.borderColor = UIColor.gray.cgColor
        layer.masksToBounds = true
    }

}
