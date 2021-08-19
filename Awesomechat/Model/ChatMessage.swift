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
    var messenger: String
    var date: String
    var time: String
    var timeLong: String
    
    init(snapshot: DataSnapshot) {
        self.messageId = snapshot.key
        self.idSender = snapshot.childSnapshot(forPath: "idSender").value as? String ?? ""
        self.idReceiver = snapshot.childSnapshot(forPath: "idReceiver").value as? String ?? ""
        self.messenger = snapshot.childSnapshot(forPath: "messenger").value as? String ?? ""
        self.date = snapshot.childSnapshot(forPath: "date").value as? String ?? ""
        self.time = snapshot.childSnapshot(forPath: "time").value as? String ?? ""
        self.timeLong = snapshot.childSnapshot(forPath: "timeLong").value as? String ?? ""
    }
}
