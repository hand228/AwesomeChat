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
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
    
    
}
