import SwiftUI

struct Social: View {
    
    let tabs = ["Events", "Trending", "Spotlight", "Bulletin Board"]
    @State private var selectedTabIndex = 0
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack {
                    HStack(spacing: 20) {
                        ForEach(tabs.indices) { index in
                            Text(tabs[index])
                                .foregroundColor(index == selectedTabIndex ? .blue : .black)
                                .underline(index == selectedTabIndex ? true : false, color: .blue)
                                .padding(.vertical, 10)
                                .onTapGesture {
                                    withAnimation {
                                        selectedTabIndex = index
                                    }
                                }
                        }
                    }
                    
                    switch selectedTabIndex {
                    case 0:
                        Events()
                    case 1:
                        EmptyView()
                    case 2:
                        EmptyView()
                    case 3:
                        EmptyView()
                    default:
                        Events()
                    }
                    
                    Spacer()
                }
                .padding(.bottom, 20)
            }
            .navigationBarItems(trailing: HStack {
                NavigationLink(destination: Search()) {
                    Image(systemName: "magnifyingglass")
                        .font(.system(size: 12))
                    
                }
                NavigationLink(destination: Notifications()) {
                    Image(systemName: "bell")
                        .font(.system(size: 12))
                      
                }
            })
        }
    }
}




struct Social_Previews: PreviewProvider {
    static var previews: some View {
        Social()
    }
}
