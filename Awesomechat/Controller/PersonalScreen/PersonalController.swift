//
//  PersonalController.swift
//  Awesomechat
//
//  Created by LongDN on 08/07/2021.
//

import UIKit
import FirebaseAuth
import Firebase

class PersonalController: UIViewController {
    @IBOutlet weak var imgBackground: UIImageView!
    
    @IBOutlet weak var contentInfoView: UIView!
    @IBOutlet weak var imgAvartar: UIImageView!
    @IBOutlet weak var lbName: UILabel!
    @IBOutlet weak var lbEmail: UILabel!
    @IBOutlet weak var lbLanguage: UILabel!
    @IBOutlet weak var lbVersionApp: UILabel!
    @IBOutlet weak var lbDangXuat: UILabel!
    let auth = Auth.auth().currentUser?.uid
    
    let serverUser = ServerApiUser.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        contentInfoView.layer.cornerRadius = CGFloat(20)
        handleImgBackground()
        setupInputComponents()
        lbDangXuat.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(actionLogout))
        lbDangXuat.addGestureRecognizer(tapGesture)
        
        
        
        
    }
    
    func setupInputComponents() {
        
//        let ref: DatabaseReference?
//        ref = Database.database().reference()
//
//
//        ref?.child("users/\(auth)").getData(completion: {(error, dataSnapshot) in
//            guard error == nil else {
//                return
//            }
//            print(dataSnapshot)
//
//            let dataUser = dataSnapshot.children.allObjects as? DataUser
//
//            print(dataUser?.userEmail)
//            print(dataUser?.userName)
//
//        })
        print(auth)
        for  i in 0..<serverUser.arrayLocalUser.count {
            if (auth == serverUser.arrayLocalUser[i].userId) {
                lbName.text = serverUser.arrayLocalUser[i].userName
                lbEmail.text = serverUser.arrayLocalUser[i].userEmail
                
                print(serverUser.arrayLocalUser[i].userName)
                
                
            }
        }
        
        
        
    }
    
    @objc func actionLogout() {
        print("action")
        let firebaseAuth = Auth.auth()
        do {
            
            UserDefaults.standard.removeObject(forKey: "Email")
            UserDefaults.standard.removeObject(forKey: "PassWord")
            
            try firebaseAuth.signOut()
            
            let naviLoginBack = LoginController()
            naviLoginBack.modalPresentationStyle = .fullScreen
            naviLoginBack.modalTransitionStyle = .crossDissolve
            self.present(naviLoginBack, animated: true, completion: nil)
            
            
        } catch {
            print(error)
        }
    }
    
    func handleImgBackground() {
        imgBackground.image = UIImage(named: "6744109_preview 1")
        imgBackground.sizeToFit()
        imgBackground.contentMode = .scaleToFill
        imgBackground.highlightedImage = .add
        
    }
    
    
    @IBAction func btEditProfile(_ sender: Any) {
        
    }
    
}

