//
//  ProductListTableViewController.swift
//  SleeperUIChallenge
//
//  Created by David Seitz Jr on 8/8/24.
//

import UIKit

class ProductListTableViewController: UITableViewController {
    var products: [Product]?

    // MARK: - View Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        products = ProductProvider.getProducts()
        title = "Shop"

        let viewCartButton = UIBarButtonItem(title: "View Cart", 
                                             style: .plain,
                                             target: self,
                                             action: #selector(tappedViewCartButton))
        navigationItem.rightBarButtonItem = viewCartButton
        viewCartButton.isHidden = true
        viewCartButton.tintColor = Constants.Color.darkGreen.value

        CartManager.setDelegate(self)
        view.backgroundColor = Constants.Color.lighterPurple.value
        navigationController?.navigationBar.barTintColor = Constants.Color.lighterPurple.value
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: Constants.Color.darkerPurple.value]
    }

    @objc func tappedViewCartButton() {
        performSegue(withIdentifier: "Cart", sender: nil)
    }

    // MARK: - Segue

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        switch segue.identifier {
        case "ProductDetail":
            guard
                segue.identifier == "ProductDetail",
                let destination = segue.destination as? ProductDetailViewController,
                let indexPath = tableView.indexPathForSelectedRow else {
                fatalError("Unexpected destnation for product detail.")
            }
            destination.product = products?[indexPath.row]
        default:
            return
        }

    }

    // MARK: - Table View

    override func numberOfSections(in tableView: UITableView) -> Int {
        return self.products == nil ? 0 : 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.products?.count ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        super.tableView(tableView, cellForRowAt: indexPath)

        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ProductCell", for: indexPath) as? ProductTableViewCell,
              let products = self.products else {
            fatalError("Failed to get cell type or required products")
        }
        cell.prepareForReuse()
        cell.delegate = self
        cell.prepareCell(for: products[indexPath.row])
        return cell
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "ProductDetail", sender: nil)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

// MARK: - ProductTableViewCellDelegate

extension ProductListTableViewController: ProductTableViewCellDelegate {
    func showAddToCartAlert(_ alert: UIAlertController) {
        present(alert, animated: true)
    }
}

// MARK: - CartManagerDelegate

extension ProductListTableViewController: CartManagerDelegate {
    func didUpdateCart(showViewCart: Bool) {
        navigationItem.rightBarButtonItem?.isHidden = !showViewCart
    }
}
