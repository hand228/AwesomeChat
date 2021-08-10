//
//  MessengerDetailCell.swift
//  Awesomechat
//
//  Created by admin on 8/2/21.
//

import UIKit

class MessengerDetailCell: UITableViewCell {


    let imgAvatarCell = UIImageView()
    let lbDateMessenger = UILabel()
    let viewContentMessenger = UIView()
    let lbContentMessenger = UILabel()
    
    var leadingLabelMessenger = NSLayoutConstraint()
    var trailingLabelMessenger = NSLayoutConstraint()
    var leadingDateMessenger = NSLayoutConstraint()
    var trailingDateMessenger = NSLayoutConstraint()
    
    var isInComing: Bool! {
        
        didSet {
            
            if (isInComing == true) {
                leadingDateMessenger.isActive = true
                leadingLabelMessenger.isActive = true
                trailingDateMessenger.isActive = false
                trailingLabelMessenger.isActive = false
                viewContentMessenger.backgroundColor = UIColor(rgb: 0xffE5E5E5)
                lbContentMessenger.textColor = UIColor.black
                
                
            } else {
                leadingDateMessenger.isActive = false
                leadingLabelMessenger.isActive = false
                trailingDateMessenger.isActive = true
                trailingLabelMessenger.isActive = true
                
                viewContentMessenger.backgroundColor = UIColor(rgb: 0xff4356B4)
                lbContentMessenger.textColor = UIColor.white
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        customCellCode()
        
        
    }

    required init?(coder: NSCoder) {
        //super.init(coder: coder)
        fatalError("init(coder:) has not been implemented")
    }
    
   
    func customCellCode() {
        
        //viewContentMessenger.addSubview(lbContentMessenger)
       
        addSubview(viewContentMessenger)
        addSubview(lbContentMessenger)
        addSubview(lbDateMessenger)
        addSubview(imgAvatarCell)
        lbContentMessenger.translatesAutoresizingMaskIntoConstraints = false
        viewContentMessenger.translatesAutoresizingMaskIntoConstraints = false
        lbDateMessenger.translatesAutoresizingMaskIntoConstraints = false
        imgAvatarCell.translatesAutoresizingMaskIntoConstraints = false
        
        let activate = [
            
            imgAvatarCell.topAnchor.constraint(equalTo: topAnchor, constant: 12),
            imgAvatarCell.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
            imgAvatarCell.heightAnchor.constraint(equalToConstant: 35),
            imgAvatarCell.widthAnchor.constraint(equalToConstant: 35),
            
            viewContentMessenger.topAnchor.constraint(equalTo: lbContentMessenger.topAnchor, constant: -15),
            viewContentMessenger.bottomAnchor.constraint(equalTo: lbContentMessenger.bottomAnchor, constant: 15),
            viewContentMessenger.leadingAnchor.constraint(equalTo: lbContentMessenger.leadingAnchor, constant: -15),
            viewContentMessenger.trailingAnchor.constraint(equalTo: lbContentMessenger.trailingAnchor, constant: 20),
            
            lbContentMessenger.topAnchor.constraint(equalTo: topAnchor, constant: 30),
            lbContentMessenger.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -40),
            lbContentMessenger.widthAnchor.constraint(lessThanOrEqualToConstant: 285),
             
            lbDateMessenger.widthAnchor.constraint(equalToConstant: 60),
            lbDateMessenger.topAnchor.constraint(equalTo: viewContentMessenger.bottomAnchor, constant: 5),
            lbDateMessenger.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0),
            lbDateMessenger.heightAnchor.constraint(equalToConstant: 20),
            
        ]
        
        NSLayoutConstraint.activate(activate)
        leadingLabelMessenger = lbContentMessenger.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 70)
        trailingLabelMessenger = lbContentMessenger.trailingAnchor.constraint(equalTo: trailingAnchor , constant: -30)
        
        leadingDateMessenger = lbDateMessenger.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 56)
        trailingDateMessenger = lbDateMessenger.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12)
        
        
        lbContentMessenger.numberOfLines = 0
        lbContentMessenger.font = UIFont(name: "Lato", size: 16)
        viewContentMessenger.layer.cornerRadius = 20
        viewContentMessenger.clipsToBounds = true
        lbDateMessenger.backgroundColor = UIColor.cyan
        
    }
    
}


