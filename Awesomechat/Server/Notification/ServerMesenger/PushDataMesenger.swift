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
    
    func pushDataChat(completion: @escaping (_ chatMessagas: ChatMessage) -> Void, messenger: String, idReceiver: String, idSender: String, idChatRoom: String, type: String) {
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
        let timeInterverData = date.timeIntervalSince1970
        let timeInterver: Int = Int(timeInterverData)
        
        
        print(timeInterver)
        //let auth = Auth.auth().currentUser
        
        let post = [
            "date": dateFormatter.string(from: date),
            "idReceiver": idReceiver,
            "idSender": idSender,
            "messenger": messenger,
            "time": timeFormatter.string(from: date),
            "timeLong": timeInterver,
            "type": type,
            "isRead": "false"
        ] as [String : Any]
        print(idChatRoom)
       push?.child("chats").child(idChatRoom).child((push?.childByAutoId().key)!).updateChildValues(post)
        
        
        let chatMessager = ChatMessage(messageId: "", idSender: idSender, idReceiver: idReceiver, messenger: messenger, date: dateFormatter.string(for: date) ?? "", time: timeFormatter.string(from: date), timeLong: timeInterver, type: type, isRead: "false")
        
        DispatchQueue.main.async {
            completion(chatMessager)
        }
    }
    
//    func pushDataRoomIDFirst(idFriendChat: String) {
//
//    }
    
    
    
}

