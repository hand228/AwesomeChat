//
//  ServerMesenger.swift
//  Awesomechat
//
//  Created by LongDN on 08/07/2021.
//

import Foundation
import Firebase

//protocol PassDataDelegate {
//    func passDataDelegate(arrayUser: [DataUser])
//}

class ServerMesenger {
    
    var dataUsers: [DataUser] = []
    var lastMessenger: [String] = []
    var chatRoomData: [ChatRoom] = []
    
    func requestMesenger(completionHandle: @escaping ( [String], [DataUser]) -> Void ) {
            let ref: DatabaseReference!
            ref = Database.database().reference()
            ref.child("chats").getData(completion: { (error, snapShot) in
            guard error == nil else {
                return
            }
            
            // khi gọi như này thì luồng code sẽ chạy vào messenge trước và set data cho nó rồi mới gọi đến chatRoom:
            let chatRooms = (snapShot.children.allObjects as? [DataSnapshot])?.map {
                
                ChatRoom(snapShot: $0, completionHandle: { (lastMessenger ,dataUser)  in
                    print(dataUser)
                    self.lastMessenger.append(lastMessenger)
                    self.dataUsers.append(dataUser)
                    
                })
                
                // xử lý data ở trong đoạn này và thực hiện xong thì nó mới chạy xuống bên dưới.
                
            }
                print(self.dataUsers)
                
                DispatchQueue.main.async {
                    completionHandle(self.lastMessenger, self.dataUsers)
                
            }
        })
    }
    
}



