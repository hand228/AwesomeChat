//
//  MesengerHeader.swift
//  Awesomechat
//
//  Created by LongDN on 12/07/2021.
//

import UIKit

class MesengerHeader: UIView {

    @IBOutlet var contenView: UIView!
    @IBOutlet weak var lbTest: UILabel!
    @IBOutlet weak var imgIconChat: UIImageView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupFileXib()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupFileXib()
        
        
    }
    
    func setupFileXib() {
        Bundle.main.loadNibNamed("MesengerHeader", owner: self, options: nil)
        self.addSubview(contenView)
        
        contenView.backgroundColor = UIColor(rgb: 0xff4356B4)
        
        contenView.topAnchor.constraint(equalTo: self.topAnchor, constant: 0).isActive = true
        contenView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0).isActive = true
        contenView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0).isActive = true
        contenView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0).isActive = true
        
        
        imgIconChat.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tapGesture)))
        imgIconChat.isUserInteractionEnabled = true
        customGradients()
        
    }
    
    @objc func tapGesture() {
        print("mmmmmmmmmmmmmmmm")
    }
    
    
    func customGradients() {
        let colorTop =  UIColor(rgb: 0xff4356B4).cgColor
        let colorBottom = UIColor(rgb: 0xff3DCFCF).cgColor
                    
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [colorTop, colorBottom]
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.frame = CGRect(x: 0.0, y: 0.0, width: self.contenView.frame.size.width, height: self.contenView.frame.size.height )
                
        self.contenView.layer.addSublayer(gradientLayer)
        self.contenView.addSubview(lbTest)
        self.contenView.addSubview(imgIconChat)
        self.contenView.addSubview(searchBar)
        //contenView.addSubview(tableView)
        
    }

}
