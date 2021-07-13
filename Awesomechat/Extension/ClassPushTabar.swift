//
//  ClassPushTabar.swift
//  Awesomechat
//
//  Created by LongDN on 09/07/2021.
//

import Foundation
import UIKit
class PushTabbar {
    
    func custonPushTabbar() {
        
        let tabbarController = UITabBarController()
        let tabbarMessenger = MesengerController()
        tabbarMessenger.tabBarItem = UITabBarItem(title: "Tin nhắn", image: UIImage(named: "Vector-1")?.withRenderingMode(.alwaysOriginal), selectedImage: UIImage(named: "Vector (4)")?.withRenderingMode(.alwaysOriginal))
        let tabbarFriend = FriendController()
        tabbarFriend.tabBarItem = UITabBarItem(title: "Bạn bè", image: UIImage(named: "Group-1")?.withRenderingMode(.alwaysOriginal), selectedImage: UIImage(named: "Group")?.withRenderingMode(.alwaysOriginal))
        let tabbarPersonal = PersonalController()
        tabbarPersonal.tabBarItem = UITabBarItem(title: "Trang cá nhân", image: UIImage(named: "Vector (5)")?.withRenderingMode(.alwaysOriginal), selectedImage: UIImage(named: "Vector")?.withRenderingMode(.alwaysOriginal))
        
        
        tabbarController.viewControllers = [tabbarMessenger, tabbarFriend, tabbarPersonal]
        
        tabbarController.modalTransitionStyle = UIModalTransitionStyle.coverVertical
        tabbarController.modalPresentationStyle = UIModalPresentationStyle.fullScreen
        
        // self.present(tabbarController, animated: true, completion: nil)
        
    }
}

