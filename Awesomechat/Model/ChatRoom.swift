//
//  ChatRoom.swift
//  Awesomechat
//
//  Created by HaND on 16/07/2021.
//

import Foundation
import Firebase

class ChatRoom {
    
    var roomId: String
    var participant: DataUser?
    var chatMessages: [ChatMessage]
    let serverUser = ServerApiUser.shared
    
    init(snapShot: DataSnapshot) {
        self.roomId = snapShot.key
        
        self.chatMessages = (snapShot.children.allObjects as? [DataSnapshot])?.map { ChatMessage(snapshot: $0) } ?? []
        
        if let lastMessage = self.chatMessages.last {
            guard let userReceiver = self.serverUser.arrayLocalUser.first(where: { $0.userId == lastMessage.idReceiver}) else {
                return
            }
            self.participant = userReceiver
        }
    }
    
}
