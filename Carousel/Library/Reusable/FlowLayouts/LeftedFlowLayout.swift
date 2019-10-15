//
//  LeftedFlowLayout.swift
//  Carousel
//
//  Created by Alexey Zhulikov on 12/10/2019.
//  Copyright © 2019 Alexey Zhulikov. All rights reserved.
//

import UIKit

final class LeftedFlowLayout: UICollectionViewFlowLayout {

    // MARK: - Constants

    private enum Constants {
        static let spacing: CGFloat = 16
        static let offset: CGFloat = 8
    }

    // MARK: - Private Properties

    private var contentOffset: CGPoint = .zero

    private var currentContentOffset: CGPoint {
        return collectionView?.contentOffset ?? .zero
    }

    private var bounds: CGRect {
        return collectionView?.bounds ?? .zero
    }

    private var numberOfItems: Int {
        return collectionView?.numberOfItems(inSection: 0) ?? 0
    }

    // MARK: - UICollectionViewFlowLayout

    override func prepare() {
        super.prepare()
        configure()
    }

    override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint,
                                      withScrollingVelocity velocity: CGPoint) -> CGPoint {
        let proposedRect = CGRect(
            x: proposedContentOffset.x,
            y: 0,
            width: bounds.width,
            height: bounds.height
        )

        guard let layoutAttributes = super.layoutAttributesForElements(in: proposedRect) else {
            return .zero
        }

        // find nearest cell
        var offset = CGFloat.greatestFiniteMagnitude
        var targetIndex = 0
        let horizontalCenter = proposedContentOffset.x + bounds.width / 2
        for attributes in layoutAttributes {
            if (attributes.center.x - horizontalCenter).magnitude < offset.magnitude {
                offset = attributes.center.x - horizontalCenter
                targetIndex = attributes.indexPath.item
            }
        }

        let targetContentOffset = getContentOffset(for: targetIndex)
        guard targetContentOffset != contentOffset else {
            DispatchQueue.main.async {
                self.collectionView?.setContentOffset(targetContentOffset, animated: true)
            }
            return currentContentOffset
        }

        contentOffset = targetContentOffset
        return targetContentOffset
    }

    // MARK: - Private Methods

    private func configure() {
        scrollDirection = .horizontal
        minimumLineSpacing = Constants.spacing
        configureItemSize()
        configureInsets()
    }

    private func configureItemSize() {
        let width: CGFloat = bounds.width - 2 * Constants.spacing - Constants.offset
        let height = bounds.height
        itemSize = CGSize(width: width, height: height)
    }

    private func configureInsets() {
        let horizontalInset = Constants.spacing
        sectionInset = UIEdgeInsets(
            top: 0,
            left: horizontalInset,
            bottom: 0,
            right: horizontalInset
        )
    }

    private func getContentOffset(for item: Int) -> CGPoint {
        var offsetX = (itemSize.width + Constants.spacing) * CGFloat(item)

        // adjust for last item
        if item == numberOfItems - 1 {
            offsetX -= Constants.offset
        }

        return CGPoint(x: offsetX, y: 0)
    }

}
