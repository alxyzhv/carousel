//
//  CenteredFlowLayout.swift
//  Carousel
//
//  Created by Alexey Zhulikov on 14.10.2019.
//  Copyright © 2019 Alexey Zhulikov. All rights reserved.
//

import UIKit

final class CenteredFlowLayout: UICollectionViewFlowLayout {

    // MARK: - Constants

    private enum Constants {
        static let spacing: CGFloat = 18
        static let scale: CGFloat = 1.1
    }

    // MARK: - Private Properties

    private var contentOffset: CGPoint = .zero

    private var currentContentOffset: CGPoint {
        return collectionView?.contentOffset ?? .zero
    }

    private var bounds: CGRect {
        return collectionView?.bounds ?? .zero
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

        var offsetAdjustment = CGFloat.greatestFiniteMagnitude
        var indexPath = IndexPath(item: 0, section: 0)
        let horizontalCenter = proposedContentOffset.x + bounds.width / 2
        for attributes in layoutAttributes {
            if (attributes.center.x - horizontalCenter).magnitude < offsetAdjustment.magnitude {
                offsetAdjustment = attributes.center.x - horizontalCenter
                indexPath = attributes.indexPath
            }
        }

        let targetContentOffsetX = proposedContentOffset.x + offsetAdjustment
        let targetContentOffset = CGPoint(x: targetContentOffsetX, y: 0)
        guard targetContentOffset != contentOffset else {
            DispatchQueue.main.async {
                self.collectionView?.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
            }
            return currentContentOffset
        }

        contentOffset = targetContentOffset
        return targetContentOffset
    }

    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        guard let attributes = super.layoutAttributesForElements(in: rect) else {
            return nil
        }

        let visibleRect = CGRect(origin: currentContentOffset, size: bounds.size)
        var customAttributes = [UICollectionViewLayoutAttributes]()
        let maxDistance = bounds.width

        for attributes in attributes where attributes.frame.intersects(visibleRect) {
            guard let attributes = attributes.copy() as? UICollectionViewLayoutAttributes else {
                continue
            }

            let distance = min(abs(attributes.center.x - visibleRect.midX), maxDistance)
            let ratio =  1 - distance / maxDistance
            let scale = max(1, ratio * Constants.scale)
            attributes.transform3D = CATransform3DMakeScale(scale, scale, scale)
            customAttributes.append(attributes)
        }

        return customAttributes
    }

    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }

    // MARK: - Private Methods

    private func configure() {
        scrollDirection = .horizontal
        minimumLineSpacing = Constants.spacing
        configureItemSize()
        configureInsets()
    }

    private func configureItemSize() {
        let width = bounds.height / Constants.scale
        let height = width
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
}
