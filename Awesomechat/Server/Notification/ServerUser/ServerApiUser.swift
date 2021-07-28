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
    
    static let shared = ServerApiUser() // khai báo kiểu singaleton
    
    var arrayLocalUser: [DataUser] = []
    let auth = Auth.auth().currentUser
    
    func requestApiUser(completionHandle: @escaping ([String]) -> Void) {
        var arrayKeyUser: [String] = []
        
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
            
            //print(listUser)
            //print(self.arrayLocalUser)
            
            
            DispatchQueue.main.async {
                completionHandle(arrayKeyUser)
                
            }
            
        })
        
       
    }
}
