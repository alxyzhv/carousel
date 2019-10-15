//
//  Discount.swift
//  Carousel
//
//  Created by Alexey Zhulikov on 15.10.2019.
//  Copyright © 2019 Alexey Zhulikov. All rights reserved.
//

import UIKit

struct Discount {
    let title: String
    let description: String
    let backgroundImageName: String

    var backgroundImage: UIImage? {
        return UIImage(named: backgroundImageName)
    }
}
