//
//  DataUser.swift
//  Awesomechat
//
//  Created by LongDN on 01/07/2021.
//

import Foundation

struct DataUser: Codable {
    
    
    var userIdLocal: DataUserDetail
    
}
struct DataUserDetail: Codable {
    
    var stautus: String
    var userDateOfBirth: String
    var userEmail: String
    var userId: String
    var userImgUrl: String
    var userName: String
    var userPhone: String
    
}

