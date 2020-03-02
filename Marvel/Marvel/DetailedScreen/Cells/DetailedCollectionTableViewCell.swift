//
//  DetailedCollectionTableViewCell.swift
//  Marvel
//
//  Created by Mohamed Mahmoud Zaki on 1/12/20.
//  Copyright © 2020 Mohamed Mahmoud Zaki. All rights reserved.
//

import UIKit

class DetailedCollectionTableViewCell: UITableViewCell {

    @IBOutlet weak var title: UILabel!

    @IBOutlet weak var collectionView: UICollectionView!

    override func awakeFromNib() {
        super.awakeFromNib()
        collectionView.delegate = self
        collectionView.dataSource = self
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: frame.width / 3 , height: frame.height)
        layout.scrollDirection = .horizontal
        collectionView.collectionViewLayout = layout
        let nib = UINib(nibName: "DetailedCollectionItemCollectionViewCell", bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: "DetailedCollectionItemCollectionViewCell")
    }
    
}
extension DetailedCollectionTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DetailedCollectionItemCollectionViewCell", for: indexPath)
        guard let cellItem = cell as? DetailedCollectionItemCollectionViewCell else {
            return cell
        }
        return cellItem
    }


}
