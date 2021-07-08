//
//  ServerMesenger.swift
//  Awesomechat
//
//  Created by LongDN on 08/07/2021.
//

import Foundation
import Firebase



class ServerMesenger {
    
    func requestMesenger(completionHandle: @escaping ([[String: Any]]) -> Void ) {
        let ref: DatabaseReference!
        ref = Database.database().reference()
        var arrayDictionary: [[String: Any]] = [[:]]
        ref.child("chat").getData(completion: { (error, snapShot) in
            guard error == nil else {
                return
            }
            guard let dataSnapShot = snapShot.value as? [String: Any] else {
                return
            }
            
            // lấy danh sách tin nhắn: lấy ra image, tin nhắn, số giờ, ...
            for items in dataSnapShot.keys {
                // print(items)
                guard let dataItems = dataSnapShot[items] as? [String: Any] else {
                    return
                }
                arrayDictionary.append(dataItems)
                
                
//                print("------------------------------------------------------------------")
//                print(dataItems)
//                print("------------------------------------------------------------------")
//                print(dataItems["MOsyXJY0ooAwMGa_rz8"] ?? "aaaaa")
                
            }
            
//            for i in 0..<arrayDictionary.count {
//                print(arrayDictionary.count)
//                print(arrayDictionary[i])
//                print(arrayDictionary[i].keys)
//
//                // lấy ra các key của từng phần tử trong mảng:
//                for dataItems in arrayDictionary[i].keys {
//
//                    // lấy ra từng giá trị thông qua cái key của mảng:
//                    guard let dataDetail = arrayDictionary[i][dataItems] as? [String: Any] else {
//                        return
//                    }
//                    // lây ra từng giá trị trong một mảng thông qua cái DictionAry nhỏ ben trong của nó:
//                    print(dataDetail["time"] ?? "time")
//
//                }
////                guard let dataItems = arrayDictionary[i] else {
////                    return
////                }
//            }
            // CallBack về màn Messenger
            DispatchQueue.main.async {
                completionHandle(arrayDictionary)
            }
        })
        
        
    }
    
}



