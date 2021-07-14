//
//  TabBarViewController.swift
//  Awesomechat
//
//  Created by MaiNQ on 14/07/2021.
//

import UIKit

class TabBarViewController: UIViewController {

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
    
    func initScreen() {
        mesImg.image = UIImage(named: "m_selected")
        groupImg.image = UIImage(named: "g")
        homeImg.image = UIImage(named: "h")
        
        mesLbl.textColor = UIColor(red: 67.0/255.0, green: 86.0/255.0, blue: 180.0/255.0, alpha: 1)
        groupLbl.textColor = .lightGray
        homeLbl.textColor = .lightGray
        
        mesDot.image = UIImage(named: "dot")
        groupDot.image = UIImage(named: "")
        homeDot.image = UIImage(named: "")
        
        let mes = MessengerViewController(nibName: "MessengerViewController", bundle: nil)
        contentView.addSubview(mes.view)
        mes.didMove(toParent: self)
    }
    
    @IBAction func clickTabBar(_ sender: UIButton) {
        let tag = sender.tag
        print(tag)
        
        // Tab tin nhắn
        if tag == 1 {
           initScreen()
        }
        
        // Tab bạn bè
        else if tag == 2 {
            groupImg.image = UIImage(named: "g_selected")
            mesImg.image = UIImage(named: "m")
            homeImg.image = UIImage(named: "h")
            
            groupLbl.textColor = UIColor(red: 67.0/255.0, green: 86.0/255.0, blue: 180.0/255.0, alpha: 1)
            mesLbl.textColor = .lightGray
            homeLbl.textColor = .lightGray
            
            mesDot.image = UIImage(named: "")
            groupDot.image = UIImage(named: "dot")
            homeDot.image = UIImage(named: "")

            let group = GroupViewController(nibName: "GroupViewController", bundle: nil)
            contentView.addSubview(group.view)
            group.didMove(toParent: self)
        }
        
        // Tab trang cá nhân
       else {
            homeImg.image = UIImage(named: "h_selected")
            mesImg.image = UIImage(named: "m")
            groupImg.image = UIImage(named: "g")
            
            mesLbl.textColor = .lightGray
            groupLbl.textColor = .lightGray
            homeLbl.textColor = UIColor(red: 67.0/255.0, green: 86.0/255.0, blue: 180.0/255.0, alpha: 1)
            
            mesDot.image = UIImage(named: "")
            groupDot.image = UIImage(named: "")
            homeDot.image = UIImage(named: "dot")
        
            let home = HomeViewController(nibName: "HomeViewController", bundle: nil)
            contentView.addSubview(home.view)
            home.didMove(toParent: self)
        }
    }
}


