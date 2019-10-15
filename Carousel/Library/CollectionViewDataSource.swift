//
//  CollectionViewDataSource.swift
//  Carousel
//
//  Created by Alexey Zhulikov on 15.10.2019.
//  Copyright © 2019 Alexey Zhulikov. All rights reserved.
//

import UIKit

final class CollectionViewDataSource<Model>: NSObject, UICollectionViewDataSource {

    // MARK: - Nested Types

    typealias CellConfigurator = (Model, UICollectionViewCell) -> Void

    // MARK: - Pirivate Properties

    private var data: [Model]
    private var cellClass: UICollectionViewCell.Type
    private var cellConfigurator: CellConfigurator

    // MARK: - Initialization

    init(data: [Model], cellClass: UICollectionViewCell.Type, cellConfigurator: @escaping CellConfigurator) {
        self.data = data
        self.cellClass = cellClass
        self.cellConfigurator = cellConfigurator
    }

    // MARK: - UICollectionViewDataSource

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(cellClass, for: indexPath)
        let model = data[indexPath.item]
        cellConfigurator(model, cell)
        return cell
    }

}
