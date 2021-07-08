//
//  ServerLogin.swift
//  Awesomechat
//
//  Created by LongDN on 05/07/2021.
//

import Foundation
import Firebase

class ServerLogin {
    
    func requestLogin(completionHandle: @escaping ([String] , Bool) -> Void, email: String, passWord: String ) {
        let request: DatabaseReference?
        request = Database.database().reference()
        var dataDiction: [String: Any] = [:]
        
        var array: [String] = []
        var checkLogin: Bool = false
        
        request?.child("user").getData(completion: { (error, dataSnapshot) in
            
            guard error == nil else {
                return
            }
            
            guard let dataValue = dataSnapshot.value as? [String: Any] else {
                return
            }
            print(dataValue)
            
            for items in dataValue.keys {
                print(items)
                
                dataDiction = dataValue[items] as? [String: Any] ?? [:]
                print(dataDiction["userEmail"] ?? "")
                print(dataDiction["userName"] ?? "")
                
                //print("value \(dataDiction.values) and key \(dataDiction.keys)")
                
                if ((dataDiction["userEmail"] as? String == email) && dataDiction["userName"] as? String == passWord)  {
                    
                    array.append(dataDiction["userEmail"] as! String )
                    array.append(dataDiction["userName"] as! String )
                    array.append(dataDiction["status"] as! String )
                    array.append(dataDiction["userImgUrl"] as! String)
                    
                    checkLogin = true
                }
                print(array)
            }
            
            DispatchQueue.main.async {
                completionHandle(array, checkLogin)
            }
        })
        
//        request?.child("Register").removeValue(completionBlock: { (error, dataReference) in
//
//            print(dataReference)
//        })
        
    }
}
