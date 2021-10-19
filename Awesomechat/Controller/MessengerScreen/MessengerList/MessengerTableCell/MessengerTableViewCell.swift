//
//  MessengerTableViewCell.swift
//  Awesomechat
//
//  Created by LongDN on 05/07/2021.
//

import UIKit

class MessengerTableViewCell: UITableViewCell {
    
    var lbName = UILabel()
    var lbMesenger = UILabel()
    var lbHours = UILabel()
    var imgAvatar = UIImageView()
    var viewContent = UIView()
    var lbNumber = UILabel()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        customCode()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
    func customImgIsRead(numberIsRead: Int) {
        
        viewContent.backgroundColor = UIColor(rgb: 0xff4356B4)
        viewContent.clipsToBounds = false
        
        imgAvatar.backgroundColor = UIColor.white
        imgAvatar.layer.borderWidth = 4
        imgAvatar.layer.borderColor = UIColor.white.cgColor
        imgAvatar.clipsToBounds = false
        
        viewContent.addSubview(lbNumber)
        lbNumber.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint(item: lbNumber, attribute: .centerX, relatedBy: .equal, toItem: viewContent, attribute: .centerX, multiplier: 1.75, constant: 0).isActive = true
        NSLayoutConstraint(item: lbNumber, attribute: .centerY, relatedBy: .equal, toItem: viewContent, attribute: .centerY, multiplier: 0.5, constant: 0).isActive = true
        lbNumber.heightAnchor.constraint(equalToConstant: 25).isActive = true
        lbNumber.widthAnchor.constraint(equalToConstant: 25).isActive = true
        
        lbNumber.backgroundColor = UIColor(rgb: 0xffC92323)
        lbNumber.clipsToBounds = true
        lbNumber.layer.cornerRadius = CGFloat(12)
        lbNumber.layer.borderColor = UIColor.white.cgColor
        lbNumber.layer.borderWidth = 2.5
        lbNumber.text = String(numberIsRead)
        lbNumber.textColor = UIColor.white
        lbNumber.textAlignment = .center
        lbNumber.font = UIFont(name: "Lato", size: 12)
        lbNumber.sizeToFit()
        
    }
    
    
    func customCode() {
        contentView.addSubview(viewContent)
        contentView.addSubview(lbName)
        contentView.addSubview(lbMesenger)
        contentView.addSubview(lbHours)
        viewContent.addSubview(imgAvatar)
        
        viewContent.translatesAutoresizingMaskIntoConstraints = false
        lbName.translatesAutoresizingMaskIntoConstraints = false
        lbMesenger.translatesAutoresizingMaskIntoConstraints = false
        lbHours.translatesAutoresizingMaskIntoConstraints = false
        imgAvatar.translatesAutoresizingMaskIntoConstraints = false
        
        viewContent.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 22).isActive = true
        viewContent.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12).isActive = true
        viewContent.heightAnchor.constraint(equalToConstant: 56).isActive = true
        viewContent.widthAnchor.constraint(equalToConstant: 56).isActive = true
        viewContent.layer.cornerRadius = CGFloat(28)
        
        
        imgAvatar.topAnchor.constraint(equalTo: viewContent.topAnchor, constant: 3).isActive = true
        imgAvatar.leadingAnchor.constraint(equalTo: viewContent.leadingAnchor, constant: 3).isActive = true
        imgAvatar.trailingAnchor.constraint(equalTo: viewContent.trailingAnchor, constant: -3).isActive = true
        imgAvatar.bottomAnchor.constraint(equalTo: viewContent.bottomAnchor, constant: -3).isActive = true
        imgAvatar.layer.cornerRadius = CGFloat(24)
        
        
        lbName.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 22).isActive = true
        lbName.heightAnchor.constraint(equalToConstant: 21).isActive = true
        lbName.leadingAnchor.constraint(equalTo: viewContent.trailingAnchor, constant: 20).isActive = true
        lbName.widthAnchor.constraint(equalToConstant: 180).isActive = true
        
        lbMesenger.topAnchor.constraint(equalTo: lbName.bottomAnchor, constant: 8).isActive = true
        lbMesenger.leadingAnchor.constraint(equalTo: viewContent.trailingAnchor, constant: 20).isActive = true
        lbMesenger.widthAnchor.constraint(equalToConstant: 180).isActive = true
        lbMesenger.heightAnchor.constraint(equalToConstant: 19).isActive = true
       
        
        lbHours.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 22).isActive = true
        lbHours.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12).isActive = true
        lbHours.heightAnchor.constraint(equalToConstant: 21).isActive = true
        
    }
    
    
}
