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
    var idReceive: String?
    var idSender: String?
    var messenger: String?
    var time: String?
    
    
    init(date: String, idReceive: String, idSender: String, messenger: String, time: String) {
        self.date = date
        self.idReceive = idReceive
        self.idSender = idSender
        self.messenger = messenger
        self.time = time
        
        
    }
    // MARK: Create cast dataSnapshot for Model
    init(snapshot: DataSnapshot) {
        
        let snapShotValue = snapshot.value as? [String: Any]
        
        self.date = snapShotValue?["date"] as? String
        self.idReceive = snapShotValue?["idReceive"] as? String
        self.idSender = snapShotValue?["idSender"] as? String
        self.messenger = snapShotValue?["messenger"] as? String
        self.time = snapShotValue?["time"] as? String
        
    }
    
    
    
}
