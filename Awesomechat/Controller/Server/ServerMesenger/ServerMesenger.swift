//
//  ServerMesenger.swift
//  Awesomechat
//
//  Created by LongDN on 08/07/2021.
//

import Foundation
import Firebase

class ServerMesenger: NSObject {
    
    func requestMesenger(completionHandle: @escaping ([[String: Any]], [String], [DataChats]) -> Void ) {
        var arrayDictionary: [[String: Any]] = [[:]]
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
            
//            print(snapShot.key)
//            print(snapShot.childrenCount)
//            print(snapShot.children)
//            print(snapShot.ref)
//            print(snapShot.priority)
//            print(snapShot.value)
            
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
            
            
            
            
            
//            for itemsKey in dataSnapShot.keys {
//                ref.child("chats").child(itemsKey).getData(completion: { (error, dataSnapshotRes) in
//                    guard error == nil else {
//                        return
//                    }
//                    for item in dataSnapshotRes.children {
//                        let dataChats = DataChats(snapshot: item as! DataSnapshot)
//                        arrayChats.append(dataChats)
//                        print(dataChats)
//                    }
//                    print(arrayChats)
//                })
//                arrayKeyReceiver.append(itemsKey)
//
//                guard let dataItems = dataSnapShot[itemsKey] as? [String: Any] else {
//                    return
//                }
//                arrayDictionary.append(dataItems)
//                DispatchQueue.main.async {
//                    completionHandle(arrayDictionary, arrayKeyReceiver, arrayChats)
//                }
//            }
            
            
            
            // CallBack về màn Messenger
            DispatchQueue.main.async {
                
                
            }
            
            
        })
        
        
        //ref.child("chats").queryEnding(atValue: <#T##Any?#>)
        
    }
}



