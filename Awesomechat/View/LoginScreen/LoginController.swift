//
//  LoginController.swift
//  Awesomechat
//
//  Created by LongDN on 01/07/2021.
//

import UIKit
import FirebaseAuth

class LoginController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var btDangNhap: UIButton!
    
    var arrayDiction: [[String : Any]] = [[:]]
    let serverApiUser = ServerApiUser()
    let serverLogin = ServerLogin()
    var arrayData: [String] = []
    var dataModelUser: DataUserDetail? = nil
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        customStoryboard()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        Auth.auth().addStateDidChangeListener({ (auth , user) in
            
        })
        
        Auth.auth().createUser(withEmail: "", password: "", completion: { (authData, error) in
            
        })
    }
    
    func customStoryboard() {
        
        btDangNhap.layer.cornerRadius = 20
        // txt Email. Password
        let imgEmailRight = UIImageView()
        imgEmailRight.image = UIImage(named: "mail (3) 1")
        txtEmail.rightViewMode = .always
        txtEmail.rightView = imgEmailRight
        txtEmail.textContentType = UITextContentType.emailAddress
        
        
        
        let imgPasswordRight = UIImageView()
        imgPasswordRight.image = UIImage(named: "key 1")
        
        txtPassword.rightViewMode = .always
        txtPassword.rightView = imgPasswordRight
        txtPassword.textContentType = UITextContentType.password
        txtPassword.isSecureTextEntry = true
        
    }
    
    @IBAction func btDangNhap(_ sender: Any) {
        
        
        
        // MARK: DataBase readme time:
//        serverApiUser.getData(completion: { (error, snapshot) in
        
//        })
//        serverApiUser.getData(completion: { (snapShot) in
//            self.dataModelUser = snapShot
//            print(snapShot)
//        })
        
//        serverApiUser.requestDataFirebase(completion: { (dataSnapshot) in
//            self.arrayDiction = dataSnapshot
//            print(dataSnapshot)
//        })
        
//        serverLogin.requestLogin(completionHandle: {( array, checkLogin) in
//
//            if( checkLogin == true) {
//                self.present(TableViewController(), animated: true, completion: nil)
//                self.arrayData = array
//            } else {
//                print("Error")
//            }
//        }, email: txtEmail.text ?? "", passWord: txtPassword.text ?? "")
        
        
        
        // MARK: Login Email
        
        guard let email = txtEmail.text, let passWord = txtPassword.text, !email.isEmpty, !passWord.isEmpty, passWord.count >= 6 else {
            alertUserLoginError()
            return
        }
        
        //var dataAuth = AuthDataResult?.self
        Auth.auth().signIn(withEmail: email, password: passWord, completion: { (dataAuth, error) in
            
            guard error == nil else {
                return
            }
            
            guard let dataAuth = dataAuth else {
                return
            }
            
            print(dataAuth)
            
        })
        
    }
    
    func alertUserLoginError() {
        let alear = UIAlertController(title: "Wood",
                                      message: "Plese enter information to log in",
                                      preferredStyle: .alert)
        alear.addAction(UIAlertAction(title: "Dismiss",
                                      style: .cancel,
                                      handler: nil))
        
        present(alear, animated: true, completion: nil)
        
    }
    
    
    
    @IBAction func btQuenMatKhau(_ sender: Any) {
        let naviTableView = UINavigationController(rootViewController: TableViewController())
        self.present(naviTableView, animated: true, completion: nil)
//        self.serverLogin.fireBaseRegister(completion: { (data) in
//            print(data)
//        })
        
    }
    
    @IBAction func btDangKyNgay(_ sender: Any) {
        self.present(RegisterController(), animated: true, completion: nil)
        
    }
    
    @IBAction func didChangleEmail(_ sender: Any) {
        btDangNhap.backgroundColor = UIColor(rgb: 0xff4356B4)
        
    }
    
    @IBAction func didChanglePassword(_ sender: Any) {
        
    }
    
}
