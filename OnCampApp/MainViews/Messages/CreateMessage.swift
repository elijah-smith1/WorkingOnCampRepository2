//
//  CreateMessage.swift
//  OnCampApp
//
//  Created by Michael Washington on 10/17/23.
//

import SwiftUI

struct CreateMessage: View {
    @StateObject var viewmodel = NewMessageViewModel()
    @Binding var showChatView: Bool
    @Environment(\.presentationMode) var mode
    @State private var searchText = ""
    
   
    
    
    
    var filteredUsers: [User] {
        if searchText.isEmpty {
            return viewmodel.users
        } else {
            return viewmodel.users.filter { $0.username.localizedCaseInsensitiveContains(searchText) }
        }
    }
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 0) {
                    ForEach(filteredUsers, id: \.username) { user in
                       
                            UserChatCell(user: user)
                        Divider()
                        
                    }
                }
            }
           
            .navigationTitle("New Message")
        }
        .searchable(text: $searchText, prompt: "Search Users")
            .onSubmit(of: .search, {

            })
    }
}


struct CreateMessage_Previews: PreviewProvider {
    static var previews: some View {
        CreateMessage(showChatView: .constant(false))
    }
}
