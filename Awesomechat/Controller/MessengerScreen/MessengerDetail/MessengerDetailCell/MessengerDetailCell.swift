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
    let imgMessenger = UIImageView()
    let contentViews = UIView()
    
    var leadingLabelMessenger = NSLayoutConstraint()
    var trailingLabelMessenger = NSLayoutConstraint()
    var topLabelMessenger = NSLayoutConstraint()
    var bottomLabelMessenger = NSLayoutConstraint()
    
    var leadingViewContentMessenger = NSLayoutConstraint()
    var trailingViewContentMessenger = NSLayoutConstraint()
    var topViewContentMessenger = NSLayoutConstraint()
    var bottomViewContentMessenger = NSLayoutConstraint()
    
    var leadingDateMessenger = NSLayoutConstraint()
    var trailingDateMessenger = NSLayoutConstraint()
    var topDateMessenger = NSLayoutConstraint()
    
    var leadingDateImgMessenger = NSLayoutConstraint()
    var trailingDateImgMessenger = NSLayoutConstraint()

    var leadingImgMessenger = NSLayoutConstraint()
    var trailingImgMessenger = NSLayoutConstraint()
    var type: String! {
        didSet {
            if (type == "image") {
                
            } else if (type == "text") {
            
            }
        }
    }
    
    var isInComing: Bool! {
        didSet {
            if (isInComing == true) {

                if (type == "image") {

                    leadingImgMessenger.isActive = true
                    leadingDateImgMessenger.isActive = true
                    trailingImgMessenger.isActive = false
                    trailingDateImgMessenger.isActive = false

                    leadingDateMessenger.isActive = false
                    leadingLabelMessenger.isActive = false
                    trailingDateMessenger.isActive = false
                    trailingLabelMessenger.isActive = false
                    topLabelMessenger.isActive = false
                    bottomLabelMessenger.isActive = false
                    
                    leadingViewContentMessenger.isActive = false
                    trailingViewContentMessenger.isActive = false
                    topViewContentMessenger.isActive = false
                    bottomViewContentMessenger.isActive = false

                    //imgAvatarCell.image = UIImage(named: "")

                } else if (type == "text") {
                    leadingDateMessenger.isActive = true
                    leadingLabelMessenger.isActive = true
                    trailingDateMessenger.isActive = false
                    trailingLabelMessenger.isActive = false
                    topLabelMessenger.isActive = false
                    bottomLabelMessenger.isActive = true
                    topDateMessenger.isActive = true
                    
                    leadingViewContentMessenger.isActive = true
                    trailingViewContentMessenger.isActive = true
                    topViewContentMessenger.isActive = true
                    bottomViewContentMessenger.isActive = true

                    leadingImgMessenger.isActive = false
                    trailingImgMessenger.isActive = false
                    leadingDateImgMessenger.isActive = false
                    leadingDateImgMessenger.isActive = false

                    viewContentMessenger.backgroundColor = UIColor(rgb: 0xffE5E5E5)
                    lbContentMessenger.textColor = UIColor.black
                }

            } else {

                if (type == "image") {
                    leadingImgMessenger.isActive = false
                    leadingDateImgMessenger.isActive = false
                    trailingImgMessenger.isActive = true
                    trailingDateImgMessenger.isActive = true

                    leadingDateMessenger.isActive = false
                    leadingLabelMessenger.isActive = false
                    trailingDateMessenger.isActive = false
                    trailingLabelMessenger.isActive = false
                    topLabelMessenger.isActive = false
                    bottomLabelMessenger.isActive = false
                    
                    leadingViewContentMessenger.isActive = false
                    trailingViewContentMessenger.isActive = false
                    topViewContentMessenger.isActive = false
                    bottomViewContentMessenger.isActive = false
                    
                    imgAvatarCell.image = UIImage(named: "")
                } else if (type == "text") {

                    leadingDateMessenger.isActive = false
                    leadingLabelMessenger.isActive = false
                    trailingDateMessenger.isActive = true
                    trailingLabelMessenger.isActive = true
                    topLabelMessenger.isActive = true
                    bottomLabelMessenger.isActive = false
                    topDateMessenger.isActive = true
                    
                    leadingViewContentMessenger.isActive = true
                    trailingViewContentMessenger.isActive = true
                    topViewContentMessenger.isActive = true
                    bottomViewContentMessenger.isActive = true
                    
                    leadingImgMessenger.isActive = false
                    trailingImgMessenger.isActive = false
                    leadingDateImgMessenger.isActive = false
                    leadingDateImgMessenger.isActive = false

                    viewContentMessenger.backgroundColor = UIColor(rgb: 0xff4356B4)
                    lbContentMessenger.textColor = UIColor.white
                    imgAvatarCell.image = UIImage(named: "")
                }
            }
        }
    }
    
    // MARK: REUSE CELL
    override func prepareForReuse() {
        super.prepareForReuse()
        
        if (type == "image") {
            imgMessenger.image = nil
            lbContentMessenger.text = nil
            
        } else if (type == "text") {
            lbContentMessenger.text = nil
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
        customCellCode()
        
    }

    required init?(coder: NSCoder) {
        //super.init(coder: coder)
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func customCellCode() {
        addSubview(contentViews)
        contentViews.addSubview(viewContentMessenger)
        contentViews.addSubview(lbContentMessenger)
        contentViews.addSubview(lbDateMessenger)
        contentViews.addSubview(imgAvatarCell)
        contentViews.addSubview(imgMessenger)
        
        // MARK: CHECK MESSENGER:
        contentViews.translatesAutoresizingMaskIntoConstraints = false
        lbContentMessenger.translatesAutoresizingMaskIntoConstraints = false
        viewContentMessenger.translatesAutoresizingMaskIntoConstraints = false
        lbDateMessenger.translatesAutoresizingMaskIntoConstraints = false
        imgAvatarCell.translatesAutoresizingMaskIntoConstraints = false
        imgMessenger.translatesAutoresizingMaskIntoConstraints = false
        
        let activate = [
            
            contentViews.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            contentViews.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0),
            contentViews.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0),
            contentViews.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
            
            imgAvatarCell.topAnchor.constraint(equalTo: contentViews.topAnchor, constant: 12),
            imgAvatarCell.leadingAnchor.constraint(equalTo: contentViews.leadingAnchor, constant: 12),
            imgAvatarCell.heightAnchor.constraint(equalToConstant: 35),
            imgAvatarCell.widthAnchor.constraint(equalToConstant: 35),
            
//            viewContentMessenger.topAnchor.constraint(equalTo: lbContentMessenger.topAnchor, constant: -15),
//            viewContentMessenger.bottomAnchor.constraint(equalTo: lbContentMessenger.bottomAnchor, constant: 15),
//            viewContentMessenger.leadingAnchor.constraint(equalTo: lbContentMessenger.leadingAnchor, constant: -15),
//            viewContentMessenger.trailingAnchor.constraint(equalTo: lbContentMessenger.trailingAnchor, constant: 20),

//            lbContentMessenger.topAnchor.constraint(equalTo: contentViews.topAnchor, constant: 30),
//            lbContentMessenger.bottomAnchor.constraint(equalTo: contentViews.bottomAnchor, constant: -40),
//            lbContentMessenger.widthAnchor.constraint(lessThanOrEqualToConstant: 285),


            //lbDateMessenger.topAnchor.constraint(equalTo: viewContentMessenger.bottomAnchor, constant: 5),
            lbDateMessenger.bottomAnchor.constraint(equalTo: contentViews.bottomAnchor, constant: -10),
            lbDateMessenger.heightAnchor.constraint(equalToConstant: 20),

            imgMessenger.topAnchor.constraint(equalTo: contentViews.topAnchor, constant: 15),
            imgMessenger.widthAnchor.constraint(lessThanOrEqualToConstant: 200),
            imgMessenger.heightAnchor.constraint(lessThanOrEqualToConstant: 200),
            
           //// imgMessenger.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            
        ]
        NSLayoutConstraint.activate(activate)
        
        leadingViewContentMessenger = viewContentMessenger.leadingAnchor.constraint(equalTo: lbContentMessenger.leadingAnchor, constant: -15)
        trailingViewContentMessenger = viewContentMessenger.trailingAnchor.constraint(equalTo: lbContentMessenger.trailingAnchor, constant: 20)
        topViewContentMessenger = viewContentMessenger.topAnchor.constraint(equalTo: lbContentMessenger.topAnchor, constant: -15)
        bottomViewContentMessenger = viewContentMessenger.bottomAnchor.constraint(equalTo: lbContentMessenger.bottomAnchor, constant: 15)
        
        
        leadingLabelMessenger = lbContentMessenger.leadingAnchor.constraint(equalTo: contentViews.leadingAnchor, constant: 70)
        trailingLabelMessenger = lbContentMessenger.trailingAnchor.constraint(equalTo: contentViews.trailingAnchor , constant: -30)
        topLabelMessenger = lbContentMessenger.topAnchor.constraint(equalTo: contentViews.topAnchor, constant: 5)
        bottomLabelMessenger = lbContentMessenger.bottomAnchor.constraint(equalTo: contentViews.bottomAnchor, constant: 0)
        

        leadingDateMessenger = lbDateMessenger.leadingAnchor.constraint(equalTo: contentViews.leadingAnchor, constant: 56)
        trailingDateMessenger = lbDateMessenger.trailingAnchor.constraint(equalTo: contentViews.trailingAnchor, constant: -12)
        topDateMessenger = lbDateMessenger.topAnchor.constraint(equalTo: viewContentMessenger.bottomAnchor, constant: 5)

        leadingDateImgMessenger = lbDateMessenger.leadingAnchor.constraint(equalTo: imgMessenger.trailingAnchor, constant: 20)
        trailingDateImgMessenger = lbDateMessenger.trailingAnchor.constraint(equalTo: imgMessenger.leadingAnchor, constant: -20)
        

        leadingImgMessenger = imgMessenger.leadingAnchor.constraint(equalTo: contentViews.leadingAnchor, constant: 56)
        trailingImgMessenger = imgMessenger.trailingAnchor.constraint(equalTo: contentViews.trailingAnchor , constant: -12)
        
        lbContentMessenger.numberOfLines = 0
        lbContentMessenger.font = UIFont(name: "Lato", size: 16)
        viewContentMessenger.layer.cornerRadius = 20
        viewContentMessenger.clipsToBounds = true
        lbDateMessenger.textColor = UIColor(rgb: 0xff999999)
        
        
        imgMessenger.layer.cornerRadius = 20
        imgMessenger.clipsToBounds = true
        imgMessenger.contentMode = .scaleToFill
        
    }
}


