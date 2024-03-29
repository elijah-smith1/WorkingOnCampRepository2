//
//  PostsCell.swift
//  OnCampApp
//
//  Created by Michael Washington on 10/12/23.
//

import SwiftUI
import Firebase
import FirebaseFirestore
import Kingfisher



struct PostCell: View {
    @State private var isLiked: Bool = false
    var post: Post
    var user: User?
    
    var body: some View {
        let postId = post.id
        //let postedDate = postData.formatTimestamp(post.postedAt)
        
        NavigationLink(destination: DetailedPosts(post: post)) {
            VStack {
                HStack(alignment: .top, spacing: 12) {
                    CircularProfilePictureView(profilePictureURL: post.pfpUrl)
                        .frame(width: 64, height: 64)
                    
                    VStack(alignment: .leading, spacing: 4) {
                        HStack {
                            Text(post.username)
                                .font(.footnote)
                                .fontWeight(.semibold)
                            Spacer()
                            
                            Text(PostData.shared.relativeTimeString(from: post.postedAt))
                                .font(.caption)
                                .foregroundColor(Color("LTBL"))
                            
                            Button {
                                // Handle button action here
                            } label: {
                                Image(systemName: "ellipsis")
                                    .foregroundColor(Color("LTBL"))
                            }
                        }
                        
                        Text(post.postText)
                            .font(.footnote)
                            .multilineTextAlignment(.leading)
                        
                        if let mediaUrl = post.mediaUrl, let url = URL(string: mediaUrl) {
                            KFImage(url)
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 300, height: 200)
                                .clipped()
                                .cornerRadius(8)
                                .padding(.top, 5)
                        }
                        
                        
                        HStack(spacing: 16) {
                            Button {
                                isLiked.toggle() // Toggle the liked status
                                if isLiked {
                                    PostData.shared.likePost(postID: post.id!)
                                } else {
                                    // Implement unlike post logic
                                }
                            } label: {
                                Image(systemName: isLiked ? "heart.fill" : "heart")
                                    .foregroundColor(isLiked ? .red : Color("LTBL"))
                            }
                            Button {
                                // Handle button action here
                            } label: {
                                Image(systemName: "bubble.right")
                            }
                            Button {
                                PostData.shared.repostPost(postID: postId!)
                                // Handle button action here
                            } label: {
                                Image(systemName: "arrow.rectanglepath")
                            }
                            Button {
                                // Handle button action here
                            } label: {
                                Image(systemName: "paperplane")
                            }
                        }
                        .foregroundColor(Color("LTBL"))
                        .padding(.vertical, 8)
                    }
                }
                
                Divider()
            }
            .padding()
        }
    }
}


//struct PostCell_Previews: PreviewProvider {
//    static var previews: some View {
//        PostCell(
//            postText: "This is a sample post text",
//            likeCount: 42,
//            repostCount: 18,
//            commentCount: 7,
//            posterUid: "sampleuser123",
//            username: "x",
//            postedAt: Date(),
//            postId: "Q5902F7R5zmKyVK08BYq",
//            userId: "defaultUserId" // Provide a default value for userId in the preview
//        )
//    }
//}
