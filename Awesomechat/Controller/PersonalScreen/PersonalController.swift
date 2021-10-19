//
//  PersonalController.swift
//  Awesomechat
//
//  Created by LongDN on 08/07/2021.
//

import UIKit
import FirebaseAuth
import Firebase
import FirebaseStorage

class PersonalController: UIViewController {
    @IBOutlet weak var imgBackground: UIImageView!
    @IBOutlet weak var contentInfoView: UIView!
    @IBOutlet weak var imgAvartar: UIImageView!
    @IBOutlet weak var lbName: UILabel!
    @IBOutlet weak var lbEmail: UILabel!
    @IBOutlet weak var lbLanguage: UILabel!
    @IBOutlet weak var lbVersionApp: UILabel!
    @IBOutlet weak var lbDangXuat: UILabel!
   // var dataUser: DataUser?
    let storage = Storage.storage().reference()
    let serverUser = ServerApiUser.shared
    let nsObject: AnyObject? = Bundle.main.infoDictionary!["CFBundleShortVersionString"] as AnyObject?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        contentInfoView.layer.cornerRadius = CGFloat(20)
        
        lbDangXuat.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(actionLogout))
        lbDangXuat.addGestureRecognizer(tapGesture)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.reloadInputViews()
        setupInputComponents()
    }
    
    func setupInputComponents() {
        
        lbName.font = UIFont(name: "Lato", size: CGFloat(22))
        lbEmail.textColor = UIColor(rgb: 0xff999999)
        let version: String = nsObject as! String
        lbLanguage.textColor = UIColor(rgb: 0xff4356B4)
        lbVersionApp.text = version
        
        
        imgAvartar.layer.cornerRadius = imgAvartar.frame.height/2
        imgAvartar.clipsToBounds = true
        imgAvartar.layer.borderWidth = 2
        imgAvartar.layer.borderColor = UIColor(rgb: 0xff3DCFCF).cgColor
        
        imgBackground.sizeToFit()
        imgBackground.contentMode = .scaleToFill
        imgBackground.highlightedImage = .add
        
        let ref: DatabaseReference?
        ref = Database.database().reference()
        
        ref?.child("users/\(Auth.auth().currentUser!.uid)").getData(completion: {(error, dataSnapshot) in
            guard error == nil else {
                return
            }
            
            let dataUser = DataUser(snapShot: dataSnapshot)
            
            print(dataUser.userEmail)
            DispatchQueue.main.async {
                self.lbName.text = dataUser.userName
                self.lbEmail.text = dataUser.userEmail
                
                do {
                    let dataImg = try Data(contentsOf: URL(string: dataUser.userImgUrl) ?? URL(string: "defauld.png")!)
                    self.imgAvartar.image = UIImage(data: dataImg)
                } catch {
                    self.imgAvartar.image = UIImage(named: "default")
                }
                
                do {
                    let dataImg = try Data(contentsOf: URL(string: dataUser.userImgUrl) ?? URL(string: "defauld.png")!)
                    self.imgBackground.image = UIImage(data: dataImg)
                } catch {
                    self.imgBackground.image = UIImage(named: "default")
                }
            }
        })
        
        
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
    
    
    @IBAction func btEditProfile(_ sender: Any) {
        
        let personalProfile = PersonalProfile()
        personalProfile.modalPresentationStyle = UIModalPresentationStyle.fullScreen
        personalProfile.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        self.present(personalProfile, animated: true, completion: nil)
        
    }
    
}

