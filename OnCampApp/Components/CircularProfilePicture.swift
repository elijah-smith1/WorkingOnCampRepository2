//
//  CircularProfilePicture.swift
//  OnCampApp
//
//  Created by Michael Washington on 10/12/23.
//


import SwiftUI
import Kingfisher

struct CircularProfilePictureView: View {
    var profilePictureURL: URL?

    var body: some View {
        if let url = profilePictureURL {
            KFImage(url)
                .resizable()
                .scaledToFill()
                .clipShape(Circle())
        } else {
            Image(systemName: "person.circle.fill")
                .resizable()
                .scaledToFit()
                .clipShape(Circle())
                .foregroundColor(.gray)
        }
    }
}

struct CircularProfilePictureView_Previews: PreviewProvider {
    static var previews: some View {
        CircularProfilePictureView(profilePictureURL: URL(string: "https://example.com/profile.jpg"))
    }
}
