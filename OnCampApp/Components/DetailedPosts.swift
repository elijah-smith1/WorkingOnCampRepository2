//
//  DetailedPosts.swift
//  OnCampApp
//
//  Created by Michael Washington on 10/23/23.
//

import SwiftUI
import Firebase
import FirebaseFirestore

struct DetailedPosts: View {
    var post: Post
    @State private var commentText: String = ""
    @State private var comments: [Comment] = []
    @State private var listener: ListenerRegistration?

    var body: some View {
        let postId = post.id!
        VStack {
            DetailedPostCell(post: post)

            ForEach(comments, id: \.self) { comment in
                DetailedCommentCell(comment: comment)
            }

            Rectangle()
                .foregroundColor(Color(.separator))
                .frame(width: UIScreen.main.bounds.width, height: 0.75)

            HStack {
                TextField("Reply...", text: $commentText)
                    .textFieldStyle(PlainTextFieldStyle())
                    .font(.body)
                    .frame(minHeight: 30)

                Button(action: {
                    PostData.shared.createComment(postID: postId, commentText: commentText)
                    print(commentText)
                }) {
                    Text("Send")
                        .bold()
                        .foregroundColor(Color("LTBL"))
                }
            }
            .padding(.bottom, 8)
            .padding(.horizontal)
        }
        .onAppear {
            listener = PostData.shared.listenToComments(forPost: postId) { newComments in
                comments = newComments
            }
        }
        .onDisappear {
            listener?.remove()
        }
    }
}


//struct DetailedPosts_Previews: PreviewProvider {
//    static var previews: some View {
//        DetailedPosts()
//    }
//}
