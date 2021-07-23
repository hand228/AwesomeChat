//
//  DataChats.swift
//  Awesomechat
//
//  Created by LongDN on 12/07/2021.
//

import Foundation
import Firebase


struct DataChats {
    var date: String?
    var idReceiver: String?
    var idSender: String?
    var messenger: String?
    var time: String?
    var timeLong: String?
    
    init(date: String, idReceiver: String, idSender: String, messenger: String, time: String, timeLong: String) {
        self.date = date
        self.idReceiver = idReceiver
        self.idSender = idSender
        self.messenger = messenger
        self.time = time
        self.timeLong = timeLong
        
    }
    // MARK: Create cast dataSnapshot for Model
    init(snapshot: DataSnapshot) {
        
        let snapShotValue = snapshot.value as? [String: Any]
        self.date = snapShotValue?["date"] as? String
        self.idReceiver = snapShotValue?["idReceiver"] as? String
        self.idSender = snapShotValue?["idSender"] as? String
        self.messenger = snapShotValue?["messenger"] as? String
        self.time = snapShotValue?["time"] as? String
        self.timeLong = snapShotValue?["timeLong"] as? String
    }
    
    
    
}
