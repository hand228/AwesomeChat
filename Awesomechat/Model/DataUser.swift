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
        
        self.stautus = snapShot.childSnapshot(forPath: "userStatus").value as? String ?? ""
        self.userDateOfBirth = snapShot.childSnapshot(forPath: "userDateOfBirth").value as? String ?? ""
        self.userEmail = snapShot.childSnapshot(forPath: "email").value as? String ?? ""
        self.userId = snapShot.childSnapshot(forPath: "userId").value as? String ?? ""
        self.userImgUrl = snapShot.childSnapshot(forPath: "userImgUrl").value as? String ?? ""
        self.userName = snapShot.childSnapshot(forPath: "userName").value as? String ?? ""
        self.userPhone = snapShot.childSnapshot(forPath: "userPhone").value as? String ?? ""
        
        
    }
}

