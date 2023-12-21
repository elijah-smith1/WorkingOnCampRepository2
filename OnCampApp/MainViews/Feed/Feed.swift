//
//  Home .swift
//  letsgetrich
//
//  Created by Michael Washington on 9/9/23.
//

import SwiftUI

struct Feed: View {
    
    
        let vendorData = VendorData()
       
    @StateObject var viewmodel = feedViewModel()
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 0) {
                    ForEach(viewmodel.publicPosts, id: \.id) { post in
                        PostCell(post: post)
                    
                    }
                }
            }
        } 
        .navigationTitle("posts")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    
                }label: {
                    Image(systemName: "arrow.counterclockwise")
                        .foregroundColor(Color("LTBL"))
                }
            }
        }
    }
    
}

struct Feed__Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack{
            Feed()
         
        }
    }
}
