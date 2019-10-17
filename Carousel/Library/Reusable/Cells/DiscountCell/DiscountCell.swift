//
//  DiscountCell.swift
//  Carousel
//
//  Created by Alexey Zhulikov on 15.10.2019.
//  Copyright © 2019 Alexey Zhulikov. All rights reserved.
//

import UIKit

final class DiscountCell: UICollectionViewCell {

    // MARK: - Subviews

    @IBOutlet private weak var containerView: UIView!
    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var descriptionLabel: UILabel!

    // MARK: - UIView

    override func awakeFromNib() {
        super.awakeFromNib()
        configureAppearance()
    }

    // MARK: - Configuration

    func configure(title: String, description: String, image: UIImage?) {
        titleLabel.text = title
        descriptionLabel.text = description
        imageView.image = image
    }

    // MARK: - Private Configuration

    private func configureAppearance() {
        containerView.layer.cornerRadius = 8
        containerView.layer.masksToBounds = true
    }

}
