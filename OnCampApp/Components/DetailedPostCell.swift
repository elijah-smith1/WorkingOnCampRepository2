//
//  DetailedPostCell.swift
//  OnCampApp
//
//  Created by Michael Washington on 10/23/23.
//

import SwiftUI
import Firebase
struct DetailedPostCell: View {
 
    
    var post : Post
    var body: some View {
        let postId = post.id
        
        VStack {
            
            HStack {
                CircularProfilePictureView()
                    .frame(width: 40, height: 40)
                
                
                Text(post.username)
                
                Spacer()
                
                Text("15m ago")
                
            }
            .padding(.top, 18.0)
            
           
            Text(post.postText)
                .multilineTextAlignment(.leading)
                .padding(.top, 30.0)
            
            
            
            HStack() {
                Button {
                    // Handle button action here
                    PostData.shared.likePost(postID: postId!)
                } label: {
                    Image(systemName: "heart")
                }
                
                Button {
                    PostData.shared.repostPost(postID: postId!)
                } label: {
                    Image(systemName: "arrow.rectanglepath")
                }
                Button {
                    // Handle button action here
                } label: {
                    Image(systemName: "paperplane")
                }
                Spacer()
                
                Text("\(post.likeCount) likes   \(post.repostCount) Reposts   \(post.commentCount) Comments")
                    .font(.footnote)

                   
            }
            .padding([.top, .leading], 18.0)
            .foregroundColor(Color("LTBL"))
            
            Divider()
        }
    }
}

//struct DetailedPostCell_Previews: PreviewProvider {
//    static var previews: some View {
//        DetailedPostCell(
//                        postText: "This is a sample post text",
//                          likeCount: 42,
//                          repostCount: 18,
//                          commentCount: 7,
//                          posterUid: "sampleuser123",
//                          username: "x",
//                          postedAt: Date(),
//                          postId: "4ljhkGhegmkmeHmLMmL2",
//                          userId: "defaultUserId")
//    }
//}
