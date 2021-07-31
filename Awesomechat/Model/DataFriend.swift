//
//  DataFriend.swift
//  Awesomechat
//
//  Created by LongDN on 02/07/2021.
//

import Foundation
import FirebaseDatabase

enum FriendType: String {
    case friend
    case friendRequest
    case sendRequest
}
struct DataFriend {
    let friendId: String
    let type: FriendType
    let info: DataUser?
    
    init(snapshot: DataSnapshot) {
        friendId = snapshot.childSnapshot(forPath: "friendId").value as? String ?? ""
        let rawType = snapshot.childSnapshot(forPath: "type").value as? String ?? ""
        type = FriendType(rawValue: rawType) ?? .friend
        let localFriendId = friendId
        info = ServerApiUser.shared.arrayLocalUser.first(where: { user in
            return user.userId == localFriendId
        })
    }
}
