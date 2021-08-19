//
//  AllTableViewCell.swift
//  Awesomechat
//
//  Created by Apple on 2021/8/9.
//

import UIKit

class AllTableViewCell: UITableViewCell {

    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var btn: UIButton! {
        didSet {
            btn.layer.cornerRadius = btn.frame.size.height / 2
            btn.layer.borderWidth = 1
            btn.layer.borderColor = UIColor.myBlue.cgColor
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
