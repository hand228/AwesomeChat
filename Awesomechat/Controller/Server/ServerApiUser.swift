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
    let auth = Auth.auth()
    
    func requestApiUser(completionHandle: @escaping (DataSnapshot) -> Void) {
        guard let urlUser = URL(string: url+user+".json") else {
            return
        }
        let urlRequest = URLRequest(url: urlUser)
        
        let task = URLSession.shared.dataTask(with: urlRequest, completionHandler: { (data, reponse, error) in
            guard error == nil else {
                return
            }
            guard let data = data else {
                return
            }
            print(data)
            
            do {
                try JSONDecoder().decode(DataUserDetail.self, from: data)
                
            } catch let error {
                print(error)
            }
            guard let dataDecoder = try? JSONDecoder().decode(DataUser.self, from: data) else {
                
                return
                
            }
           // print(dataDecoder.userDateOfBirth)
            
            DispatchQueue.main.async {
                //completionHandle(dataDecoder)
            }
            
        })
        task.resume()
    }
    
    
    
    func getData(completion: @escaping (DataUserDetail) -> Void) {
        
        var ref: DatabaseReference
        ref = Database.database().reference()
        // Cusstom kieu data tra ve:
        var dataRequest: DatabaseReference
        dataRequest = Database.database().reference()
        
        
        
        dataRequest.child("user").updateChildValues(["userId": "1112234334"])
        dataRequest.child("user").updateChildValues(["username": "aasdfdss"], withCompletionBlock: { (error, dataReferent) in
            guard error == nil else {
                return
            }
            print(dataRequest)
        })
        let data: Any = ["userSetValue": "setValue"]
        dataRequest.child("user").setValue(data, withCompletionBlock: { (error, reponse) in
            guard error == nil else {
                return
            }
            print(reponse)
           // let b = reponse.value(forKey: "userId") // bug
          
        })
        
        dataRequest.child("user").observe(DataEventType.childChanged, with: {(dataSnapshot) in
            print(dataSnapshot)
        })
        
        dataRequest.child("user").observeSingleEvent(of: .childAdded, with: { (dataAdd) in
            print(dataAdd)
        })
        
        
        
        dataRequest.child("user").onDisconnectRemoveValue(completionBlock: { (error, dataReferent) in
            print(dataReferent)
        })
        
        dataRequest.child("user").removeValue(completionBlock: { (eror, completion ) in
            print(completion)
        })
        
        dataRequest.child("user").childByAutoId().getData(completion: { (data, reponse) in
            
        })
        
        dataRequest.child("user").observeSingleEvent(of: .value, with: { (datasnapshot) in
            guard let dataSnapshot = datasnapshot.value as? NSDictionary else {
                return
            }
            let dataResuld = dataSnapshot["userId"] as? String
            print(dataResuld ?? "bbbb")
            
        })
        
        //dataRequest.child("user").queryEqual(toValue: DataUser.self)
        //dataRequest.child("user").queryEnding(atValue: DataUser.self)
        //dataRequest.child("user").queryLimited(toLast: 2)
    }
    
    
    
    func requestDataFirebase(completion: @escaping ([[String: Any]]) -> Void ) {
        var requestApi: DatabaseReference
        var arrayFriends: [[String: Any]] = [[:]]
        
        requestApi = Database.database().reference()
        //print(requestApi.key)
        
        requestApi.child("friend").getData(completion: { (error, dataSnapshot) in
            guard error == nil else {
                return
            }
            
            //print(dataSnapshot.key)
            guard let data = dataSnapshot.value as? [String: Any] else {
                return
            }
            print(data)
            
            // Node:
            for user in data.keys {
                // user là ID của 1 người
                // friends là key-value trong đó key là id của bạn bè, value là object chứa id của bạn bè và kiểu
                
                guard let friends: [String: Any] = data[user] as? [String: Any] else {
                    return
                }
                
                //friends = data[user] as? [String: Any] ?? [:]
                
                print("Friends of \(user) value: \(friends.values) key friend \(friends.keys.count)")
                
//                guard let type: [String: Any] = friends[friends.keys] as? [String: Any] else {
//                    return
//                }
                
                arrayFriends.append(friends)
                
                
            }
            
            for i in 0..<arrayFriends.count {
                for idFriend in arrayFriends[i].keys {
                    
                    guard let type: [String: Any] = arrayFriends[i][idFriend] as? [String : Any] else {
                        return
                    }
                    
                    print("idFriend \(idFriend) value type \(type.values) key \(type.keys)")
                    
                }
            }
            
            
            guard let dataResuld = data["8q9de0KpYlabGDQ9Amw9U7DbQsi2"] else {
                return
            }
            
            DispatchQueue.main.async {
                completion(arrayFriends)
            }

            
        })
        
    
        
        
        
//        requestApi.child("friend").observe(.childAdded, with: { (dataSnapshot) in
//            guard let data = dataSnapshot.value as? String else {
//                return
//            }
//            //arrayData.append(data)
//            print(data)
//        })
        
        
        
//        requestApi.child("dataDemo").getData(completion: {(error,snapShot) in
//            guard error == nil else {
//                return
//            }
//            guard snapShot.exists() == true else {
//                return
//            }
//            print(snapShot.value)
//
//            guard let data = snapShot.value as? [String: Any] else {
//                return
//            }
//            guard let dataResuld = data["data1"] else {
//                return
//            }
//            print(dataResuld)
//
//        })
        
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
    }
    
    
}
