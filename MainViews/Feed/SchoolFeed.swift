//
//  SchoolFeed.swift
//  OnCampApp
//
//  Created by Elijah Smith on 1/13/24.
//

import SwiftUI

struct SchoolFeed: View {
    @ObservedObject var viewModel = feedViewModel()
    
    var body: some View {
        ScrollView {
                        VStack(spacing: 0) {
                            ForEach(viewModel.Posts, id: \.id) { post in
                                PostCell(post: post)
                            }
                        }
        }.onAppear{
            Task{
                do{
                    try await viewModel.fetchPublicPosts()
                }
            }
        }
    }
}

#Preview {
    SchoolFeed()
}
