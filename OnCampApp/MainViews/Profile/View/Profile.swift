import SwiftUI



struct Profile: View {
    @EnvironmentObject var userData: UserData
    @State private var selectedFilter: ProfileTabFilter = .posts
    @Namespace var animation
    
    private let user: User
    
    init(user: User) {
        self.user = user
    }
    
    private var filterBarWidth: CGFloat {
        let count = CGFloat(ProfileTabFilter.allCases.count)
        return UIScreen.main.bounds.width / count
    }
    
    var body: some View {
        NavigationStack{
            ScrollView(showsIndicators: false) {
                VStack(spacing: 20) {
                    Spacer()
                    ProfileHeaderCell(user: user)
                    
                    // Filter Bar
                    HStack {
                        ForEach(ProfileTabFilter.allCases, id: \.self) { filter in
                            FilterBarButton(filter: filter, selectedFilter: $selectedFilter, animation: animation, filterBarWidth: filterBarWidth)
                        }
                    }
                    
                    // Content based on selected filter
                    switch selectedFilter {
                    case .posts:
                        UserPostsView() // Replace with actual view
                    case .reposts:
                        UserRepostsView(user: user) // Replace with actual view
                    case .likes:
                        UserLikesView() // Replace with actual view
                    }
                }
                .padding(.horizontal)
            }
        }
    }
}

struct FilterBarButton: View {
    let filter: ProfileTabFilter
    @Binding var selectedFilter: ProfileTabFilter
    var animation: Namespace.ID
    var filterBarWidth: CGFloat
    
    var body: some View {
        VStack {
            Text(filter.title)
                .font(.subheadline)
                .fontWeight(selectedFilter == filter ? .semibold : .regular)
            
            if selectedFilter == filter {
                Rectangle()
                    .foregroundColor(Color("LTBL"))
                    .frame(width: filterBarWidth, height: 1)
                    .matchedGeometryEffect(id: "filterIndicator", in: animation)
            } else {
                Rectangle()
                    .foregroundColor(.clear)
                    .frame(width: filterBarWidth, height: 1)
            }
        }
        .onTapGesture {
            withAnimation(.spring()) {
                selectedFilter = filter
            }
        }
    }
}

// Replace these with your actual views for posts, reposts, and likes

struct UserRepostsView: View {
    let user: User
    var body: some View { Text("User's Reposts") }
}


//struct Profile_Previews: PreviewProvider {
//    static var previews: some View {
//        Profile(user: sampleUser).environmentObject(UserData())
//    }
//}
