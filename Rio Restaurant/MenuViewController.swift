//
//  ViewController.swift
//  Rio Restaurant
//
//  Created by Mohamed Fawzy on 17/02/2021.
//

import UIKit

class MenuViewController: UIViewController {

    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var previousButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupView()
    }
    
    private func setupView() {
        self.collectionView.register(UINib(nibName: CategoryCell.reuseIdentifier, bundle: nil), forCellWithReuseIdentifier: CategoryCell.reuseIdentifier)
        self.collectionView.register(UINib(nibName: ProductCell.reuseIdentifier, bundle: nil), forCellWithReuseIdentifier: ProductCell.reuseIdentifier)
        self.collectionView.collectionViewLayout = self.collectionViewLayout
        self.collectionView.reloadData()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.collectionView.collectionViewLayout.invalidateLayout()
    }
    
    var collectionViewLayout: UICollectionViewLayout {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.itemSize = self.itemSize
        layout.sectionInset = UIEdgeInsets(top: 0, left: 24, bottom: 0, right: 24)
        layout.minimumLineSpacing = 20
        return layout
    }
    
    var gridWidth: CGFloat {
        return self.collectionView.frame.width
    }
    
    var gridHeight: CGFloat {
        return self.collectionView.frame.height
    }
    
    var itemSize: CGSize {
        let size:CGFloat = UIDevice.current.orientation.isLandscape ? (gridHeight/5)-80 : (gridWidth/3)-40
        return CGSize(width: size, height: size)
    }
    
}

