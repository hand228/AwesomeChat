//
//  RegisterController.swift
//  Awesomechat
//
//  Created by LongDN on 01/07/2021.
//

import UIKit

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
        btDangKy.layer.cornerRadius = 20
        
    }
    
    
    @IBAction func didChangleHoTen(_ sender: Any) {
        
        btDangKy.backgroundColor = UIColor(rgb: 0xff4356B4)
    }
    
    @IBAction func btBack(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
        
    }
    
    @IBAction func btDangKy(_ sender: Any) {
        
        serverRegister.fireBaseRegister(completion: { (dataSnapshot) in
            
            print(dataSnapshot)
        }, name: txtHoTen.text ?? "", email: txtEmail.text ?? "", passWord: txtPassword.text ?? "")
        
        print("sas")
    }
    
}
