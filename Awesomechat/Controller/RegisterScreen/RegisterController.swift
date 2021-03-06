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
    @IBOutlet weak var scrollView: UIScrollView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.keyboardDismissMode = .onDrag
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
        guard isValidEmail(email) == true else {
            return
        }
        guard let passWord = txtPassword.text?.trimmingCharacters(in: .whitespacesAndNewlines), passWord.count >= 8 else {
            return
        }
        guard let name = txtHoTen.text else {
            return
        }
        
        Auth.auth().createUser(withEmail: email, password: passWord, completion: { (dataAuth, error) in
            guard error == nil else {
                return
            }
            
            // MARK: Set UserDefauld:
            UserDefaults.standard.set(email, forKey: "Email")
            UserDefaults.standard.set(passWord, forKey: "PassWord")
            
            // MARK: PUSH DATA ON DATABASE
            let pushData: DatabaseReference?
            pushData = Database.database().reference()
            let currentUser = Auth.auth().currentUser
            
            // c???n check l???i c??i th???ng status.
            let post = [
                "email": email,
                "userName": name,
                "userId": currentUser?.uid ?? "",
                "userStatus": "offline",
                "userPhone": "defauld",
                "userImgUrl": "defauld.png",
                "userDateOfBirth": "defauld"
            ] as [String : Any]
            pushData?.child("users").child(Auth.auth().currentUser?.uid ?? "").updateChildValues(post)
            self.customPushMesenger()
            
        })
        
        
        
    }
    
    func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    
    // MARK: CUSTOM PUSH SCREEN MESSENGER
    func customPushMesenger() {
        let tabbarController = TabBarViewController()
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
