//
//  ProductTableViewCell.swift
//  SleeperUIChallenge
//
//  Created by David Seitz Jr on 8/7/24.
//

import UIKit

protocol ProductTableViewCellDelegate: AnyObject {
    func showAddToCartAlert(_ alert: UIAlertController)
}

class ProductTableViewCell: UITableViewCell {
    var product: Product?
    weak var delegate: ProductTableViewCellDelegate?
    @IBOutlet weak var productPriceLabel: UILabel!
    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var addToCartButton: UIButton!

    func prepareCell(for product: Product) {
        self.product = product
        productNameLabel.text = product.name
        productPriceLabel.text = String("$\(product.price)")
        productImageView.image = ImageProvider.getImage(for: product)
        productImageView.layer.cornerRadius = productImageView.frame.width/10
        backgroundColor = .clear
        productNameLabel.textColor = Constants.Color.darkerPurple.value
        productPriceLabel.textColor = Constants.Color.darkerPurple.value
        addToCartButton.tintColor = Constants.Color.darkGreen.value
    }

    @IBAction func addToCartButtonTapped(_ sender: Any) {
        guard let product = product else { fatalError("Failed to get cart for cell.") }
        let alertController = UIAlertController(title: "Add to Cart", 
                                                message: "Are you sure you'd like to add \(product.name) to your cart?",
                                                preferredStyle: .alert)
        let yesAction = UIAlertAction(title: "Yes", style: .default) { _ in
            CartManager.addToCart(product)
        }

        let noAction = UIAlertAction(title: "Cancel", style: .cancel)
        alertController.addAction(yesAction)
        alertController.addAction(noAction)
        delegate?.showAddToCartAlert(alertController)
    }
}
