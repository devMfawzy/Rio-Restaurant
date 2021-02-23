//
//  ProductCell.swift
//  Rio Restaurant
//
//  Created by Mohamed Fawzy on 18/02/2021.
//

import Kingfisher

class ProductCell: UICollectionViewCell {

    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
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

    func config(viewModel: ProductViewModeling) {
        self.productName.text = viewModel.name
        self.priceLabel.text = viewModel.price
        guard let image = viewModel.image, let url = URL(string: image) else {
            return
        }
        productImageView.kf.setImage(with: url)
    }
    
}
