//
//  CartTableViewCell.swift
//  SleeperUIChallenge
//
//  Created by David Seitz Jr on 8/9/24.
//

import UIKit

class CartTableViewCell: UITableViewCell {
    var product: Product?
    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var productPriceLabel: UILabel!
    func loadDetails(for product: Product) {
        self.product = product
        productNameLabel.text = product.name
        productPriceLabel.text = "$\(product.price)"
        backgroundColor = .clear
    }
}
