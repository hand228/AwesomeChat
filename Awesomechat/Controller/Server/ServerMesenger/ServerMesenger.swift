//
//  ServerMesenger.swift
//  Awesomechat
//
//  Created by LongDN on 08/07/2021.
//

import Foundation
import Firebase

class ServerMesenger: NSObject {
    let curenDate = Date()
    let currenTime = DateComponents()
    let dateFormater = DateFormatter()
    
    
    func requestMesenger(completionHandle: @escaping ([[String: Any]], [String], [[DataChats]]) -> Void ) {
        var arrayDictionary: [[String: Any]] = [[:]]
        var arrayKeyReceiver: [String] = []
        
        var arrayChats: [[DataChats]] = [[]]
        let ref: DatabaseReference!
        ref = Database.database().reference()
        
        ref.child("chats").getData(completion: { (error, snapShot) in
            guard error == nil else {
                return
            }
            
            guard let dataSnapShot = snapShot.value as? [String: Any] else {
                return
            }
            
            print(dataSnapShot)
            
            var index: Int = 0
            
            for itemsKey in dataSnapShot.keys {
                
                ref.child("chats").child(itemsKey).getData(completion: { (error, dataSnapshotRes) in
                    guard error == nil else {
                        return
                    }
                    
                    for item in dataSnapshotRes.children {
                        let dataChats = DataChats(snapshot: item as! DataSnapshot)
                        arrayChats[0].append(dataChats)
                        print(dataChats)
                    }
                    
                    print(arrayChats)
                })
                arrayKeyReceiver.append(itemsKey)
                
                guard let dataItems = dataSnapShot[itemsKey] as? [String: Any] else {
                    return
                }
                arrayDictionary.append(dataItems)
                
                DispatchQueue.main.async {
                    completionHandle(arrayDictionary, arrayKeyReceiver, arrayChats)
                    index += 1
                }
                
                
            }
            
            // CallBack về màn Messenger
            DispatchQueue.main.async {
                
                
            }
        })
        
        
    }
        
    func pushDataChat(completion: @escaping () -> Void ) {
        let push: DatabaseReference?
        push = Database.database().reference()
        
        guard let auth = Auth.auth().currentUser else {
            return
        }
        
        var dataName: String = ""
        var dataImgUrl: String = ""
        // khi mà người dùng có cái key nó sẽ check và lây ra đc cái name, messenger,
        push?.ref.child("users").child("8O8hSnKCo9gQEBX0YP5S6w0Kpht2").getData(completion: { (error, snaShot) in
            guard error == nil else {
                return
            }
            
            guard let dataValue = snaShot.value as? [String: Any] else {
                return
            }
            dataName = dataValue["userName"] as! String
            dataImgUrl = dataValue["userImgUrl"] as! String
            
            
            
        })
        
        
        let post = [
            "date": currenTime.day ?? "",
            "idReceiver": "QSFbk8Dk6EZCGhtpKqDFxJmu4Zq1",
            "idSender": auth.uid,
            "messenger": "chat A Chat B",
            "time": currenTime.minute ?? "",
            "timeLong": curenDate.timeIntervalSinceReferenceDate ,
            "name": ""
            
        ] as [String : Any]
        
        
        let postName = [
            "name": dataName,
            "userImgUrl": dataImgUrl
        ]
        
        push?.child("chats").child(auth.uid + "8O8hSnKCo9gQEBX0YP5S6w0Kpht2").updateChildValues(postName)
        
        push?.child("chats").child(auth.uid + "8O8hSnKCo9gQEBX0YP5S6w0Kpht2").child((push?.childByAutoId().key)!).updateChildValues(post)
        push?.child("chats").child(auth.uid + "WlEkV4tu2YMsMv6ZDVeulbbokS73").child((push?.childByAutoId().key)!).updateChildValues(post)
        push?.child("chats").child(auth.uid + "pyu5EQyuQvVr6ke0oFwow1a1SHG2").child((push?.childByAutoId().key)!).updateChildValues(post)
        
        
    }
    
}



