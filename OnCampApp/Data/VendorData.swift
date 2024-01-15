//
//  VendorData.swift
//  OnCampApp
//
//  Created by Elijah Smith on 11/14/23.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift
import FirebaseFirestore


struct Vendor: Identifiable {
    @DocumentID var id: String?
    var description: String
    var schools: [String]
    var name: String
    var image: String
    var category: String
    var rating: Double
    var featured: Bool  // New field
}
@MainActor
class VendorData: ObservableObject{
    
    @Published var vendorsByCategory: [String: [Vendor]] = [:]
    
    
    func fetchVendorIds() async throws -> [String] {
        var vendorIds = [String]()
        let snapshot = try await Vendordb.getDocuments()
        for document in snapshot.documents { vendorIds.append(document.documentID) }
        print(vendorIds);return vendorIds
    }

    
    func getVendorData(vendorID: String) async throws -> Vendor {
        let db = Firestore.firestore()
        let vendorRef = db.collection("Vendors").document(vendorID)

        let document = try await vendorRef.getDocument()
        
        guard let data = document.data(), document.exists else {
            throw NSError(domain: "VendorError", code: 0, userInfo: [NSLocalizedDescriptionKey: "Document does not exist"])
        }
            print("Debug::: \(data)")
        return Vendor(
            id: document.documentID,
            description: data["description"] as? String ?? "",
            schools: data["schools"] as? [String] ?? [],
            name: data["name"] as? String ?? "",
            image: data["image"] as? String ?? "",
            category: data["category"] as? String ?? "",
            rating: data["rating"] as? Double ?? 0.0, 
            featured: data["featured"] as? Bool ?? false
        
        )
        
    }
    
    func fetchAllProducts(forVendor vendorId: String) async throws -> [Product] {
        let db = Firestore.firestore()
        let vendorProductsRef = db.collection("Vendors").document(vendorId).collection("Products")

        let querySnapshot = try await vendorProductsRef.getDocuments()
        let products = querySnapshot.documents.compactMap { document -> Product? in
            let data = document.data()
            guard let idString = data["id"] as? String,
                  let id = UUID(uuidString: idString),
                  let name = data["name"] as? String,
                  let category = data["category"] as? String,
                  let description = data["description"] as? String,
                  let image = data["image"] as? String,
                  let price = data["price"] as? Int else {
                return nil
            }
            return Product(id: id, name: name, category: category, description: description, image: image, price: price)
        }
        print(products)
        return products
    }
    
    func deleteProduct(fromVendor vendorId: String, productId: String) async throws {
        let db = Firestore.firestore()
        let productRef = db.collection("Vendors").document(vendorId).collection("Products").document(productId)

        do {
            try await productRef.delete()
            print("Product successfully deleted")
        } catch {
            throw error
        }
    }

    
    func addProduct(toVendor vendorId: String, product: Product) async throws {
        let db = Firestore.firestore()
        let vendorProductsRef = db.collection("Vendors").document(vendorId).collection("Products")

        let newProductData: [String: Any] = [
            "id": product.id.uuidString,  // Storing UUID as String
            "name": product.name,
            "category": product.category,
            "description": product.description,
            "image": product.image,
            "price": product.price
        ]

        do {
            _ = try await vendorProductsRef.addDocument(data: newProductData)
            print("Product successfully added")
        } catch {
            throw error
        }
    }

    

    func updateVendorInfo(vendor: Vendor) {
        guard let vendorID = vendor.id else {
            print("Vendor ID is missing.")
            return
        }

        let db = Firestore.firestore()
        let vendorRef = db.collection("Vendors").document(vendorID)

        // Check if the document exists
        vendorRef.getDocument { (document, error) in
            if let document = document, document.exists {
                // Document exists, update it
                vendorRef.updateData([
                    "description": vendor.description,
                    "schools": vendor.schools,
                    "name": vendor.name,
                    "image": vendor.image,
                    "category": vendor.category,
                    "rating": vendor.rating

                ]) { err in
                    if let err = err {
                        print("Error updating vendor: \(err)")
                    } else {
                        print("Vendor successfully updated")
                    }
                }
            } else {
                // Document does not exist, create a new one
                vendorRef.setData([
                    "description": vendor.description,
                    "schools": vendor.schools,
                    "name": vendor.name,
                    "image": vendor.image,
                    "category": vendor.category,
                    "rating": vendor.rating
                ]) { err in
                    if let err = err {
                        print("Error creating new vendor: \(err)")
                    } else {
                        print("Vendor successfully created")
                    }
                }
            }
        }
    }

   

    var sampleVendors: [Vendor] = [
        // Hair Vendors
        Vendor(id: nil, description: "Trendy hair styles and products", schools: ["Spelman", "Morehouse", "Clark Atlanta"], name: "Hair Glamour", image: "https://source.unsplash.com/random/300x300", category: "Hair", rating: 4.2, featured: true),
        Vendor(id: nil, description: "Luxury hair salon services", schools: ["Spelman", "Morehouse", "Clark Atlanta"], name: "Elegant Strands", image: "https://source.unsplash.com/random/300x300", category: "Hair", rating: 4.8, featured: false),
        Vendor(id: nil, description: "Affordable and stylish haircuts", schools: ["Spelman", "Morehouse", "Clark Atlanta"], name: "Barber's Edge", image: "https://source.unsplash.com/random/300x300", category: "Hair", rating: 4.1, featured: true),
        Vendor(id: nil, description: "Professional hair care products", schools: ["Spelman", "Morehouse", "Clark Atlanta"], name: "Hair Care Central", image: "https://source.unsplash.com/random/300x300", category: "Hair", rating: 4.5, featured: false),

        // Food Vendors
        Vendor(id: nil, description: "Gourmet sandwiches and salads", schools: ["Spelman", "Morehouse", "Clark Atlanta"], name: "Green Bites Cafe", image: "https://source.unsplash.com/random/300x300", category: "Food", rating: 4.3, featured: false),
        Vendor(id: nil, description: "Authentic Italian pizza", schools: ["Spelman", "Morehouse", "Clark Atlanta"], name: "Pizza Passion", image: "https://source.unsplash.com/random/300x300", category: "Food", rating: 4.7, featured: false),
        Vendor(id: nil, description: "Delicious vegan options", schools: ["Spelman", "Morehouse", "Clark Atlanta"], name: "Veggie Delight", image: "https://source.unsplash.com/random/300x300", category: "Food", rating: 4.6, featured: false),
        Vendor(id: nil, description: "Fresh and tasty sushi", schools: ["Spelman", "Morehouse", "Clark Atlanta"], name: "Sushi World", image: "https://source.unsplash.com/random/300x300", category: "Food", rating: 4.2, featured: true),

        // Fashion Vendors
        Vendor(id: nil, description: "Latest in trendy fashion", schools: ["Spelman", "Morehouse", "Clark Atlanta"], name: "Fashion Forward", image: "https://source.unsplash.com/random/300x300", category: "Fashion", rating: 4.4, featured: false),
        Vendor(id: nil, description: "Exclusive designer apparel", schools: ["Spelman", "Morehouse", "Clark Atlanta"], name: "Designer Hub", image: "https://source.unsplash.com/random/300x300", category: "Fashion", rating: 4.9, featured: false),
        Vendor(id: nil, description: "Affordable stylish clothing", schools: ["Spelman", "Morehouse", "Clark Atlanta"], name: "Budget Fashionista", image: "https://source.unsplash.com/random/300x300", category: "Fashion", rating: 4.0, featured: false),
        Vendor(id: nil, description: "Urban and streetwear styles", schools: ["Spelman", "Morehouse", "Clark Atlanta"], name: "Urban Trends", image: "https://source.unsplash.com/random/300x300", category: "Fashion", rating: 4.3, featured: true),

        // Other Vendors
        Vendor(id: nil, description: "Custom artwork and prints", schools: ["Spelman", "Morehouse", "Clark Atlanta"], name: "Artistic Expressions", image: "https://source.unsplash.com/random/300x300", category: "Other", rating: 4.5, featured: false),
        Vendor(id: nil, description: "Professional photography services", schools: ["Spelman", "Morehouse", "Clark Atlanta"], name: "Capture the Moment", image: "https://source.unsplash.com/random/300x300", category: "Other", rating: 4.7, featured: false),
        Vendor(id: nil, description: "Expert fitness training", schools: ["Spelman", "Morehouse", "Clark Atlanta"], name: "Fit and Fab", image: "https://source.unsplash.com/random/300x300", category: "Other", rating: 4.6, featured: false),
        Vendor(id: nil, description: "Reliable tech repair services", schools: ["Spelman", "Morehouse", "Clark Atlanta"], name: "Tech Savvy Repairs", image: "https://source.unsplash.com/random/300x300", category: "Other", rating: 4.1, featured: false),
        Vendor(id: nil, description: "Handmade jewelry and accessories", schools: ["Spelman", "Morehouse", "Clark Atlanta"], name: "Jewel Creations", image: "https://source.unsplash.com/random/300x300", category: "Other", rating: 4.8, featured: false),
        Vendor(id: nil, description: "Quality second-hand books", schools: ["Spelman", "Morehouse", "Clark Atlanta"], name: "Book Haven", image: "https://source.unsplash.com/random/300x300", category: "Other", rating: 4.3, featured: false),
        Vendor(id: nil, description: "Eco-friendly cleaning services", schools: ["Spelman", "Morehouse", "Clark Atlanta"], name: "Green Cleaners", image: "https://source.unsplash.com/random/300x300", category: "Other", rating: 4.2, featured: false),
        Vendor(id: nil, description: "Professional event planning", schools: ["Spelman", "Morehouse", "Clark Atlanta"], name: "Event Masters", image: "https://source.unsplash.com/random/300x300", category: "Other", rating: 4.5, featured: true)
    ]
    func sortSampleVendorsByCategory() {
            for vendor in sampleVendors {
                vendorsByCategory[vendor.category, default: []].append(vendor)
            }
        }
   
    
}
let mockVendor = Vendor(
    id: "BLOOBLOo", // This should be a unique ID
    description: "A test vendor",
    schools: ["School1", "School2"],
    name: "Test Vendor",
    image: "image_url",
    category: "TestCategory",
    rating: 4.5,
    featured: false
)
