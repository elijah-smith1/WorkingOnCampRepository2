//
//  FeedViewModel.swift
//  OnCampApp
//
//  Created by Elijah Smith on 11/7/23.
//

import Foundation

@MainActor
class feedViewModel: ObservableObject {
    @Published var publicPosts: [Post] = []
    init() {
        Task{
           try await fetchPublicPosts()
        }
    }
    func fetchPublicPosts() async throws {
        do {
            // Call a method that gets public post IDs. Replace `fetchPublicPostsIDs` with your actual method name that returns [String]
            let postIDs = try await PostData.fetchPublicPosts()
            print(postIDs)
            // Then fetch the full Post objects using those IDs
            self.publicPosts = try await PostData.fetchPostData(for: postIDs)
            
        } catch {
            // Handle errors
            // For example, show an error message to the user
            print("Error fetching public posts: \(error)")
        }
    }
}

