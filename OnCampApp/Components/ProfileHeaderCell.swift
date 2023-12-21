//
//  ProfileHeaderCell.swift
//  OnCampApp
//
//  Created by Michael Washington on 10/27/23.
//

import SwiftUI
import FirebaseFirestore


struct ProfileHeaderCell: View {
    let user: User?
    
    @StateObject var followFunc = UserData()
    @State private var followingStatus: String = "NotFollowing"

    var body: some View {
        
        VStack(spacing: 20) {
            HStack {
                VStack(alignment: .leading, spacing: 12) {
                    VStack(alignment: .leading, spacing: 4) {
                        Text(user!.username)
                            .font(.title2)
                            .fontWeight(.semibold)
                        
                        Text(user!.school)
                            .font(.subheadline)
                    }
                    
                    Text(user!.bio)
                        .font(.footnote)
                    
                    Text("5000 followers")
                        .font(.caption)
                        .foregroundColor(Color("LTBL"))
                }
                
                Spacer()
                
                CircularProfilePictureView()
                    .frame(width: 64, height: 64)
            }
            
            // Conditional button rendering
            if followingStatus == "Following" {
                           HStack {
                               Button("Unfollow") {
                                   Task {
                                       try await followFunc.followOrUnfollowUser(selectedUid: user?.id ?? "")
                                       followingStatus = "NotFollowing"
                                   }
                               }
                               .buttonStyle(CustomButtonStyle())

                               Button("Favorite") {
                                   // Implement favorite logic here
                                   Task {
                                       try await followFunc.favoriteOrUnfavoriteUser(selectedUid: user?.id ?? "")
                                       followingStatus = "FollowingAndFavorite"
                                   }
                               }
                               .buttonStyle(CustomButtonStyle())
                           }
                       } else if followingStatus == "FollowingAndFavorite" {
                           HStack {
                               Button("Unfollow") {
                                   Task {
                                       try await followFunc.followOrUnfollowUser(selectedUid: user?.id ?? "")
                                       followingStatus = "NotFollowing"
                                   }
                               }
                               .buttonStyle(CustomButtonStyle())

                               Button("Unfavorite") {
                                   // Implement unfavorite logic here
                                   Task {
                                       try await followFunc.favoriteOrUnfavoriteUser(selectedUid: user?.id ?? "")
                                       followingStatus = "Following"
                                   }
                               }
                               .buttonStyle(CustomButtonStyle())
                           }
                       } else if followingStatus == "NotFollowing" {
                           Button("Follow") {
                               Task {
                                   try await followFunc.followOrUnfollowUser(selectedUid: user?.id ?? "")
                                   followingStatus = "Following"
                               }
                           }
                           .buttonStyle(CustomButtonStyle())
                       } else if followingStatus == "OwnSelf" {
                       
                               HStack {
                                   NavigationLink(destination: editProfileView()){
                                       Button("Edit Profile") {
                                           
                                       }
                                       .buttonStyle(CustomButtonStyle())
                                   }
                               }
                           }
                       
                   }
                   .onAppear {
                       Task {
                           followingStatus = try await followFunc.checkFollowingAndFavoriteStatus(selectedUid: user?.id ?? "")
                       }
                   }
        .padding(.horizontal, 12.0)
    }
}

struct CustomButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.subheadline)
            .fontWeight(.semibold)
            .foregroundColor(Color("LTBLALT"))
            .frame(width: 170, height: 32)
            .background(Color("LTBL"))
            .cornerRadius(8)
    }
}

// Add your CircularProfilePictureView struct if it's not defined elsewhere

struct ProfileHeaderCell_Previews: PreviewProvider {
    static var previews: some View {
        ProfileHeaderCell(user: User(username: "username", bio: "bop", status: "status", school: "school", isVendor: false)/* Provide a sample user or nil */)
    }
}
