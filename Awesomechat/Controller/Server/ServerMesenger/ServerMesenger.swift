//
//  ServerMesenger.swift
//  Awesomechat
//
//  Created by LongDN on 08/07/2021.
//

import Foundation
import Firebase

class ServerMesenger {
    
    func requestMesenger(completionHandle: @escaping ( [String], [ChatRoom] ) -> Void ) {
        var arrayKeyReceiver: [String] = []
        var arrayChatRoom: [ChatRoom] = []
        
        let ref: DatabaseReference!
        ref = Database.database().reference()
        ref.child("chats").getData(completion: { (error, snapShot) in

            guard error == nil else {
                return
            }

            // khi gọi như này thì luồng code sẽ chạy vào messenge trước và set data cho nó rồi mới gọi đến chatRoom:
            var chatRooms = (snapShot.children.allObjects as? [DataSnapshot])?.map {
                ChatRoom(snapShot: $0)

                print("aa")
                // Handle Request Api User:
            }
            print(chatRooms?.count)
            
            //print(chatRooms?.chatMessages)
//            //let snapshotChat = ChatMessage(snapshot: snapShot)
//            let snapshotChatRoom = ChatRoom(snapShot: snapShot)
//            // guard let dataSnapshotChỉden = snapshotChatRoom.
//            print(snapshotChatRoom.chatMessages[0].idReceiver)
//            print(snapshotChatRoom.chatMessages[0].messageId)
//            print("aaa" + snapshotChatRoom.roomId)
//            print(snapshotChatRoom.chatMessages)

            DispatchQueue.main.async {
                
            }
        })
    }
}



