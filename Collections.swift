//
//  Collections.swift
//  OnCampApp
//
//  Created by Michael Washington on 11/4/23.
//

import SwiftUI

struct Collections: View {
    @Environment(\.presentationMode) var mode
    
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
                        
                        Button {
                            mode.wrappedValue.dismiss()
                        } label: {
                            Image(systemName: "arrow.left")
                                .imageScale(.large)
                                .padding()
                                .frame(width: 70, height: 90)
                                .overlay(RoundedRectangle(cornerRadius: 50).stroke().opacity(0.4))
                        }
                        
                    }
                    .font(.system(size: 30))
                    .padding(30)
                    
                    LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], content: {
                        ForEach(productList, id: \.id) { item in
                            SmallProductCard(product: item)
                        }
                    })
                    .padding(.horizontal)

                }
            }
        }
    }
}

struct Collections_Previews: PreviewProvider {
    static var previews: some View {
        Collections()
    }
}
