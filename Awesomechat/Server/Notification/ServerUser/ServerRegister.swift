//
//  ServerRegister.swift
//  Awesomechat
//
//  Created by LongDN on 02/07/2021.
//

import Foundation
import Firebase
import FirebaseAuth

class ServerRegister {
    
    
    func fireBaseRegister(completion: @escaping(DataSnapshot) -> Void, name: String, email: String, passWord: String ) {
        var request: DatabaseReference?
        request = Database.database().reference()
        
        request?.observe(DataEventType.value, with: { dataSnapShot in
//            print(dataSnapShot.value ?? "")
        })
        
        request?.observe(.childAdded, with: { (dataSnapshotadd) in
//            print(dataSnapshotadd.value ?? "")
        })
    }
    
}

