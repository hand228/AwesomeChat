//
//  ServerMesenger.swift
//  Awesomechat
//
//  Created by LongDN on 08/07/2021.
//

import Foundation
import Firebase

class ServerMesenger: NSObject {
    
    func requestMesenger(completionHandle: @escaping ( [String], [ChatRoom] ) -> Void ) {
        var arrayKeyReceiver: [String] = []
        var arrayChatRoom: [ChatRoom] = []
        let ref: DatabaseReference!
        ref = Database.database().reference()
        ref.child("chats").getData(completion: { (error, snapShot) in
            
            guard error == nil else {
                return
            }
            
            //let snapshotChat = ChatMessage(snapshot: snapShot)
            
            let snapshotChatRoom = ChatRoom(snapShot: snapShot)
            
            // guard let dataSnapshotChỉden = snapshotChatRoom.
            print(snapshotChatRoom.chatMessages[0].idReceiver)
            
            print(snapshotChatRoom.chatMessages[0].messageId)
            print("aaa" + snapshotChatRoom.roomId)
            print(snapshotChatRoom.chatMessages)
            
            
            //var chatRooms = (snapShot.children.allObjects as? [DataSnapshot])?.map { ChatRoom(snapShot: $0) }
            
            
//
//            for itemsKey in dataSnapshot.values {
//                print(itemsKey)
//                guard let dataChatKey = itemsKey as? [String: Any] else {
//                    return
//                }
//                for itemsKeyss in dataChatKey.values {
//                    // lấy ra đc định dạng của model ở đoạn này:
//                    print(itemsKeyss)
//                    guard let dataItemSnapshot = itemsKeyss as? DataSnapshot else {
//                        return
//                    }
//                }
//            }
            
            
            DispatchQueue.main.async {
                
                
            }
            
        })
    }
}



