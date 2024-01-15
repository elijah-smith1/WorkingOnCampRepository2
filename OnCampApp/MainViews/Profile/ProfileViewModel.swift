





import Foundation
import FirebaseAuth
import FirebaseFirestore

@MainActor
class ProfileViewModel: ObservableObject {
    @Published var userPosts: [Post] = []
    @Published var userReposts: [Post] = []
    @Published var userLikes: [Post] = []
    var uid = Auth.auth().currentUser!.uid
    
        private var followerListener: ListenerRegistration?
       private var followingListener: ListenerRegistration?

       @Published var followerCount: Int = 0
       @Published var followingCount: Int = 0

    init() {
        loadUserPosts()
    }
    // Removed the Task from init and created a separate method to load posts
    func loadUserPosts() {
        Task {
            await fetchUserPostData()
        }
    }
  

    
    func returnFollowerInfo( userId: String, completion: @escaping (Int?, Error?) -> Void) {
        
        let db = Firestore.firestore()

           // Reference to the subcollection
           let subcollectionRef = db.collection("Users").document(uid).collection("Followers")

           // Set up a listener to monitor changes in the subcollection
           let listener = subcollectionRef.addSnapshotListener { (querySnapshot, error) in
               if let error = error {
                   // Handle error
                   print("Error fetching subcollection: \(error.localizedDescription)")
                   completion(nil, error)
                   return
               }

               // Check if querySnapshot is not nil
               guard let querySnapshot = querySnapshot else {
                   completion(nil, nil)
                   return
               }

               // Get the count of documents in the subcollection
               let followerCount = querySnapshot.documents.count

               // Return the count
               completion(followerCount, nil)
           }

           // To stop listening when needed (e.g., when leaving the view)
           // listener.remove()
       }
    
    
    
    func returnFollowingInfo( userId: String, completion: @escaping (Int?, Error?) -> Void) {
        
        let db = Firestore.firestore()

           // Reference to the subcollection
           let subcollectionRef = db.collection("Users").document(uid).collection("Following")

           // Set up a listener to monitor changes in the subcollection
           let listener = subcollectionRef.addSnapshotListener { (querySnapshot, error) in
               if let error = error {
                   // Handle error
                   print("Error fetching subcollection: \(error.localizedDescription)")
                   completion(nil, error)
                   return
               }

               // Check if querySnapshot is not nil
               guard let querySnapshot = querySnapshot else {
                   completion(nil, nil)
                   return
               }

               // Get the count of documents in the subcollection
               let followingCount = querySnapshot.documents.count

               // Return the count
               completion(followingCount, nil)
           }

           // To stop listening when needed (e.g., when leaving the view)
           // listener.remove()
       }
    
    func setupListeners(forUserID userID: String) {
        setupFollowerListener(userID: userID)
        setupFollowingListener(userID: userID)
    }

    func tearDownListeners() {
        followerListener?.remove()
        followingListener?.remove()
    }

    private func setupFollowerListener(userID: String) {
        let db = Firestore.firestore()
        let followerRef = db.collection("Users").document(userID).collection("Followers")

        followerListener = followerRef.addSnapshotListener { [weak self] (querySnapshot, error) in
            guard let self = self else { return }

            if let error = error {
                print("Error fetching Followers: \(error.localizedDescription)")
                return
            }

            guard let querySnapshot = querySnapshot else { return }

            self.followerCount = querySnapshot.documents.count
        }
    }

    private func setupFollowingListener(userID: String) {
        let db = Firestore.firestore()
        let followingRef = db.collection("Users").document(userID).collection("Following")

        followingListener = followingRef.addSnapshotListener { [weak self] (querySnapshot, error) in
            guard let self = self else { return }

            if let error = error {
                print("Error fetching Following: \(error.localizedDescription)")
                return
            }

            guard let querySnapshot = querySnapshot else { return }

            self.followingCount = querySnapshot.documents.count
        }
    }

    
    
    func fetchUserPostData() async {
        do {
            let userPostIDs = try await PostData.fetchPostsByUser(userId: uid)
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
