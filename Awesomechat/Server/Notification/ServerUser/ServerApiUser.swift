//
//  RequestApiUser.swift
//  Awesomechat
//
//  Created by LongDN on 01/07/2021.
//

import Foundation
import Firebase
import FirebaseAuth

class ServerApiUser {
    static let shared = ServerApiUser()
    var arrayLocalUser: [DataUser] = []
    let auth = Auth.auth().currentUser
    
    func requestApiUser(completionHandle: @escaping ([DataUser]) -> Void) {
        let ref: DatabaseReference?
        ref = Database.database().reference()

        print(auth?.uid)
        
        ref?.child("users").getData(completion: { (error, dataSnapshot) in
            guard error == nil else {
                return
            }
            
            let listUser = (dataSnapshot.children.allObjects as? [DataSnapshot])?.map {
                DataUser(snapShot: $0)
            }
            self.arrayLocalUser = listUser ?? []
            DispatchQueue.main.async {
                completionHandle(self.arrayLocalUser)
            }
        })
    }
}
