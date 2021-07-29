//
//  ServerMesenger.swift
//  Awesomechat
//
//  Created by LongDN on 08/07/2021.
//

import Foundation
import Firebase

class ServerMesenger {
    func requestMesenger(completionHandle: @escaping ( [String], [DataUser] ) -> Void ) {
        
        let ref: DatabaseReference!
        ref = Database.database().reference()
        ref.child("chats").getData(completion: { (error, snapShot) in
            var messengerLasts: [String] = []
            var arrayUser: [DataUser] = []
            
            guard error == nil else {
                return
            }
            
            // khi gọi như này thì luồng code sẽ chạy vào messenge trước và set data cho nó rồi mới gọi đến chatRoom:
            let chatRooms = (snapShot.children.allObjects as? [DataSnapshot])?.map {
                ChatRoom(snapShot: $0, completionHandle: { (messengerLast, dataUser) in
                    
                    messengerLasts.append(messengerLast)
                    arrayUser.append(dataUser)
                })
                
                
            }
            
            DispatchQueue.main.async {
                completionHandle(messengerLasts, arrayUser)
            }
        })
    }
}



