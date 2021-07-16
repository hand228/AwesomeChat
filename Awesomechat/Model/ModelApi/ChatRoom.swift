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
        
        // self.chatMessages = ((snapShot.children.allObjects as? [DataSnapshot])!).map { ChatMessage(snapshot: <#T##DataSnapshot#>)}
        // chu ý đoạn này:
        print(snapShot.children.allObjects)
        print(roomId)
        
        // cái chatMessenges này sễ tra về danh sách nhóm cho mk,
        // Sử dụng For để load lại data:
        
        for items in chatMessages {
             
            print(items.messageId)
            print(items.idReceiver)
        
        }
        
        
        
        if let firstMessage = self.chatMessages.first {
            
            print(firstMessage.idReceiver)
            print(firstMessage.idSender)
            
            print(firstMessage.messageId)  // đây sẽ in ra cái Id toàn bộ. nhưng khi dùng chatMessengerFirst thì chỉ in ra đc mảng đầu tiên:
            
            
            // Lấy id của người chat cùng mình bằng cách so sánh idSender và idReceiver với id của mình
//            let participantId = firstMessage?.idSender == myId ? firstMessage?.idReceiver : firstMessage?.idSender
            // Khởi tạo participant từ id
        
        
        }
        
        
    }
    
}
