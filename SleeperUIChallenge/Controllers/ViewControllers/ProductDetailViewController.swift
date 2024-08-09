//
//  ProductDetailViewController.swift
//  SleeperUIChallenge
//
//  Created by David Seitz Jr on 8/9/24.
//

import UIKit

class ProductDetailViewController: UIViewController {
    var product: Product?

    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var productPriceLabel: UILabel!
    @IBOutlet weak var productDescriptionLabel: UILabel!
    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var addToCartButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
          productImageView.layer.cornerRadius = productImageView.frame.width / 15
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let product = product {
            productNameLabel.text = product.name
            productDescriptionLabel.text = product.description
            productPriceLabel.text = String("$\(product.price)")
            productImageView.image = ImageProvider.getImage(for: product)
        }
        addToCartButton.backgroundColor = Constants.Color.lightPurple.value
        addToCartButton.tintColor = Constants.Color.darkPurple.value
        addToCartButton.layer.cornerRadius = addToCartButton.frame.height/Constants.Size.primaryButtonCornerRadius.rawValue

        cancelButton.tintColor = UIColor(red: 217/255, green: 126/255, blue: 126/255, alpha: 1)

        view.backgroundColor = UIColor(red: 249/255, green: 255/255, blue: 250/255, alpha: 1)

        productNameLabel.textColor = Constants.Color.darkerPurple.value
        productPriceLabel.textColor = Constants.Color.darkerPurple.value
    }

    @IBAction func closeButtonTapped(_ sender: Any) {
        dismiss(animated: true)
    }
    
    @IBAction func addToCartButtonTapped(_ sender: Any) {
        guard let product = product else {
            fatalError("Failed to get product while adding to cart.")
        }
        CartManager.addToCart(product)
        dismiss(animated: true)
    }
}
