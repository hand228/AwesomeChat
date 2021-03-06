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
    var checkDisplayPassWord = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        customStoryboard()
        scrollView.keyboardDismissMode = .onDrag
        scrollView.alwaysBounceVertical = true
        scrollView.clipsToBounds = true
        
    }
    
    @objc func keboard() {
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
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
        let tapImageRight = UITapGestureRecognizer(target: self, action: #selector(tapImageRights))
        imgPasswordRight.isUserInteractionEnabled = true
        imgPasswordRight.addGestureRecognizer(tapImageRight)
        txtPassword.rightViewMode = .always
        txtPassword.rightView = imgPasswordRight
        txtPassword.textContentType = UITextContentType.password
        // txtPassword.isSecureTextEntry = true
        
    }
    
    // MARK: CHECK ICON KEY PASSWORD
    @objc func tapImageRights() {
        
        if (checkDisplayPassWord == 0) {
            txtPassword.isSecureTextEntry = false
            checkDisplayPassWord = 1
        } else {
            txtPassword.isSecureTextEntry = true
            checkDisplayPassWord = 0
        }
    }
    
    @IBAction func btDangNhap(_ sender: Any) {
        
        // MARK: Login Email
        guard let email = txtEmail.text?.trimmingCharacters(in: .whitespacesAndNewlines) else {
            return
        }
        guard isValidEmail(email) == true else {
            return
        }
        guard let passWord = txtPassword.text?.trimmingCharacters(in: .whitespacesAndNewlines), passWord.count >= 8 else {
            return
        }
        
        print(Auth.auth().currentUser?.uid)
        // MARK: SET USERDEFAULD:
        UserDefaults.standard.set(email, forKey: "Email")
        UserDefaults.standard.set(passWord, forKey: "PassWord")
        
        Auth.auth().signIn(withEmail: email, password: passWord, completion: { [weak self ] (dataAuth, error) in
            
            guard error == nil else {
                return
            }
            
            guard let dataAuth = dataAuth else {
                return
            }
            self?.customPushSignIn()
        })
    }
    
    func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    
    @objc func customPushSignIn() {
        let tabbar = TabBarViewController()
        tabbar.modalPresentationStyle = .fullScreen
        self.present(tabbar, animated: true, completion: nil)

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
        // TODO: Qu??n m???t kh???u
//        let naviTableView = UINavigationController(rootViewController: TableViewController())
//        self.present(naviTableView, animated: true, completion: nil)
        
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
