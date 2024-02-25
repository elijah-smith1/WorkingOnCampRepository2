//
//  UserChannelCell.swift
//  OnCampApp
//
//  Created by Elijah and Mike on 2/12/24.
//

import Foundation
import SwiftUI

struct UserChannelCell: View {
    @StateObject var viewmodel = NewMessageViewModel()
    let user: User
    
   
/*make these comptible for group chats*/
    var body: some View {
        NavigationStack {
            VStack {
                // Invisible NavigationLink, activated by the shouldNavigate state
              
//                    NavigationLink(destination: Chat( chatId: chatId ?? "fuckedup"), isActive: $shouldNavigate) {
//                        EmptyView()
//                    }
//                
                // User information and tap gesture
                HStack {
                    CircularProfilePictureView(profilePictureURL: user.pfpUrl)
                        .frame(width: 40, height: 40)
                    
                    VStack(alignment: .leading, spacing: 4) {
                        Text(user.username)
                            .font(.system(size: 14, weight: .semibold))
                        
                        Text(user.status)
                            .font(.system(size: 15))
                    }
                    .font(.footnote)
                    .foregroundColor(Color("LTBL"))
                    
                    Spacer()
                }
                .padding(.horizontal)
                

            }
            .padding(.top)
        }
    }
}
