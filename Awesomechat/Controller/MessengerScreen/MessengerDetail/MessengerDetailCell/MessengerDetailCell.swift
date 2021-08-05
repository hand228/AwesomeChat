//
//  MessengerDetailCell.swift
//  Awesomechat
//
//  Created by admin on 8/2/21.
//

import UIKit

class MessengerDetailCell: UITableViewCell {

    @IBOutlet weak var imgAvartarCell: UIImageView!
    @IBOutlet weak var lbDateMessenger: UILabel!
    @IBOutlet weak var viewContentMessenger: UIView!
    let lbContentMessenger = UILabel()
    
    var leadingLabelMessenger = NSLayoutConstraint()
    var trailingLabelMessenger = NSLayoutConstraint()
    var leadingDateMessenger = NSLayoutConstraint()
    var trailingDateMessenger = NSLayoutConstraint()
    

    var checkMessenger = 0
    var isInComing: Bool! {
        
        didSet {
            print("aaaaa")
            
             
            if (isInComing == true) {
                
                checkMessenger += 1
                leadingDateMessenger.isActive = true
                leadingLabelMessenger.isActive = true
                
                viewContentMessenger.backgroundColor = UIColor(rgb: 0xffE5E5E5)
                lbContentMessenger.textColor = UIColor.black
                
            } else {
                
                imgAvartarCell.removeFromSuperview()
                trailingDateMessenger.isActive = true
                trailingLabelMessenger.isActive = true
                
                viewContentMessenger.backgroundColor = UIColor(rgb: 0xff4356B4)
                lbContentMessenger.textColor = UIColor.white
                
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        customCellCode()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
//    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
//        super.init(style: style, reuseIdentifier: reuseIdentifier)
//        customCellCode()
//    }
//
//    required init?(coder: NSCoder) {
//        super.init(coder: coder)
//
//        //fatalError("init(coder:) has not been implemented")
//    }
    
   
    func customCellCode() {
        lbContentMessenger.translatesAutoresizingMaskIntoConstraints = false
        viewContentMessenger.translatesAutoresizingMaskIntoConstraints = false
        lbDateMessenger.translatesAutoresizingMaskIntoConstraints = false
        imgAvartarCell.translatesAutoresizingMaskIntoConstraints = false
        viewContentMessenger.addSubview(lbContentMessenger)
        addSubview(viewContentMessenger)
        addSubview(lbDateMessenger)
        addSubview(imgAvartarCell)
        
        let activate = [
            
            imgAvartarCell.topAnchor.constraint(equalTo: topAnchor, constant: 12),
            imgAvartarCell.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
            imgAvartarCell.heightAnchor.constraint(equalToConstant: 35),
            imgAvartarCell.widthAnchor.constraint(equalToConstant: 35),
            
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
        
        
    }
    
    override func layoutIfNeeded() {
         //customCellCode()
    }
    override func setNeedsDisplay() {
        //customCellCode()
        print("ccccc")
    }

    override func layoutSubviews() {
//        customCellCode()
        print("aaaaa")
    }
    
    
}


