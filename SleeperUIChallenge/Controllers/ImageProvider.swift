//
//  ImageProvider.swift
//  SleeperUIChallenge
//
//  Created by David Seitz Jr on 8/9/24.
//

import UIKit

/// Handles fetching and providing images for products.
struct ImageProvider {

    static func getImage(for product: Product) -> UIImage? {
        return UIImage(named: product.image)
    }
}
