//
//  Marketplace.swift
//  OnCampApp
//
//  Created by Michael Washington on 10/12/23.
//

import SwiftUI

struct Marketplace: View {
    @State var selectedCategory = "AUCS"
    
    var body: some View {
        NavigationView{
            ScrollView {
                VStack{
                    HStack{
                        Spacer()
                        
                        Spacer()
                        
                        Text("Vendor")
                            .foregroundColor(.blue)
                            .padding(.trailing, -8.0)
                        Text("Hub")
                        
                        Spacer()
                        
                        Image(systemName: "line.3.horizontal")
                            .padding()
                    }
                    .font(.system(size: 30))
                    .padding(30)
                    
                }
                //Category List
                CategoryList()
                
                //Collections View
                HStack {
                    
                    Text("Category Name")
                        .font(.system(size: 24))
                    
                    Spacer()
                    NavigationLink {
                        Collections()
                        
                    }label: {
                        Image(systemName: "arrow.right")
                            .imageScale(.large)
                    }
                    
                    
                }
                .padding(.horizontal,30)
                .padding(.vertical,15)
                
                //Product List
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        ForEach(productList, id: \.id) {item in
                            ProductCard(product: item)
                        }
                    }
                }
            }
        }
    }
}
struct Marketplace_Previews: PreviewProvider {
    static var previews: some View {
        Marketplace()
    }
}
