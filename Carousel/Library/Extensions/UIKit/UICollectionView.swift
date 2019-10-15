//
//  UICollectionView.swift
//  Carousel
//
//  Created by Alexey Zhulikov on 11/10/2019.
//  Copyright © 2019 Alexey Zhulikov. All rights reserved.
//

import UIKit

extension UICollectionView {

    func register(_ cellClasses: UICollectionViewCell.Type...) {
        cellClasses.forEach { cellClass in
            register(UINib(nibName: cellClass.nib, bundle: nil), forCellWithReuseIdentifier: cellClass.identifier)
        }
    }

    func dequeueReusableCell<T: UICollectionViewCell>(_ cellClass: T.Type, for indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withReuseIdentifier: cellClass.identifier, for: indexPath) as? T else {
            fatalError("Can't dequeue cell with identifier \(cellClass.identifier)")
        }
        return cell
    }

}
