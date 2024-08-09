//
//  CartViewController.swift
//  SleeperUIChallenge
//
//  Created by David Seitz Jr on 8/9/24.
//

import UIKit

class CartViewController: UIViewController {
    @IBOutlet weak var cartListTableView: UITableView!
    @IBOutlet weak var completePurchaseButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Cart"
        cartListTableView.delegate = self

        let clearCartButton = UIBarButtonItem(title: "Clear", 
                                              style: .plain,
                                              target: self,
                                              action: #selector(clearCartButtonTapped))
        navigationItem.rightBarButtonItem = clearCartButton
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        cartListTableView.reloadData()
        if CartManager.numberOfItemsInCart() > 0 { navigationItem.rightBarButtonItem?.isHidden = false }
        completePurchaseButton.backgroundColor = Constants.Color.lightPurple.value
        completePurchaseButton.tintColor = Constants.Color.darkPurple.value
        completePurchaseButton.layer.cornerRadius = completePurchaseButton.frame.height/3
    }

    @IBAction func completePurchaseButtonTapped(_ sender: Any) {
        CartManager.purchaseCart { [weak self] success in
            switch success {
            case true:
                DispatchQueue.main.async {
                    self?.cartListTableView.reloadData()
                    self?.navigationItem.rightBarButtonItem?.isHidden = true
                }
            case false:
                print("Failed to purchase cart.")
            }
        }
    }

    @objc func clearCartButtonTapped() {
        let alert = UIAlertController(title: "Clear Cart",
                                      message: "Are you sure you'd like to clear your cart?",
                                      preferredStyle: .alert)
        let yesAction = UIAlertAction(title: "Yes", style: .default) { [weak self] _ in
            CartManager.clearCart()
            self?.cartListTableView.reloadData()
            self?.navigationItem.rightBarButtonItem?.isHidden = true
        }
        let noAction = UIAlertAction(title: "Cancel", style: .cancel)
        alert.addAction(yesAction)
        alert.addAction(noAction)
        present(alert, animated: true)
    }
}

extension CartViewController: UITableViewDataSource, UITableViewDelegate {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return CartManager.numberOfItemsInCart() + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CartCell", for: indexPath) as? CartTableViewCell else {
            fatalError("Failed to get CartCell from tableView")
        }
        cell.prepareForReuse()
        if indexPath.row == CartManager.numberOfItemsInCart() {
            // Total row
            cell.productNameLabel.text = ""
            cell.productPriceLabel.text = "Total: $\(String(format: "%.2f", CartManager.totalPriceOfCart()))"
        } else {
            guard let product = CartManager.product(for: indexPath.row) else {
                fatalError("Failed to get expected product for cart cell")
            }
            cell.loadDetails(for: product)
        }

        return cell
    }

    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return indexPath.row < CartManager.numberOfItemsInCart()
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        switch editingStyle {
        case .delete:
            guard let cell = tableView.cellForRow(at: indexPath) as? CartTableViewCell,
                  let product = cell.product else {
                fatalError("Failed to get expected cart cell for deletion")
            }
            CartManager.removeFromCart(product)
            tableView.deleteRows(at: [indexPath], with: .automatic)
            let totalIndexPath = IndexPath(row: CartManager.numberOfItemsInCart(), section: indexPath.section)
            tableView.reloadRows(at: [totalIndexPath], with: .automatic)
            if CartManager.numberOfItemsInCart() == 0 { navigationItem.rightBarButtonItem?.isHidden = true }
        default:
            return
        }
    }
}
