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
    var arrayResuldListUser: [[String]] = [[]]
    
    init(snapShot: DataSnapshot ) {
        
        var chatMessenger: [String] = []
        self.roomId = snapShot.key
        self.chatMessages = (snapShot.children.allObjects as? [DataSnapshot])?.map { ChatMessage(snapshot: $0) } ?? []
        print(snapShot.children.allObjects)
        print(roomId)
        
        // Dùng Mảng Chats .first để chạy vào cái mảng đấy 1 lần để lây đc IDReceiver và request đến User
        // MARK: Request tới node User qua IdReceiver:
        if let firstMessage = self.chatMessages.last {
            
            print(firstMessage.idReceiver)
            print(firstMessage.idSender)
            print(firstMessage.messageId)
            print(firstMessage.date)
            print(firstMessage.messenger)
            
            
            for i in 0..<serverUserMessenger.arrayLocalUser.count {
                if (firstMessage.idReceiver == self.serverUserMessenger.arrayLocalUser[i].userId) {
                    print(serverUserMessenger.arrayLocalUser[i].userId)
                    
                    self.participant = serverUserMessenger.arrayLocalUser[i]
                    
                    chatMessenger.append(serverUserMessenger.arrayLocalUser[i].userName)
                    chatMessenger.append(serverUserMessenger.arrayLocalUser[i].userImgUrl)
                    chatMessenger.append(firstMessage.date)
                    chatMessenger.append(firstMessage.messenger)
                    chatMessenger.append(firstMessage.idReceiver)
                    
                    
                    print(participant)
                    
//                    participant[i].userId = firstMessage.idReceiver
//                    participant[i].userName = self.serverUserMessenger.arrayLocalUser[i].userName
//                    participant[i].userImgUrl = serverUserMessenger.arrayLocalUser[i].userImgUrl
                    
//                    print(self.participant[i].userId)
                    
                    
                }
            }
            
//            print(participant[2].userName)
//            print(participant[2].userImgUrl)
//            print(participant[2].userEmail)
            
            print(chatMessenger)
            
        }
        
        self.arrayResuldListUser.append(chatMessenger)
        
        
        //print(arrayResuldListUser)
        
        
    }
    
    
    
}






