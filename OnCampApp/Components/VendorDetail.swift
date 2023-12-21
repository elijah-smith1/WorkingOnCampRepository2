import SwiftUI

struct VendorDetail: View {
    let vendor: Vendor
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 10) {
                    // Header with title and back button
                    
                        Spacer()
                    Text(vendor.name)
                            .font(.title)
                            .bold()
                   
                        
                    
                    .padding(.horizontal)
                    .padding(.top, 20)
                    
                    
                    
                    // Vendor Description
                    Text(vendor.description)
                        .font(.body)
                        .padding([.horizontal, .bottom])

                    // Vendor Location
                    Text("Rating: \(vendor.rating)")
                        .font(.subheadline)
                        .padding(.horizontal)
                    
                    // Schools Serviced
                    Text("Schools Serviced:")
                        .font(.subheadline)
                        .bold()
                        .padding(.horizontal)
                    
                    ForEach(vendor.schools, id: \.self) { school in
                        Text(school)
                            .font(.caption)
                            .padding(.horizontal)
                    }
                    Button(action: {
                        // Messaging logic here
                    }) {
                        Text("Message Vendor")
                            .font(.headline)
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.blue)
                            .cornerRadius(10)
                    }
                    .padding(.horizontal)
                    .padding(.top, 10)
                    
                    Divider()
                        .padding(.vertical)
                    
                    // Items Section Title
                    Text("Items")
                        .font(.headline)
                        .padding(.horizontal)
                        .padding(.bottom, 5)
                    
                    // Items Grid
                    LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 15) {
                        ForEach(productList, id: \.id) { item in
                            SmallProductCard(product: item)
                        }
                    }
                    .padding(.horizontal)

                    // Message Button
                  
                }
            }
            .navigationBarHidden(true)
        }
    }
}

//struct VendorDetail_Previews: PreviewProvider {
//    static var previews: some View {
//        VendorDetail(
//
//        )
//    }
//}
