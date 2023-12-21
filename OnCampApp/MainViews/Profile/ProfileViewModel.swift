





import Foundation
import FirebaseAuth
import FirebaseFirestore

@MainActor
class ProfileViewModel: ObservableObject {
    @Published var userPosts: [Post] = []
    @Published var userReposts: [Post] = []
    @Published var userLikes: [Post] = []
    var uid = Auth.auth().currentUser!.uid

    // Removed the Task from init and created a separate method to load posts
    func loadUserPosts() {
        Task {
            await fetchUserPostData()
        }
    }
  
    func fetchUserPostData() async {
        do {
            let userPostIDs = try await PostData.fetchPostsforUID(Uid: uid)
            self.userPosts = try await PostData.fetchPostData(for: userPostIDs)
            print("Debug:: POSTS \(self.userPosts)")
        } catch {
            print("Error fetching user posts: \(error)")
        }
        
        do {
            let userRepostIDs = try await PostData.fetchRepostsforUID(Uid: uid)
            self.userReposts = try await PostData.fetchPostData(for: userRepostIDs)
            print("Debug:: REPOSTS \(self.userReposts)")
        } catch {
            print("Error fetching user reposts: \(error)")
        }
        
        do {
            let userLikesIDs = try await PostData.fetchLikesforUID(Uid: uid)
            self.userLikes = try await PostData.fetchPostData(for: userLikesIDs)
            print("Debug:: Likes \(self.userLikes)")
        } catch {
            print("Error fetching user likes: \(error)")
        }
    }
}
