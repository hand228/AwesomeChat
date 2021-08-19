//
//  File.swift
//  Awesomechat
//
//  Created by Ha Nguyen Duc on 2021/07/31.
//

import Foundation
import FirebaseDatabase
import FirebaseAuth
import Firebase

class FriendAPI {
    static let shared = FriendAPI()
    let ref = Database.database().reference()
    
    /// Lấy danh sách bạn bè của mình
    /// - Parameters:
    ///   - completion: Callback trả về danh sách Friend
//    func getMyFriends(completion: @escaping (([DataFriend]) -> Void)) {
//        // currentUser đang bị trống. Sau này phải lấy thông tin từ đây
////        let myId = Auth.auth().currentUser?.uid ?? ""
//        let myId = "9MdPdQk4InOTpFj9dk6iEkdgqS72"
////        print("MyID: ===========\(myId)============")
//        ref.child("friend").getData { error, snapshot in
//            let friends = (snapshot.childSnapshot(forPath: myId).children.allObjects as? [DataSnapshot])?.map {
//                DataFriend(snapshot: $0)
//            } ?? []
//            DispatchQueue.main.async {
//                completion(friends)
//            }
//        }
//    }
    func getMyFriends(completion: @escaping (([DataFriend]) -> Void)) {
        // currentUser đang bị trống. Sau này phải lấy thông tin từ đây
//        let myId = Auth.auth().currentUser?.uid ?? ""
        let myId = "zvFIO2osJJZhdcJtLd2kjyAHrfJ3"
//        print("MyID: ===========\(myId)============")
        ref.child("friend").observe(.value, with: { snapshot in
            let friends = (snapshot.childSnapshot(forPath: myId).children.allObjects as? [DataSnapshot])?.map {
                DataFriend(snapshot: $0)
            } ?? []
//            completion(friends)
            DispatchQueue.main.async {
                completion(friends)
            }
        })
    }
    
    public func unfriend(withID: String) {
//        let myId = Auth.auth().currentUser?.uid ?? ""
        let myId = "zvFIO2osJJZhdcJtLd2kjyAHrfJ3"
        let ref = self.ref.child("friend").child(myId).child(withID)
        ref.removeValue() { error, _ in
            print(error?.localizedDescription ?? "Saved")
        }
    }

    public func acceptFriendRequest(withID: String) {
//        let myId = Auth.auth().currentUser?.uid ?? ""
        let myId = "zvFIO2osJJZhdcJtLd2kjyAHrfJ3"
        let ref = self.ref.child("friend").child(myId).child(withID)
        ref.updateChildValues(["type": "friend"]) { error, _ in
            print(error?.localizedDescription ?? "Saved")
        }
    }
    
    public func addFriend(withID: String) {
//        let myId = Auth.auth().currentUser?.uid ?? ""
        let myId = "zvFIO2osJJZhdcJtLd2kjyAHrfJ3"
        let value = ["friendId": withID, "type": "sendRequest"]
        let ref = self.ref.child("friend").child(myId).child(withID)
        ref.setValue(value) { error, _ in
            print(error?.localizedDescription ?? "Saved")
        }
    }
}
