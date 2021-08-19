//
//  RequestTableViewCell.swift
//  Awesomechat
//
//  Created by Apple on 2021/8/5.
//

import UIKit
import Firebase

class RequestTableViewCell: UITableViewCell {

    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var btn: UIButton!
        
    var friendType: DataFriend? {
        didSet {
            name.text = friendType?.info?.userName
            img.image = UIImage(named: "default")
            btn.layer.cornerRadius = btn.frame.size.height / 2
            btn.layer.borderWidth = 1
            btn.layer.borderColor = UIColor.myBlue.cgColor
            if friendType?.type == FriendType.sendRequest {
                btn.setTitle("Huỷ", for: .normal)
                btn.setTitleColor(UIColor.myBlue, for: .normal)
                btn.backgroundColor = .white
            } else if friendType?.type == FriendType.friendRequest {
                btn.setTitle("Đồng ý", for: .normal)
                btn.setTitleColor(UIColor.white, for: .normal)
                btn.backgroundColor = UIColor.myBlue
            }
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

