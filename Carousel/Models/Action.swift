//
//  Action.swift
//  Carousel
//
//  Created by Alexey Zhulikov on 15.10.2019.
//  Copyright © 2019 Alexey Zhulikov. All rights reserved.
//

import UIKit

struct Action {

    let title: String
    let iconName: String

    var icon: UIImage? {
        return UIImage(named: iconName)
    }

}

