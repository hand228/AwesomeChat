//
//  RegisterController.swift
//  Awesomechat
//
//  Created by LongDN on 01/07/2021.
//

import UIKit
import FirebaseAuth
import Firebase


class RegisterController: UIViewController {
    
    @IBOutlet weak var txtHoTen: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var btDangKy: UIButton!
    
    var serverRegister = ServerRegister()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        customStoryboard()
        
    }
    
    func customStoryboard() {
        
        let imgHoTen = UIImageView()
        imgHoTen.image = UIImage(named: "Vector (3)")
        txtHoTen.rightViewMode = .always
        txtHoTen.rightView = imgHoTen
        
        let imgEmail = UIImageView()
        imgEmail.image = UIImage(named: "mail (3) 1")
        txtEmail.rightViewMode = .always
        txtEmail.rightView = imgEmail
        
        let imgPassword = UIImageView()
        imgPassword.image = UIImage(named: "key 1")
        txtPassword.rightViewMode = .always
        txtPassword.rightView = imgPassword
        txtPassword.isSecureTextEntry = true
        
        btDangKy.layer.cornerRadius = 20
        
        
    }
    
    
    @IBAction func didChangleHoTen(_ sender: Any) {
        
        btDangKy.backgroundColor = UIColor(rgb: 0xff4356B4)
    }
    
    @IBAction func btBack(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
        
    }
    
    @IBAction func btDangKy(_ sender: Any) {
        
        guard let email = txtEmail.text?.trimmingCharacters(in: .whitespacesAndNewlines) else {
            return
        }
        guard let passWord = txtPassword.text?.trimmingCharacters(in: .whitespacesAndNewlines), passWord.count >= 8 else {
            return
        }
        guard let name = txtHoTen.text else {
            return
        }
        
       
        
        Auth.auth().createUser(withEmail: email, password: passWord, completion: { (dataAuth, error) in
            
            //self.usingUserDefaulds()
            guard error == nil, dataAuth != nil else {
                //strongSelf.alertUserLoginError()
                return
            }
            
//            if ((UserDefaults.standard.string(forKey: "Email") == "1") && UserDefaults.standard.string(forKey: "PassWord") == "1") {
//                
//            } else {
//                UserDefaults.standard.set(email, forKey: "Email")
//                UserDefaults.standard.set(passWord, forKey: "PassWord")
//            }
            
            UserDefaults.standard.set(email, forKey: "Email")
            UserDefaults.standard.set(passWord, forKey: "PassWord")
            
            // MARK: PUSH DATA ON DATABASE
            let pushData: DatabaseReference?
            pushData = Database.database().reference()
            print(Auth.auth().currentUser?.uid ?? "555")
            
            pushData?.child("users").child(Auth.auth().currentUser?.uid ?? "").updateChildValues(["email": email])
            pushData?.child("users").child(Auth.auth().currentUser?.uid ?? "").updateChildValues(["userName": name])
            pushData?.child("users").child(Auth.auth().currentUser?.uid ?? "").updateChildValues(["userId": Auth.auth().currentUser?.uid ?? ""])
            pushData?.child("users").child(Auth.auth().currentUser?.uid ?? "").updateChildValues(["userStatus": "offline"])
            pushData?.child("users").child(Auth.auth().currentUser?.uid ?? "").updateChildValues(["userPhone": Auth.auth().currentUser?.phoneNumber ?? "defauld"])
            pushData?.child("users").child(Auth.auth().currentUser?.uid ?? "").updateChildValues(["userImgUrl": Auth.auth().currentUser?.photoURL ?? "defauld"])
            pushData?.child("users").child(Auth.auth().currentUser?.uid ?? "").updateChildValues(["userDateOfBirth": "defauld"])
            
            self.customPushMesenger()
            
            
        })
        
    }
    
    // MARK: CUSTOM PUSH SCREEN MESSENGER
    func customPushMesenger() {
        
       // let pushTabbar = PushTabbar()
        
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
        self.present(tabbarController, animated: true, completion: nil)
        
        
    }
    
    
    func alertUserLoginError(message: String = "Plese enter information to creat a account") {
        let alear = UIAlertController(title: "Wood",
                                      message: message,
                                      preferredStyle: .alert)
        alear.addAction(UIAlertAction(title: "Dismiss",
                                      style: .cancel,
                                      handler: nil))
        present(alear, animated: true, completion: nil)
        
    }
    
    func usingUserDefaulds() {
        UserDefaults.standard.set(txtEmail.text ?? "", forKey: "Email")
    }
    
    
    @IBAction func backDangNhap(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
}
