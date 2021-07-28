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
    
    init(snapShot: DataSnapshot, completionHandle: @escaping ([String], [DataUser]) -> Void ) {
        var messengerLast: [String] = []
        var arrayUser: [DataUser] = []
        self.roomId = snapShot.key
        self.chatMessages = (snapShot.children.allObjects as? [DataSnapshot])?.map { ChatMessage(snapshot: $0) } ?? []
        
        print(snapShot.children.allObjects)
        if let lastMessage = self.chatMessages.last {
            
            print(lastMessage.idReceiver)
            print(lastMessage.idSender)
            print(lastMessage.messageId)
            print(lastMessage.messenger) // lấy cái mesenger cuối cùng
            
            // Handle Data lấy cái IDReceiver để check
            let userReceiver = self.serverUser.arrayLocalUser.first(where: { $0.userId == lastMessage.idReceiver})
            
            guard let userReceivers = userReceiver else {
                return
            }
            messengerLast.append(lastMessage.messenger)
            arrayUser.append(userReceivers)
            
//            print((userReceiver?.userName ?? "") + "   " + (userReceiver?.userId ?? ""))
            
            
            
            
            
            // Lấy id của người chat cùng mình bằng cách so sánh idSender và idReceiver với id của mình
//            let participantId = firstMessage?.idSender == myId ? firstMessage?.idReceiver : firstMessage?.idSender
            // Khởi tạo participant từ id
            
            
        }
        print(messengerLast)
        print(arrayUser)
        
        DispatchQueue.main.async {
            completionHandle(messengerLast, arrayUser)
        }
    }
    
    
}
