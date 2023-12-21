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
    let comment : Comment
    
    var body: some View {
        VStack {
            HStack {
                CircularProfilePictureView()
                    .frame(width: 40, height: 40)
                    .padding(.leading, 18.0)
                
                Text(viewModel.username.isEmpty ? "Loading..." : viewModel.username)
                
                Spacer()
                
                Text("2m ago")
                    .padding(.trailing, 18.0)
                
            }
            .padding(.top, 18.0)
            
            HStack{
                Text(comment.text)
                    .padding(.leading, 18.0)
                
                Spacer()
                
                Text("1900")
                Image(systemName: "heart")
                Image(systemName: "paperplane")
                    .padding(.trailing, 18.0)
            }
            .padding(.top, 5.0)
            
            HStack {
                Text("View Replies (3)...")
                    .font(.footnote)
                    .foregroundColor(.gray)
                    .padding(.leading, 18.0)
                    .padding(.top, 3.0)
                Spacer()
            }
            
            
            Divider()
            
            Spacer()
        }
    }
}

struct DetailedCommentCell_Previews: PreviewProvider {
    static var previews: some View {
        let sampleTimestamp = Timestamp(date: Date())
        return DetailedCommentCell(comment: Comment(id: "", commenterUid: "", text: "Text", timeSent: sampleTimestamp, commentReposts: 0, commentLikes: 0))
    }
}
