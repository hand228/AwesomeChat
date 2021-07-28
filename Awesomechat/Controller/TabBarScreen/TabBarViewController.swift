//
//  TabBarViewController.swift
//  Awesomechat
//
//  Created by MaiNQ on 14/07/2021.
//

import UIKit

class TabBarViewController: UIViewController {

    // Khởi tạo file nib
    let mesVC = MesengerController(nibName: "MesengerController", bundle: nil)
    let groupVC = GroupViewController(nibName: "GroupViewController", bundle: nil)
    let homeVC = HomeViewController(nibName: "HomeViewController", bundle: nil)
    
    // Outlets
    @IBOutlet weak var layerInside: UIView!
    @IBOutlet weak var contentView: UIView!
    
    @IBOutlet weak var mesImg: UIImageView!
    @IBOutlet weak var groupImg: UIImageView!
    @IBOutlet weak var homeImg: UIImageView!
    
    @IBOutlet weak var mesLbl: UILabel!
    @IBOutlet weak var groupLbl: UILabel!
    @IBOutlet weak var homeLbl: UILabel!
    
    @IBOutlet weak var mesDot: UIImageView!
    @IBOutlet weak var groupDot: UIImageView!
    @IBOutlet weak var homeDot: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        borderLayer()
        
        mesImg.image = UIImage(named: "m")
        groupImg.image = UIImage(named: "g")
        homeImg.image = UIImage(named: "h")
        
        initScreen()
    }

    // Bo tròn tab bar
    func borderLayer() {
        layerInside.layer.cornerRadius = layerInside.frame.size.height / 5
        layerInside.clipsToBounds = true
    }
    
    // Tab tin nhắn
    func initScreen() {
        mesImg.image = UIImage(named: "m_selected")
        groupImg.image = UIImage(named: "g")
        homeImg.image = UIImage(named: "h")
        
        mesLbl.textColor = UIColor.myBlue
        groupLbl.textColor = .lightGray
        homeLbl.textColor = .lightGray
        
        mesDot.image = UIImage(named: "dot")
        groupDot.image = UIImage(named: "")
        homeDot.image = UIImage(named: "")
        
        contentView.addSubview(mesVC.view)
        mesVC.didMove(toParent: self)
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
            
            mesDot.image = UIImage(named: "")
            groupDot.image = UIImage(named: "dot")
            homeDot.image = UIImage(named: "")

            contentView.addSubview(groupVC.view)
            groupVC.didMove(toParent: self)
        } else {
            homeImg.image = UIImage(named: "h_selected")
            mesImg.image = UIImage(named: "m")
            groupImg.image = UIImage(named: "g")
            
            mesLbl.textColor = .lightGray
            groupLbl.textColor = .lightGray
            homeLbl.textColor = UIColor.myBlue
            
            mesDot.image = UIImage(named: "")
            groupDot.image = UIImage(named: "")
            homeDot.image = UIImage(named: "dot")
        
            contentView.addSubview(homeVC.view)
            homeVC.didMove(toParent: self)
        }
    }
}


