//
//  Search.swift
//  letsgetrich
//
//  Created by Michael Washington on 9/13/23.
//

import SwiftUI

struct Search: View {
    @StateObject var viewmodel = searchViewModel()
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
                            
                            UserCell(user: user)
                            .padding(.bottom)
                            .padding(.top)
                            .padding(.leading)
                        Divider()
                        
                    }
                }
            } .searchable(text: $searchText, prompt: "Search Users")
                .onSubmit(of: .search, {

                })
           
            .navigationTitle("Search")
        }
       
    }
}

struct Search_Previews: PreviewProvider {
    static var previews: some View {
        Search()
    }
}
