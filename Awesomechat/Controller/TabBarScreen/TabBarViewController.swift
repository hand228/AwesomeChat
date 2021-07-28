//
//  TabBarViewController.swift
//  Awesomechat
//
//  Created by MaiNQ on 14/07/2021.
//

import UIKit
import Firebase

class TabBarViewController: UIViewController {

    // Khởi tạo file nib
    let mesVC = MesengerController(nibName: "MesengerController", bundle: nil)
    let groupVC = FriendController(nibName: "FriendController", bundle: nil)
    let homeVC = PersonalController(nibName: "PersonalController", bundle: nil)
    
    // Outlets
    @IBOutlet weak var layerInside: UIView!
    @IBOutlet weak var contentView: UIView!
    
    @IBOutlet weak var mesImg: UIImageView!
    @IBOutlet weak var groupImg: UIImageView!
    @IBOutlet weak var homeImg: UIImageView!
    
    @IBOutlet weak var mesLbl: UILabel!
    @IBOutlet weak var groupLbl: UILabel!
    @IBOutlet weak var homeLbl: UILabel!
    
    @IBOutlet weak var mesDot: UIView!
    @IBOutlet weak var groupDot: UIView!
    @IBOutlet weak var homeDot: UIView!
    
    var ref: DatabaseReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ref = Database.database().reference()
        let childRef = ref.child("friend")
        childRef.observe(.value, with: { snapshot in
            print(snapshot.value as Any)
        })
        
        // Do any additional setup after loading the view.
        borderLayer()
        
        mesImg.image = UIImage(named: "m")
        groupImg.image = UIImage(named: "g")
        homeImg.image = UIImage(named: "h")
        
        initScreen()
    }

    // Bo tròn tab bar và chấm
    private func borderLayer() {
        layerInside.layer.cornerRadius = layerInside.frame.size.height / 5
        layerInside.clipsToBounds = true
        
        mesDot.layer.cornerRadius = mesDot.frame.size.width/2
        groupDot.layer.cornerRadius = groupDot.frame.size.width/2
        homeDot.layer.cornerRadius = homeDot.frame.size.width/2

        mesDot.clipsToBounds = true
        groupDot.clipsToBounds = true
        homeDot.clipsToBounds = true
    }
    
    // Tab tin nhắn
    private func initScreen() {
        mesImg.image = UIImage(named: "m_selected")
        groupImg.image = UIImage(named: "g")
        homeImg.image = UIImage(named: "h")
        
        mesLbl.textColor = UIColor.myBlue
        groupLbl.textColor = .lightGray
        homeLbl.textColor = .lightGray
        
        mesDot.backgroundColor = UIColor.myBlue
        mesDot.isHidden = false
        groupDot.isHidden = true
        homeDot.isHidden = true
        
        contentView.addSubview(mesVC.view)
        mesVC.didMove(toParent: self)
        
        groupVC.willMove(toParent: nil)
        groupVC.removeFromParent()
        groupVC.view.removeFromSuperview()
        
        homeVC.willMove(toParent: nil)
        homeVC.removeFromParent()
        homeVC.view.removeFromSuperview()
    }
    
    @IBAction func clickTabBar(_ sender: UIButton) {
        let tag = sender.tag
        print(tag)
        
        // Hiển thị tab view khi mỗi lần ấn tab
        if tag == 1 {
           initScreen()
        } else if tag == 2 {
            groupImg.image = UIImage(named: "g_selected")
            mesImg.image = UIImage(named: "m")
            homeImg.image = UIImage(named: "h")
            
            groupLbl.textColor = UIColor.myBlue
            mesLbl.textColor = .lightGray
            homeLbl.textColor = .lightGray
            
            groupDot.backgroundColor = UIColor.myBlue
            groupDot.isHidden = false
            mesDot.isHidden = true
            homeDot.isHidden = true

            contentView.addSubview(groupVC.view)
            groupVC.didMove(toParent: self)
            
            mesVC.willMove(toParent: nil)
            mesVC.removeFromParent()
            mesVC.view.removeFromSuperview()
            
            homeVC.willMove(toParent: nil)
            homeVC.removeFromParent()
            homeVC.view.removeFromSuperview()
        } else {
            homeImg.image = UIImage(named: "h_selected")
            mesImg.image = UIImage(named: "m")
            groupImg.image = UIImage(named: "g")
            
            mesLbl.textColor = .lightGray
            groupLbl.textColor = .lightGray
            homeLbl.textColor = UIColor.myBlue
            
            homeDot.backgroundColor = UIColor.myBlue
            homeDot.isHidden = false
            mesDot.isHidden = true
            groupDot.isHidden = true
        
            contentView.addSubview(homeVC.view)
            homeVC.didMove(toParent: self)
            
            mesVC.willMove(toParent: nil)
            mesVC.removeFromParent()
            mesVC.view.removeFromSuperview()
            
            groupVC.willMove(toParent: nil)
            groupVC.removeFromParent()
            groupVC.view.removeFromSuperview()
        }
    }
}


