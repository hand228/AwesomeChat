//
//  DataUser.swift
//  Awesomechat
//
//  Created by LongDN on 01/07/2021.
//

import Foundation
import Firebase

struct DataUser {
    var stautus: String
    var userDateOfBirth: String
    var userEmail: String
    var userId: String
    var userImgUrl: String
    var userName: String
    var userPhone: String
    
    init(snapShot: DataSnapshot) {
        
        let snapShotValue = snapShot.value as? [String: Any]
        self.stautus = snapShotValue?["stautus"] as! String
        self.userDateOfBirth = snapShotValue?["userDateOfBirth"] as! String
        self.userEmail = snapShotValue?["userEmail"] as! String
        self.userId = snapShotValue?["userId"] as! String
        self.userImgUrl = snapShotValue?["userImgUrl"] as! String
        self.userName = snapShotValue?["userName"] as! String
        self.userPhone = snapShotValue?["userPhone"] as! String
        
        
    }
}

