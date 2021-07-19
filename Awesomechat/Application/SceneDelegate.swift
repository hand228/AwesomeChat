//
//  SceneDelegate.swift
//  Awesomechat
//
//  Created by LongDN on 01/07/2021.
//

import UIKit
import FirebaseAuth


class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    let view = UITabBar()

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
//        guard let windowscene = (scene as? UIWindowScene) else { return }
//        let window = UIWindow(windowScene: windowscene)
//        let tabbarController = UITabBarController()
//        // MARK: CUSTOM TABBAR
//        let tabbarMessenger = MesengerController()
//        tabbarMessenger.tabBarItem = UITabBarItem(title: "Tin nhắn", image: UIImage(named: "Vector-1")?.withRenderingMode(.alwaysOriginal), selectedImage: UIImage(named: "Vector (4)")?.withRenderingMode(.alwaysOriginal))
//
//        let tabbarFriend = FriendController()
//        tabbarFriend.tabBarItem = UITabBarItem(title: "Bạn bè", image: UIImage(named: "Group-1")?.withRenderingMode(.alwaysOriginal), selectedImage: UIImage(named: "Group")?.withRenderingMode(.alwaysOriginal))
//        let tabbarPersonal = PersonalController()
//        tabbarPersonal.tabBarItem = UITabBarItem(title: "Trang cá nhân", image: UIImage(named: "Vector (5)")?.withRenderingMode(.alwaysOriginal), selectedImage: UIImage(named: "Vector")?.withRenderingMode(.alwaysOriginal))
//        // Custom check Email, passWord:
//
//        Auth.auth().signIn(withEmail: UserDefaults.standard.string(forKey: "Email") ?? "",
//                           password: UserDefaults.standard.string(forKey: "PassWord") ?? "",
//                           completion: { (authData, error) in
//
//                            print(UserDefaults.standard.string(forKey: "Email") ?? "")
//                            print(UserDefaults.standard.string(forKey: "PassWord") ?? "")
//
//                            guard error == nil else {
//                                window.rootViewController = LoginController()
//                                return
//                            }
//                            tabbarController.viewControllers = [tabbarMessenger, tabbarFriend, tabbarPersonal]
//                            window.rootViewController = tabbarController
//
//                           // print(authData)
//        })
//
//        self.window = window
//        window.makeKeyAndVisible()
        
        guard let windowscene = (scene as? UIWindowScene) else { return }
        
        let window = UIWindow(windowScene: windowscene)
        window.rootViewController = TabBarViewController()
        
        
        self.window = window
        window.makeKeyAndVisible()
    }
    
    // MARK: PUSH SIGNIN
    

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }


}

