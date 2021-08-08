//
//  PushDataMesenger.swift
//  Awesomechat
//
//  Created by LongDN on 14/07/2021.
//

import Foundation
import Firebase
import FirebaseAuth

class PushDataMesenger {
    
    func pushDataChat(completion: @escaping () -> Void, messenger: String, idReceiver: String ) {
        let push: DatabaseReference?
        push = Database.database().reference()
        
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = .current
        dateFormatter.locale = .current
        dateFormatter.dateStyle = .short
        dateFormatter.dateFormat = "dd/MM/yyyy"
        
        let timeFormatter = DateFormatter()
        timeFormatter.dateStyle = .short
        timeFormatter.timeZone = .current
        timeFormatter.locale = .current
        timeFormatter.dateFormat = "HH:mm"
        let timeInterver = date.timeIntervalSince1970
        
        //let auth = Auth.auth().currentUser
        
        let post = [
            "date": dateFormatter.string(from: date),
            "idReceiver": idReceiver,
            "idSender": "cyAcaBvj5SbsEZwWOCvm0tsnPfT2",
            "messenger": messenger,
            "time": timeFormatter.string(from: date),
            "timeLong": timeInterver
            
        ] as [String : Any]
         
        push?.child("chats").child("cyAcaBvj5SbsEZwWOCvm0tsnPfT2" + idReceiver).child((push?.childByAutoId().key)!).updateChildValues(post)
        
    }
    
}

