//
//  inboxViewModel.swift
//  OnCampApp
//
//  Created by Elijah Smith on 11/17/23.
//

import Foundation
import FirebaseFirestoreSwift
import FirebaseFirestore


@MainActor
class inboxViewModel: ObservableObject{
    @Published var recentMessages: [Message] = []
    @Published var channels: [Channel] = []
    @Published var chats: [Chats] = []
    
    init(){
        Task {
            do {
                let channels = try await fetchChannels()
                self.channels = channels
                let chatIds = try await fetchChatIds()
                let recentMessages = try await fetchMostRecentMessages(forChatIds: chatIds)
                self.recentMessages = recentMessages
                    // Use the retrieved recent messages
                
                    print("Recent Messages: \(recentMessages)")
                // Use the retrieved chatIds
                print("Chat IDs: \(chatIds)")
            } catch {
                // Handle error
                print("Error fetching chat IDs: \(error)")
            }
            
        }
    }
    let db = Firestore.firestore()

       func fetchChatIds() async throws -> [String] {
           // Reference to the user's chats subcollection
           let userChatsRef = db.collection("Users").document(loggedInUid!).collection("chats")

           let snapshot = try await userChatsRef.getDocuments()

           return snapshot.documents.compactMap { document -> String? in
               // Assuming 'chatId' is a field in each document
               
               return document.get("chatId") as? String
               
              
           }
         
       }

    func fetchChannels() async throws -> [Channel] {
        let db = Firestore.firestore()
        // Reference to the "Channels" collection
        let channelRef = db.collection("Channels")
        // Attempt to fetch the documents
        let querySnapshot = try await channelRef.getDocuments()
        // Map each document to a Channel object
        let channels = try querySnapshot.documents.compactMap { document -> Channel? in
            try document.data(as: Channel.self)
        }
        return channels
    }
    func fetchChat(with chatId: String) async throws -> Chats {
        let db = Firestore.firestore()
        // Reference to the specific channel document in the "Channels" collection
        let channelRef = db.collection("Chats").document(chatId)
        // Attempt to fetch the document
        let documentSnapshot = try await channelRef.getDocument()
        // Directly decode the document into a Channel object
        let chat = try documentSnapshot.data(as: Chats.self)
        
        return chat
    }
  
    

        // Function to fetch the most recent message for each chatId
      
    func fetchMostRecentMessages(forChatIds chatIds: [String]) async throws -> [Message] {
        var recentMessages: [Message] = []

        for chatId in chatIds {
            let chatRef = db.collection("Chats").document(chatId)
            let messagesRef = chatRef.collection("messages")

            let querySnapshot = try await messagesRef
                .order(by: "timestamp", descending: true)
                .limit(to: 1)
                .getDocuments()

            if let document = querySnapshot.documents.first {
                var message = try document.data(as: Message.self)
                message.chatId = chatId  // Set the chat ID

                let chatDocument = try await chatRef.getDocument()
                if let participants = chatDocument.get("participants") as? [String] {
                    message.otherParticipantId = participants.first { $0 != loggedInUid }
                }

                recentMessages.append(message)
            }
        }

        return recentMessages
    }


    func fetchMostRecentMessage(forChannelId channelId: String) async throws -> Message {
        let db = Firestore.firestore()
        let chatRef = db.collection("Chats").document(channelId)
        let messagesRef = chatRef.collection("messages")

        let querySnapshot = try await messagesRef
            .order(by: "timestamp", descending: true)
            .limit(to: 1)
            .getDocuments()

        guard let document = querySnapshot.documents.first,
              var message = try? document.data(as: Message.self) else {
            // Handle the case where no messages are found or the message can't be decoded
            throw NSError(domain: "AppError", code: 0, userInfo: [NSLocalizedDescriptionKey: "No recent message found or decoding failed"])
        }

        return message
    }


}
