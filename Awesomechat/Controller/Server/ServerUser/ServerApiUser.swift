//
//  RequestApiUser.swift
//  Awesomechat
//
//  Created by LongDN on 01/07/2021.
//

import Foundation
import Firebase
import FirebaseAuth


//import FirebaseCoreDiagnostics


class ServerApiUser {
    
    
    var url = "https://awesomechat-5de51-default-rtdb.asia-southeast1.firebasedatabase.app/"
    var user = "user"
    var username: String = ""
    let auth = Auth.auth().currentUser
    
   
    func requestApiUser(completionHandle: @escaping ([String]) -> Void) {
        
        var arrayKeyUser: [String] = []
        let ref: DatabaseReference?
        ref = Database.database().reference()
        
        print(auth?.uid)
        
        ref?.child("users").getData(completion: { [weak self] (error, dataSnapshot) in
            
            guard error == nil else {
                return
            }
            
            
            guard let StrongSelf = self else {
                return
            }
            
            guard let dataSnapshot = dataSnapshot.value as? [String: Any] else {
                return
            }
            for dataSnapshotKey in dataSnapshot.keys {
                print(dataSnapshotKey)
                
                guard let dataSnapshotValue = dataSnapshot[dataSnapshotKey] as? [String: Any] else {
                    return
                }
                print(dataSnapshotValue)
                arrayKeyUser.append(dataSnapshotKey)
            }
            DispatchQueue.main.async {
                completionHandle(arrayKeyUser)
            }
            
        })
        
       
    }
    
    
    
    
    func requestDataFirebase(completion: @escaping ([[String: Any]]) -> Void ) {
        var requestApi: DatabaseReference
        var arrayFriends: [[String: Any]] = [[:]]
        let auth = Auth.auth().currentUser
        requestApi = Database.database().reference()
        //print(requestApi.key)
        // Check method push mesenger:
        //requestApi.child("chats").child(auth!.uid).queryEnding(atValue: <#T##Any?#>, childKey: <#T##String?#>)
        
        requestApi.child("friend").getData(completion: { (error, dataSnapshot) in
            guard error == nil else {
                return
            }
            
            //print(dataSnapshot.key)
            guard let data = dataSnapshot.value as? [String: Any] else {
                return
            }
            //print(data)
            
            // Node:
            for user in data.keys {
                // user là ID của 1 người
                // friends là key-value trong đó key là id của bạn bè, value là object chứa id của bạn bè và kiểu
                guard let friends: [String: Any] = data[user] as? [String: Any] else {
                    return
                }
                //friends = data[user] as? [String: Any] ?? [:]
                
                print("Friends of \(user) value: \(friends.values) key friend \(friends.keys)")
                print("------------------------")
                arrayFriends.append(friends)
                
                
            }
            
            for i in 0..<arrayFriends.count {
                for idFriend in arrayFriends[i].keys {
                    guard let type: [String: Any] = arrayFriends[i][idFriend] as? [String : Any] else {
                        return
                    }
                    
                    print("idFriend \(idFriend) value type \(type.values) key \(type.keys.first)")
                }
                print("---------------------")
            }
            guard let dataResuld = data["8q9de0KpYlabGDQ9Amw9U7DbQsi2"] else {
                return
            }
            
            DispatchQueue.main.async {
                completion(arrayFriends)
            }
        })
        
    }
    
    
    
    func fireBaseRegister(completion: @escaping(DataSnapshot) -> Void ) {
        
        var request: DatabaseReference?
        request = Database.database().reference()
        
        print("dsdsfsfs")
        request?.child("Register").updateChildValues(["name": "abc"], withCompletionBlock: { (error, dataReference) in
            
            guard error == nil else {
                return
            }
            
            
            print(dataReference)
            print("sdfgdfdf")
            
        })
        
        request?.child("User").queryEnding(atValue: "xdds", childKey: "dssds")
        request?.child("user").queryStarting(afterValue: "sdsf", childKey: "sdfsd")
        
        
    }
    
    
}
