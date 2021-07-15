//
//  ServerMesenger.swift
//  Awesomechat
//
//  Created by LongDN on 08/07/2021.
//

import Foundation
import Firebase

class ServerMesenger: NSObject {
    
    func requestMesenger(completionHandle: @escaping ( [String], [DataChats]) -> Void ) {
        var arrayKeyReceiver: [String] = []
        var arrayChats: [DataChats] = []
        
        let ref: DatabaseReference!
        ref = Database.database().reference()
        ref.child("chats").getData(completion: { (error, snapShot) in
            guard error == nil else {
                return
            }
            
            guard let dataSnapshot = snapShot.value as? [String: Any] else {
                return
            }
            
            for itemsKey in dataSnapshot.values {
                print(itemsKey)
                guard let dataChatKey = itemsKey as? [String: Any] else {
                    return
                }
                for itemsKeyss in dataChatKey.values {
                    
                    // lấy ra đc định dạng của model ở đoạn này:
                    print(itemsKeyss)
                    guard let dataItemSnapshot = itemsKeyss as? DataSnapshot else {
                        return
                    }
                    
                }
            }
            
            // CallBack về màn Messenger
            DispatchQueue.main.async {
                
                
            }
            
        })
    }
}



