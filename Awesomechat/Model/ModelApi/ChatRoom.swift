//
//  ChatRoom.swift
//  Awesomechat
//
//  Created by HaND on 16/07/2021.
//

import Foundation
import Firebase

struct ChatRoom {
    var roomId: String
    var participant: DataUser?
    var chatMessages: [ChatMessage]
    
    init(snapShot: DataSnapshot) {
        // Snapshot là node con của chat
        // Ví dụ:
        // G1xnFxWAPHXiJjThVcf4hNp9NXm2AJnO7sIUdeUWeC9z74QnRc7sFDc2
        //     -MJFVWtxKatQEme5083X
        //     -MJFVXomWXwCSN-ex6fh
        //     -MJFVb-fzJVGAx912LHp
        self.roomId = snapShot.key
        self.chatMessages = (snapShot.children.allObjects as? [DataSnapshot])?.map { ChatMessage(snapshot: $0) } ?? []
        if let firstMessage = self.chatMessages.first {
            // Lấy id của người chat cùng mình bằng cách so sánh idSender và idReceiver với id của mình
//            let participantId = firstMessage?.idSender == myId ? firstMessage?.idReceiver : firstMessage?.idSender
            // Khởi tạo participant từ id
        }
    }
}
