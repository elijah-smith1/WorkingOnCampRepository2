//
//  Product.swift
//  OnCampApp
//
//  Created by Michael Washington on 11/4/23.
//

import Foundation
import SwiftUI
import FirebaseFirestore
import FirebaseFirestoreSwift


struct Product: Identifiable {
    var id: UUID = .init()
    var name: String
    var category: String
    var image: String
    var price: Int
    var color: Color
}

var productList = [
    Product(name: "Rolling Tray", category: "AUCS", image: "vendor1", price: 30, color: .red),
    Product(name: "Papers Pack", category: "AUCS", image: "vendor2", price: 8, color: .blue),
    Product(name: "Single Pack Of Papers", category: "AUCS", image: "vendor3", price: 4, color: .yellow),
    Product(name: "Grinder", category: "AUCS", image: "vendor4", price: 8, color: .green),
    Product(name: "Rolling Tray", category: "AUCS", image: "vendor5", price: 8, color: .pink),
    Product(name: "LaceFront Install", category: "hair", image: "vendor6", price: 85, color: .purple),
    Product(name: "Chips", category: "store", image: "vendor7", price: 4, color: .black),
    Product(name: "Shirt", category: "clothes", image: "vendor8", price: 35, color: .brown),
    Product(name: "Shirt", category: "clothes", image: "vendor9", price: 45, color: .indigo),

]
