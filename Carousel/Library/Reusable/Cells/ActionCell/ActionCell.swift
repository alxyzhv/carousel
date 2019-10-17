//
//  ActionCell.swift
//  Carousel
//
//  Created by Alexey Zhulikov on 11/10/2019.
//  Copyright © 2019 Alexey Zhulikov. All rights reserved.
//

import UIKit

final class ActionCell: UICollectionViewCell {

    // MARK: - Subviews

    @IBOutlet private weak var containerView: UIView!
    @IBOutlet private weak var iconContainerView: UIView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var iconImageView: UIImageView!
    
    // MARK: - UIView

    override func awakeFromNib() {
        super.awakeFromNib()
        configureAppearance()
    }

    // MARK: - Configuration

    func configure(title: String, icon: UIImage?) {
        titleLabel.text = title
        iconImageView.image = icon
    }

    // MARK: - Private Configuration

    private func configureAppearance() {
        containerView.layer.cornerRadius = 8
        containerView.layer.masksToBounds = true

        iconContainerView.layer.cornerRadius = iconContainerView.bounds.width / 2
        iconContainerView.layer.masksToBounds = true
    }

}
