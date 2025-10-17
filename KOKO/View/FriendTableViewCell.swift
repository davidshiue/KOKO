//
//  FriendTableViewCell.swift
//  KOKO
//
//  Created by David Shiue on 2025/10/17.
//

import UIKit

class FriendTableViewCell: UITableViewCell {
    @IBOutlet weak var transferButton: UIButton!
    
    @IBOutlet weak var invitingButton: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        transferButton.layer.borderWidth = 2.0
        transferButton.layer.borderColor = UIColor(red: 236/255, green: 0/255, blue: 140/255, alpha: 1).cgColor
        invitingButton.layer.borderWidth = 2.0
        invitingButton.layer.borderColor = UIColor.gray.cgColor

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
