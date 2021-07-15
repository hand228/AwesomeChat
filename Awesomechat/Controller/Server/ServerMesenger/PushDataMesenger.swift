//
//  PushDataMesenger.swift
//  Awesomechat
//
//  Created by LongDN on 14/07/2021.
//

import Foundation
import Firebase

class PushDataMesenger {
    
    let curenDate = Date()
    let currenTime = DateComponents()
    let dateFormater = DateFormatter()
    
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

