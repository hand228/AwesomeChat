//
//  RequestApiUser.swift
//  Awesomechat
//
//  Created by LongDN on 01/07/2021.
//

import Foundation
import Firebase
import FirebaseAuth

class ServerApiUserMessenger {
    static let shared = ServerApiUserMessenger()
    
    var arrayLocalUser: [DataUser] = []
    let auth = Auth.auth().currentUser
    
    func requestApiUserMessenger(completionHandle: @escaping ([String]) -> Void) {
        var arrayKeyUser: [String] = []
        
        let ref: DatabaseReference?
        ref = Database.database().reference()
        ref?.child("users").getData(completion: { (error, dataSnapshot) in
            
            guard error == nil else {
                return
            }
            
            let listUser = (dataSnapshot.children.allObjects as? [DataSnapshot])?.map {
                DataUser(snapShot: $0)
                
            }
            self.arrayLocalUser = listUser ?? []
            print(self.arrayLocalUser)
                
            self.requestMesengerss(completionHandle: { (dataArray, dataa) in
                
            })
      
            
        })
    }
    
    func requestMesengerss(completionHandle: @escaping ( [String], [ChatRoom] ) -> Void ) {
        let ref: DatabaseReference!
        ref = Database.database().reference()
        ref.child("chats").getData(completion: { (error, snapShot) in
            
            guard error == nil else {
                return
            }
            
            
            // khi gọi như này thì luồng code sẽ chạy vào messenge trước và set data cho nó rồi mới gọi đến chatRoom:
            let chatRooms = (snapShot.children.allObjects as? [DataSnapshot])?.map {
                ChatRoom(snapShot: $0)
                
            }
            
            //print(chatRooms?.count)
            DispatchQueue.main.async {
                
            }
            
            
        })
    }
    
    
}
