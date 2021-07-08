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
        
        do {
            try Auth.auth().signOut()
        } catch {
            print(error)
        }
        
    }
    
    
    
}
