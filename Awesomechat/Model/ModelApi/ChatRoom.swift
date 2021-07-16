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
    
    
    
    init(snapShot: DataSnapshot) {
        self.roomId = snapShot.key
        self.chatMessages = (snapShot.children.allObjects as? [DataSnapshot])?.map { ChatMessage(snapshot: $0) } ?? []
        
        print(snapShot.children.allObjects)
        print(roomId)
        
        // Sử dụng For để load lại data khi lấy Mesenger cuối cùng: 
//        for items in chatMessages {
//            print(items.messageId)
//            print(items.idReceiver)
//        }
        
        
        // Dùng Mảng Chats .first để chạy vào cái mảng đấy 1 lần để lây đc IDReceiver và request đến User
        // MARK: Request tới node User qua IdReceiver:
        
        
        if let firstMessage = self.chatMessages.first {
            
            
            print(firstMessage.idReceiver)
            print(firstMessage.idSender)
            print(firstMessage.messageId)
            print(firstMessage.messageId)
            print(firstMessage.messenger) // lấy cái mesenger cuối cùng: 
            
            self.requestToUser(idReceiver: firstMessage.idReceiver)
            
            
            
            // Lấy id của người chat cùng mình bằng cách so sánh idSender và idReceiver với id của mình
//            let participantId = firstMessage?.idSender == myId ? firstMessage?.idReceiver : firstMessage?.idSender
            // Khởi tạo participant từ id
        
            
            
        }
        
        
    }
    
    
    func requestToUser(idReceiver: String) {
        let refUser: DatabaseReference!
        refUser = Database.database().reference()
        
        refUser.child("users/\(idReceiver)").getData(completion: { (error, snapShot) in
            guard error == nil else {
                return
            }
            print(snapShot.children.allObjects)
            print(snapShot.value)
            
            let dataSnapsotUser = DataUser(snapShot: snapShot)
            
            print(dataSnapsotUser.userName)
            print(dataSnapsotUser.userImgUrl)
            
            
            
        })
       
    }
}
