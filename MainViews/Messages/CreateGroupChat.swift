//
//  CreateGroupChat.swift
//  OnCampApp
//
//  Created by Elijah Smith on 1/8/24.
//

import SwiftUI

struct CreateGroupChat: View {
    @StateObject var viewmodel = NewMessageViewModel()
    @State private var selectedUsers: [User] = []
    @State private var searchText = ""
    @State private var newChannel: Channel?
    @State private var navigateToChannel = false
    var filteredUsers: [User] 
    {
        if searchText.isEmpty {
            return viewmodel.users
        } else {
            return viewmodel.users.filter { $0.username.localizedCaseInsensitiveContains(searchText) }
        }
    }
    
    var body: some View {
        
        NavigationStack {
            ScrollView {
                // Display selected users
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        Text("To:").font(.headline)
                        ForEach(selectedUsers, id: \.username) { user in
                            Text(user.username)
                                .padding(.vertical, 4)
                                .padding(.horizontal, 8)
                                .background(Capsule().fill(Color.blue))
                                .foregroundColor(.white)
                                .onTapGesture {
                                    selectUser(user: user) // Allow deselection by tapping
                                }
                        }
                    }
                    .padding()
                }
                VStack(spacing: 0) {
                    ForEach(filteredUsers, id: \.username) { user in
                        UserChannelCell(user: user).onTapGesture {
                            selectUser(user: user)
                        }
                        Divider()
                    }
                }
            }
            .navigationTitle("New Message")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    
                        Button("Create Chat") {
                            Task{
                                do{
                                    await createChatWithSelectedUsers()
                                }
                            }
                        }
                        .disabled(selectedUsers.isEmpty) // Disable the button if no users are selected
                    }
                
            }
            NavigationLink(destination: ChannelFeed( channel: newChannel ?? Channel(participants: [], senders: [], security: "", title: "String", description: "String", imageUrl: "")), isActive: $navigateToChannel) {
                    EmptyView()
               }
        .padding()
        }
        .searchable(text: $searchText, prompt: "Search Users")
        .onSubmit(of: .search, {
            // Handle search submission if needed
        })
    }
    
    func selectUser(user: User) {
        if selectedUsers.contains(where: { $0.username == user.username }) {
            selectedUsers.removeAll { $0.username == user.username }
        } else {
            selectedUsers.append(user)
        }
    }
    
    func createChatWithSelectedUsers() async {
        print("Creating chat with users: \(selectedUsers.map { $0.username })")
        
        Task {
            do {
                let newchannel = try await viewmodel.createGroupChat(for: selectedUsers)
                print("Chat created with ID: \(newchannel)")
                selectedUsers = []
                self.newChannel = newchannel
                self.navigateToChannel = true
            } catch {
                print("Failed to create chat: \(error)")
                // Handle errors, e.g., show an error message to the user
            }
        }
    }

}

// Assume UserChannelCell, NewMessageViewModel, and User are defined elsewhere

#Preview {
    CreateGroupChat()
}
