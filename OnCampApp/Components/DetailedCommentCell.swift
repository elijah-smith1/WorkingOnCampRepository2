//
//  DetailedComment.swift
//  OnCampApp
//
//  Created by Michael Washington on 10/23/23.
//

import SwiftUI
import Firebase
import FirebaseFirestore

class CommentCellViewModel: ObservableObject {
    @StateObject var postData = PostData()
    @Published var username: String = ""
    
    func loadUsername(userId: String) {
        Task {
            do {
                let fetchedUsername = try await postData.fetchUsername(for: userId)
                DispatchQueue.main.async {
                    self.username = fetchedUsername
                }
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}

struct DetailedCommentCell: View {
    @StateObject var viewModel = CommentCellViewModel()
    @StateObject var postData = PostData()
    let comment: Comment
    
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                CircularProfilePictureView()
                    .frame(width: 32, height: 32)
                    .padding(.leading, 16.0)

                Text(viewModel.username.isEmpty ? "Loading..." : viewModel.username)
                    .font(.footnote)
                    .fontWeight(.semibold)

                Spacer()

                Text("timestamp here")
                    .font(.footnote)
                    .foregroundColor(.gray)
                    .padding(.trailing, 16.0)
            }
            .padding(.top, 8.0)

            Text(comment.text)
                .font(.body)
                .padding(.leading, 16.0)

            HStack {
                Spacer()

                Text("like count here")
                    .font(.caption)
                    .foregroundColor(.gray)
                    .padding(.trailing, 16.0)

                Image(systemName: "heart")
                    .imageScale(.small)

                Image(systemName: "paperplane")
                    .imageScale(.small)
                    .padding(.trailing, 16.0)
            }
            .padding(.top, 5.0)

            HStack {
                Text("View Replies here")
                    .font(.footnote)
                    .foregroundColor(.gray)
                    .padding(.leading, 16.0)
                    .padding(.top, 3.0)
                Spacer()
            }

            Divider()
        }
        .padding(.horizontal)
    }
}

struct DetailedCommentCell_Previews: PreviewProvider {
    static var previews: some View {
        let sampleTimestamp = Timestamp(date: Date())
        return DetailedCommentCell(comment: Comment(id: "", commenterUid: "", text: "Text", timeSent: sampleTimestamp, commentReposts: 0, commentLikes: 0))
    }
}
