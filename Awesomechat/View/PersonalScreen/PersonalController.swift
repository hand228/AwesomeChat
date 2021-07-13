//
//  PersonalController.swift
//  Awesomechat
//
//  Created by LongDN on 08/07/2021.
//

import UIKit
import FirebaseAuth



class PersonalController: UIViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.yellow
        
    }
    
    @IBAction func LogOut(_ sender: Any) {
        
        
        
        let firebaseAuth = Auth.auth()
        do {
//            UserDefaults.standard.set("1", forKey: "Email")
//            UserDefaults.standard.set("1", forKey: "PassWord")
            
            try firebaseAuth.signOut()
            let naviLoginBack = UINavigationController()
            naviLoginBack.modalPresentationStyle = .fullScreen
            naviLoginBack.modalTransitionStyle = .crossDissolve
            self.present(naviLoginBack, animated: true, completion: nil)
            
            
            
        } catch {
            print(error)
        }
        
    }
    
    
    
}
