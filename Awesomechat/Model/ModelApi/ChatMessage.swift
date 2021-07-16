//
//  ChatMessage.swift
//  Awesomechat
//
//  Created by HaND on 16/07/2021.
//

import Foundation
import Firebase

struct ChatMessage {
    var messageId: String
    var idSender: String
    var idReceiver: String
    
    init(snapshot: DataSnapshot) {
        self.messageId = snapshot.key
        self.idSender = snapshot.childSnapshot(forPath: "idSender").value as? String ?? ""
        self.idReceiver = snapshot.childSnapshot(forPath: "idReceiver").value as? String ?? ""
        
//        let snapShotData = snapshot.value as? [String: Any]
//        self.idSender = snapShotData?["idSender"] as? String ?? ""
//        self.idReceiver = snapShotData?["idReceiver"] as? String ?? ""
    }
}
