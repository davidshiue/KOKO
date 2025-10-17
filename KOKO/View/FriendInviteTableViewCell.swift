//
//  FriendInviteTableViewCell.swift
//  KOKO
//
//  Created by David Shiue on 2025/10/17.
//

import UIKit

class FriendInviteTableViewCell: UITableViewCell {
    
    @IBOutlet weak var panel: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        panel.layer.cornerRadius = 6
        panel.layer.shadowOpacity = 0.1
        panel.layer.shadowOffset = CGSize(width: 0, height: 4)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
