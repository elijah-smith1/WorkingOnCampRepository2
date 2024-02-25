//
//  channelCell.swift
//  OnCampApp
//
//  Created by Elijah and Mike on 2/23/24.
//

import SwiftUI



struct ChannelCell: View {
    @StateObject var viewmodel = inboxViewModel()
    var channel: Channel
    @State var recentMessage: Message?
    
    
    var body: some View {
           NavigationStack {
               NavigationLink(destination: ChannelFeed(channel: channel)) {
                   Divider()
                   HStack {
                       // Profile picture placeholder
                       Image(systemName: "person.crop.circle.fill")
                           .resizable()
                           .frame(width: 40, height: 40)
                           .foregroundColor(.blue)
                       
                       // Channel name
                       VStack(alignment: .leading, spacing: 4) {
                           Text(channel.title)
                               .font(.headline)
                           
                           // Display recent message text and timestamp
                           if let recentMessage = recentMessage {
                               Text(recentMessage.content)
                                   .font(.subheadline)
                                   .foregroundColor(.gray)
                               
                               Text(PostData.shared.relativeTimeString(from: recentMessage.timestamp))

                                   .font(.caption)
                                   .foregroundColor(.secondary)
                           }
                       }
                       
                       Spacer()
                   }
                   .padding()
               }
           } .onAppear {
               // This is a better place to fetch the recent message asynchronously
               Task {
                   do {
                      let recentMessage1 = try await viewmodel.fetchMostRecentMessage(forChannelId: channel.id!)
                       recentMessage = recentMessage1
                   } catch {
                       print("Error fetching recent message: \(error)")
                   }
               }
           }
       }
   }
