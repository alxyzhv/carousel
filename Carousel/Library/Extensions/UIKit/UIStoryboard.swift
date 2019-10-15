//
//  UIStoryboard.swift
//  Carousel
//
//  Created by Alexey Zhulikov on 11/10/2019.
//  Copyright © 2019 Alexey Zhulikov. All rights reserved.
//

import UIKit

extension UIStoryboard {

    static func instantiate<T: UIViewController>(ofType: T.Type) -> T {
        let storyboard = UIStoryboard(name: String(describing: T.self), bundle: nil)
        guard let viewController = storyboard.instantiateInitialViewController() as? T else {
            fatalError("Can't instantiate \(T.self) from storyboard")
        }
        return viewController
    }

}
