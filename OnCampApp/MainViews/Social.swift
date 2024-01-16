import SwiftUI

struct Social: View {
    let tabs = ["Events", "Trending", "Spotlight", "Bulletin Board"]
    @State private var selectedTabIndex = 0
    @State private var searchText = ""
    @State private var showingSearchView = false

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack {
                    TabsView(tabs: tabs, selectedTabIndex: $selectedTabIndex)
                    contentSwitcherView
                }
                .padding(.bottom, 20)
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    NavigationLink(destination: Messages()) {
                        Image(systemName: "message")
                            .font(.system(size: 18))
                    }
                }
                ToolbarItem(placement: .principal) {
                    TextField("Search...", text: $searchText)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .onTapGesture {
                            showingSearchView = true
                        }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink(destination: Notifications()) {
                        Image(systemName: "bell")
                            .font(.system(size: 18))
                    }
                }
            }
            .sheet(isPresented: $showingSearchView) {
                Search() // Ensure this view exists and is correct
            }
        }
    }

    var contentSwitcherView: some View {
        Group {
            switch selectedTabIndex {
            case 0:
                AnyView(Events())
            case 1:
                AnyView(EmptyView())
            case 2:
                AnyView(EmptyView())
            case 3:
                AnyView(EmptyView())
            default:
                AnyView(Events())
            }
        }
    }
}

struct TabsView: View {
    let tabs: [String]
    @Binding var selectedTabIndex: Int

    var body: some View {
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
    }
}

struct Social_Previews: PreviewProvider {
    static var previews: some View {
        Social()
    }
}
