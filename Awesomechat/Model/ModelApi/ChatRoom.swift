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
    let serverUserMessenger = ServerApiUserMessenger.shared
    
    init(snapShot: DataSnapshot, completionHandle: @escaping ( String ,DataUser) -> Void) {
        
        self.roomId = snapShot.key
        self.chatMessages = (snapShot.children.allObjects as? [DataSnapshot])?.map { ChatMessage(snapshot: $0) } ?? []
        print(snapShot.children.allObjects)
        print(roomId)
        
        // Dùng Mảng Chats .last để chạy vào cái mảng đấy 1 lần để lây đc IDReceiver và request đến User
        // MARK: Request tới node User qua IdReceiver:
        if let lastMessage = self.chatMessages.last {
            
            print(lastMessage.idReceiver)
            print(lastMessage.idSender)
            print(lastMessage.messageId)
            print(lastMessage.date)
            print(lastMessage.messenger)
            
            // dùng array.firstWhere()
            guard let data = self.serverUserMessenger.arrayLocalUser.first(where: { $0.userId == lastMessage.idReceiver}) else {
                return
                
            }
            
            self.participant = data
            print(participant)
            
            print(data.userId)
            print(data.userEmail)
            
            DispatchQueue.main.async {
                completionHandle(lastMessage.messenger, self.participant!)
            }
            
        }
        
    }
    
}






