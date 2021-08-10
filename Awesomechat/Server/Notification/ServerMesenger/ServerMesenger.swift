//
//  ServerMesenger.swift
//  Awesomechat
//
//  Created by LongDN on 08/07/2021.
//

import Foundation
import Firebase

class ServerMesenger {
    func requestMesenger(completionHandle: @escaping ([ChatRoom] ) -> Void ) {
        let ref: DatabaseReference!
        ref = Database.database().reference()
        
        ref.child("chats").observe(.value, with: { (snapShot) in
            // khi gọi như này thì luồng code sẽ chạy vào messenge trước và set data cho nó rồi mới gọi đến chatRoom:
            let chatRooms = (snapShot.children.allObjects as? [DataSnapshot])?.map {
                ChatRoom(snapShot: $0)

            }
            DispatchQueue.main.async {
                completionHandle(chatRooms!)
            }
        })
//        ref.child("chats").getData(completion: { (error, snapShot) in
//
//            guard error == nil else {
//                return
//            }
//
//            // khi gọi như này thì luồng code sẽ chạy vào messenge trước và set data cho nó rồi mới gọi đến chatRoom:
//            let chatRooms = (snapShot.children.allObjects as? [DataSnapshot])?.map {
//                ChatRoom(snapShot: $0)
//
//            }
//            DispatchQueue.main.async {
//                completionHandle(chatRooms!)
//            }
//        })
    }
}



