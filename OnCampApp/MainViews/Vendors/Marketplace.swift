import SwiftUI

// Assuming the Vendor and CategoryModel structs are defined elsewhere in your project

struct Marketplace: View {
    @State var selectedCategory = "AUCS"
    @StateObject var vendorData = VendorData()

    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    // Header with Search
                    HStack {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.gray)

                        TextField("Search for vendors...", text: $selectedCategory)
                            .textFieldStyle(RoundedBorderTextFieldStyle())

                        Spacer()

                        NavigationLink(destination: EmptyView()) {
                            Image(systemName: "line.3.horizontal")
                                .padding()
                        }
                    }
                    .padding()
                    .background(Color.white)

                    // Categories Scroller
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 20) {
                            ForEach(categoryList, id: \.id) { category in
                                Button(action: {
                                    selectedCategory = category.title
                                }) {
                                    CategoryItem(category: category)
                                }
                            }
                        }
                        .padding()
                    }
                    .background(Color.white)

                    // Dynamically create VendorSection views based on categories
                    ForEach(vendorData.vendorsByCategory.keys.sorted(), id: \.self) { category in
                        VendorSection(title: category, vendors: vendorData.vendorsByCategory[category] ?? [])
                    }
                }
            }
            .navigationBarHidden(true)
        }
        .onAppear {
            vendorData.sortSampleVendorsByCategory()
        }
    }
}

struct VendorSection: View {
    var title: String
    var vendors: [Vendor]

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(title)
                .font(.headline)
                .padding(.horizontal)

            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(vendors, id: \.name) { vendor in
                        VendorPreview(vendor: vendor)
                    }
                }
                .padding(.horizontal)
            }
        }
    }
}



struct CategoryItem: View {
    var category: CategoryModel

    var body: some View {
        VStack {
            // Replace with actual icon and title views
            Image(systemName: category.icon)
            Text(category.title)
        }
    }
}

struct Marketplace_Previews: PreviewProvider {
    static var previews: some View {
        Marketplace()
    }
}

// Add here any additional structs or extensions needed, such as CategoryModel, etc.
