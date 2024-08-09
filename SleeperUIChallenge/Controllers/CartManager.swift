//
//  CartManager.swift
//  SleeperUIChallenge
//
//  Created by David Seitz Jr on 8/9/24.
//

import Foundation

protocol CartManagerDelegate: AnyObject {
    func didUpdateCart(showViewCart: Bool)
}

/// Managers a cart, which stores products for the user to purchase.
struct CartManager {
    private static var cart = [Product]()
    private static var shared = CartManager()
    fileprivate weak var delegate: CartManagerDelegate?

    static func setDelegate(_ delegate: CartManagerDelegate) {
        shared.delegate = delegate
    }

    static func addToCart(_ product: Product) {
        if cart.filter({ $0.id == product.id }).count == 0 {
            cart.append(product)
            print("Cart updated: \(cart)")
        } else {
            print("\(product.name) already exists in cart.")
        }
        shared.delegate?.didUpdateCart(showViewCart: true)
    }

    static func product(for index: Int) -> Product? {
        return cart[index]
    }

    static func removeFromCart(_ product: Product) {
        cart.removeAll { $0.id == product.id }
        print("Removed \(product.name) from cart.")
        shared.delegate?.didUpdateCart(showViewCart: cart.count > 0)
    }

    static func clearCart() {
        cart = [Product]()
        print("Cleared all products from cart.")
        shared.delegate?.didUpdateCart(showViewCart: false)
    }

    static func numberOfItemsInCart() -> Int {
        return cart.count
    }

    static func totalPriceOfCart() -> Double {
        return cart.map { $0.price }.reduce(0, +)
    }

    static func purchaseCart(completion: ((_ success: Bool) -> Void)?) {
        // Assume some network logic that returns success.
        completion?(true)
        clearCart()
        print("Successfully purchased cart.")
        shared.delegate?.didUpdateCart(showViewCart: false)
    }

    // Dev note: How about quantity for each item?
}
