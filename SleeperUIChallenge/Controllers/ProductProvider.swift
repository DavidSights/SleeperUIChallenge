//
//  ProductProvider.swift
//  SleeperUIChallenge
//
//  Created by David Seitz Jr on 8/7/24.
//

import Foundation

struct ProductProvider {
    
    static func getProducts() -> [Product]? {
        guard let url = Bundle.main.url(forResource: "products", withExtension: "json") else {
            print("Failed to locate products.json in bundle.")
            return nil
        }
        
        do {
            let data = try Data(contentsOf: url)
            let products = try JSONDecoder().decode([Product].self, from: data)
            return products
        } catch {
            print("Failed to load or decode products.json: \(error.localizedDescription)")
            return nil
        }
    }
}
