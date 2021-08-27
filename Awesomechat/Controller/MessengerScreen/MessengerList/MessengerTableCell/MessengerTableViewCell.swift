//
//  MessengerTableViewCell.swift
//  Awesomechat
//
//  Created by LongDN on 05/07/2021.
//

import UIKit

class MessengerTableViewCell: UITableViewCell {
    
    @IBOutlet weak var imgAvatar: UIImageView!
    @IBOutlet weak var lbName: UILabel!
    @IBOutlet weak var lbMesenger: UILabel!
    @IBOutlet weak var lbHours: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        customMessengerTableViewCell()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
    func customMessengerTableViewCell() {
        lbName.font = UIFont(name: "Lato", size: 22)
        
        // check tin nhắn đã đọc hoặc đọc rồi, sau đó hiển thị lại các label và hiện thông báo trên avartar:
        
        
        
        print("cccccccc")
    }
    
}
