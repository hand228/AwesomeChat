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
    var strocke = UIView()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        customCode()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
    func customImgCycleIsRead(numberIsRead: Int) {
        imgAvatar.clipsToBounds = true
        viewContent.addSubview(imgAvatar)
        
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
        // trong này sẽ contraint. Còn trong hàm kia sẽ dùng AddSubView()
        
        viewContent.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 22).isActive = true
        viewContent.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12).isActive = true
        viewContent.heightAnchor.constraint(equalToConstant: 58).isActive = true
        viewContent.widthAnchor.constraint(equalToConstant: 58).isActive = true
        viewContent.backgroundColor = UIColor.cyan
        
        imgAvatar.topAnchor.constraint(equalTo: viewContent.topAnchor, constant: 5).isActive = true
        imgAvatar.leadingAnchor.constraint(equalTo: viewContent.leadingAnchor, constant: 5).isActive = true
        imgAvatar.trailingAnchor.constraint(equalTo: viewContent.trailingAnchor, constant: -5).isActive = true
        imgAvatar.bottomAnchor.constraint(equalTo: viewContent.bottomAnchor, constant: -5).isActive = true
        
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
    
    func customImgNoIsRead() {
        //viewContent.addSubview(imgAvatar)
        
    }
    
}
