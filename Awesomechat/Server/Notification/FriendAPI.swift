//
//  File.swift
//  Awesomechat
//
//  Created by Ha Nguyen Duc on 2021/07/31.
//

import Foundation
import FirebaseDatabase
import FirebaseAuth

class FriendAPI {
    let ref = Database.database().reference()
    
    /// Lấy danh sách bạn bè của mình
    /// - Parameters:
    ///   - completion: Callback trả về danh sách Friend
    func getMyFriends(completion: @escaping (([DataFriend]) -> Void)) {
        // currentUser đang bị trống. Sau này phải lấy thông tin từ đây
//        let myId = Auth.auth().currentUser?.uid ?? ""
        let myId = "8q9de0KpYlabGDQ9Amw9U7DbQsi2"
//        ref.child("friend").getData { error, snapshot in
//            let friends = (snapshot.childSnapshot(forPath: myId).children.allObjects as? [DataSnapshot])?.map {
//                DataFriend(snapshot: $0)
//            } ?? []
//            DispatchQueue.main.async {
//                completion(friends)
//            }
//        }
    }
}
