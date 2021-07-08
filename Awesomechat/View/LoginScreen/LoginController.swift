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
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    
    
    var arrayDiction: [[String : Any]] = [[:]]
    let serverApiUser = ServerApiUser()
    let serverLogin = ServerLogin()
    var arrayData: [String] = []
    var dataModelUser: DataUserDetail? = nil
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        customStoryboard()
        //scrollView.adjustedContentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        scrollView.alwaysBounceVertical = true
        scrollView.clipsToBounds = true
        
        //NotificationCenter.default.addObserver(self, selector: #selector(keboard), name: Notification.Name.UI, object: <#T##Any?#>)
        
    }
    
    @objc func keboard() {
        
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        scrollView.frame = view.bounds
        
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
        let imgEmailRight = UIImageView()
        imgEmailRight.image = UIImage(named: "mail (3) 1")
        txtEmail.rightViewMode = .always
        txtEmail.rightView = imgEmailRight
        txtEmail.textContentType = UITextContentType.emailAddress
        
        
        
        let imgPasswordRight = UIImageView()
        imgPasswordRight.image = UIImage(named: "key 1")
        
        let tapImageRight = UITapGestureRecognizer(target: self, action: #selector(tapImageRight))
        imgPasswordRight.isUserInteractionEnabled = true
        imgPasswordRight.addGestureRecognizer(tapImageRight)
        
        txtPassword.rightViewMode = .always
        txtPassword.rightView = imgPasswordRight
        txtPassword.textContentType = UITextContentType.password
        //txtPassword.isSecureTextEntry = true
        
    }
    // MARK: CHECK ICON KEY PASSWORD
    var i = 0
    @objc func tapImageRight() {
        
        if (i == 0) {
            txtPassword.isSecureTextEntry = false
            i = 1
        } else {
            txtPassword.isSecureTextEntry = true
            i = 0
        }
    }
    
    @IBAction func btDangNhap(_ sender: Any) {
        
        // MARK: Login Email
//        guard let email = txtEmail.text, let passWord = txtPassword.text, passWord.count >= 8 else {
//            alertUserLoginError()
//            return
//        }
        
        guard let email = txtEmail.text?.trimmingCharacters(in: .whitespacesAndNewlines) else {
            return
        }
        guard let passWord = txtPassword.text?.trimmingCharacters(in: .whitespacesAndNewlines), passWord.count >= 8 else {
            return
        }
        
        //var dataAuth = AuthDataResult?.self
        Auth.auth().signIn(withEmail: email, password: passWord, completion: { [weak self ] (dataAuth, error) in
            
            guard error == nil else {
                
                return
            }
            guard let strongSelf = self else {
                return
            }
            
            guard let dataAuth = dataAuth else {
                return
            }
//            guard let aa = dataAuth.credential else {
//                return
//            }
            
            print(email + passWord )
            print(dataAuth)
            
            strongSelf.present(MesengerController(), animated: true, completion: nil)
            
            
        })
        
        Auth.auth().addIDTokenDidChangeListener({ (auth, user) in
            
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
        txtEmail.resignFirstResponder()
        txtPassword.resignFirstResponder()
        
        self.present(RegisterController(), animated: true, completion: nil)
        
    }
    
    @IBAction func didChangleEmail(_ sender: Any) {
        btDangNhap.backgroundColor = UIColor(rgb: 0xff4356B4)
        
    }
    
    @IBAction func didChanglePassword(_ sender: Any) {
        
    }
    
}
