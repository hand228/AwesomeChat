//
//  LoginEmail.swift
//  Awesomechat
//
//  Created by LongDN on 06/07/2021.
//

import Foundation
import FirebaseAuth
import Firebase

class LoginEmail {
    
    let actionCodeSettings = ActionCodeSettings()
    
    func customLogin() {
        
        actionCodeSettings.url = URL(string: "https://awesomechat-5de51-default-rtdb.asia-southeast1")
        actionCodeSettings.handleCodeInApp = true
        actionCodeSettings.setIOSBundleID("danglong.Awesomechat")
        actionCodeSettings.setAndroidPackageName("com.example.android", installIfNotAvailable: false, minimumVersion: "12")
        
        
        Auth.auth().signIn(withEmail: "", password: "", completion: { (dataResuld, error) in
            guard error == nil else {
                return
            }
            
            
        })
        
        Auth.auth().sendSignInLink(toEmail: "", actionCodeSettings: actionCodeSettings, completion: { (error) in
            
        })
        
        
        let user = Auth.auth().currentUser
        
        user?.sendEmailVerification(with: actionCodeSettings, completion: { (error) in
            
        })
        
        // sau khi đã gửi link về:
        if(Auth.auth().isSignIn(withEmailLink: "link da gui ve") == true) {
            
            // thực thi việc người dùng đã chọn vào link:
            Auth.auth().signIn(withEmail: "email for me", link: "link da gui ve", completion: { (dataAuth, error) in
                // handle code khi dã login đc
            })
        }
        
        // sử lý với cách login khác:
        let credential = EmailAuthProvider.credential(withEmail: "", password: "")
        Auth.auth().currentUser?.link(with: credential, completion: { (dataResuld, error) in
            guard error == nil else {
                return
            }
            // handle code no error:
            
        })
        
        //
        
    }
    
}


