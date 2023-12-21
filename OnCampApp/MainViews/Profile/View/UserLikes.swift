//
//  User Post View.swift
//  OnCampApp
//
//  Created by Michael Washington on 10/14/23.
//

import SwiftUI
import Firebase
import FirebaseFirestore


struct UserLikesView: View {
    @StateObject var viewmodel = ProfileViewModel()
    @State var userPosts = [Post]()
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 0) {
                    ForEach(viewmodel.userLikes, id: \.id) { post in
                        PostCell(post: post)
                    
                    }
                }
            }
        }




        }

    }

struct UserLikesViewPreviews: PreviewProvider {
    static var previews: some View {
        UserLikesView()
          
    }
}
