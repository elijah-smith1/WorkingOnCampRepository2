//
//  vendor preview.swift
//  OnCampApp
//
//  Created by Elijah Smith on 12/28/23.
//

import SwiftUI
import Kingfisher

struct VendorPreview: View {
    let vendor: Vendor

    var body: some View {
        NavigationLink(destination: VendorDetail(vendor: vendor)) {
            VStack(spacing: 8) {
                KFImage(URL(string: vendor.image ))
                    .resizable()
                    .placeholder {
                        Image("placeholder") // Replace with your placeholder image
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 300, height: 200)
                    }
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 300, height: 200)
                    .clipped()
                    .cornerRadius(8)
                    .padding(.top, 5)

                HStack {
                    VStack(alignment: .leading) {
                        Text(vendor.name)
                            .font(.headline)

                        Text(vendor.category)
                            .font(.caption)
                        
                        Text(vendor.description)
                            .font(.caption)
                    }
                    
                    Spacer()

                    // Pricing or other info
                    VStack(alignment: .trailing) {
                        Text("Avg. Price")
                            .font(.caption)

                        Text("$10 - $20")
                            .font(.caption)
                    }
                }
            }
            .padding()
            .background(Color.white)
            .cornerRadius(10)
            .shadow(radius: 5)
        }
    }
}


struct VendorPreview_Previews: PreviewProvider {
    static var previews: some View {
        VendorPreview(vendor: Vendor(description: "Description", schools: ["Morehouse","Spelman","Clark Atlanta"], name: "New Hairstylist", image: "https://source.unsplash.com/random/300x300", category: "Hair", rating: 4.3, featured: false))
    }
}
