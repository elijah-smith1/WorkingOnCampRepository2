//
//  DetailedPostCell.swift
//  OnCampApp
//
//  Created by Michael Washington on 10/23/23.
//

import SwiftUI
import Firebase
struct DetailedPostCell: View {
    var post: Post

    var body: some View {
        let postId = post.id

        VStack(alignment: .leading, spacing: 8) {
            HStack {
                CircularProfilePictureView()
                    .frame(width: 40, height: 40)

                VStack(alignment: .leading, spacing: 2) {
                    Text(post.username)
                        .font(.headline)

                    Text("15m ago")
                        .font(.caption)
                        .foregroundColor(Color.gray)
                }

                Spacer()
            }
            .padding(.top, 16)

            Text(post.postText)
                .multilineTextAlignment(.leading)
                .padding(.top, 8)

            HStack(spacing: 20) {
                PostInteractionButton(imageName: "heart", action: {
                    PostData.shared.likePost(postID: postId!)
                })

                PostInteractionButton(imageName: "arrow.rectanglepath", action: {
                    PostData.shared.repostPost(postID: postId!)
                })

                PostInteractionButton(imageName: "paperplane", action: {
                    // Handle button action here
                })

                Spacer()

                Text("\(post.likeCount) likes • \(post.repostCount) reposts • \(post.commentCount) comments")
                    .font(.caption)
                    .foregroundColor(Color.gray)
            }
            .padding([.top, .leading], 16)

            Divider()
        }
        .foregroundColor(Color("LTBL"))
    }
}

struct PostInteractionButton: View {
    var imageName: String
    var action: () -> Void

    var body: some View {
        Button(action: action) {
            Image(systemName: imageName)
                .foregroundColor(Color("LTBL"))
                .font(.system(size: 22))
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
