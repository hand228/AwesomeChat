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
    
    let serverUser = ServerApiUser()
    
    
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
            print(firstMessage.messenger) // lấy cái mesenger cuối cùng
            
            
            self.requestToUser(completion: { (dataUser) in
                print(dataUser)
                
                DispatchQueue.main.async {
                    chatMessenger = dataUser
                    print(chatMessenger.append(firstMessage.date))
                    print(chatMessenger.append(firstMessage.messenger))
                    
                    print(chatMessenger)
                }
                
            }, idReceiver: firstMessage.idReceiver)
            
            // Lấy id của người chat cùng mình bằng cách so sánh idSender và idReceiver với id của mình
//            let participantId = firstMessage?.idSender == myId ? firstMessage?.idReceiver : firstMessage?.idSender
            // Khởi tạo participant từ id
        }
        
    }
    
    
    func requestToUser(completion: @escaping ([String]) -> Void, idReceiver: String) {
        let refUser: DatabaseReference!
        var arrayListUser: [String] = []
        
        
        refUser = Database.database().reference()
        
        refUser.child("users/\(idReceiver)").getData(completion: { (error, snapShot) in
            guard error == nil else {
                return
            }
            
            print(snapShot.children.allObjects)
            print(snapShot.value)
            
            print(self.serverUser.arrayLocalUser)
           
            let dataSnapsotUser = DataUser(snapShot: snapShot)
            print(dataSnapsotUser.userName)
            print(dataSnapsotUser.userImgUrl)
            arrayListUser.append(dataSnapsotUser.userName)
            arrayListUser.append(dataSnapsotUser.userImgUrl)
            
            DispatchQueue.main.async {
                completion(arrayListUser)
            }
        })
       
    }
}
