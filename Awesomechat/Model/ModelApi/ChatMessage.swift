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
        messageId = snapshot.key
        idSender = snapshot.childSnapshot(forPath: "idSender").value as? String ?? ""
        idReceiver = snapshot.childSnapshot(forPath: "idReceiver").value as? String ?? ""
    }
}
