//
//  RequestApiUser.swift
//  Awesomechat
//
//  Created by LongDN on 01/07/2021.
//

import Foundation
import Firebase
import FirebaseAuth

class ServerApiUserMessenger {
    
    static let shared = ServerApiUserMessenger()
    let serverMessenger = ServerMesenger()
    var arrayLocalUser: [DataUser] = []
    var lastMessengers: [String] = []
    let auth = Auth.auth().currentUser
    
    func requestApiUserMessenger(completionHandle: @escaping ([String] ,[DataUser]) -> Void) {
        
        let ref: DatabaseReference?
        ref = Database.database().reference()
        ref?.child("users").getData(completion: { (error, dataSnapshot) in
            
            guard error == nil else {
                return
            }
            
            let listUser = (dataSnapshot.children.allObjects as? [DataSnapshot])?.map {
                DataUser(snapShot: $0)
                
            }
            
            self.arrayLocalUser = listUser ?? []
            print(self.arrayLocalUser)
                
            self.serverMessenger.requestMesenger(completionHandle: { (lastMessenger, dataUsers) in
                self.lastMessengers = lastMessenger
                self.arrayLocalUser = dataUsers
                
                DispatchQueue.main.async {
                    
                    completionHandle(lastMessenger , dataUsers)
                }
                
            })
            
            
            
        })
    }
    
    
    
    
}
