//
//  FriendTableViewCell.swift
//  KOKO
//
//  Created by David Shiue on 2025/10/17.
//

import UIKit

class FriendTableViewCell: UITableViewCell {
    @IBOutlet weak var startImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var inviteArea: UIView!
    @IBOutlet weak var transferButton: UIButton!
    @IBOutlet weak var transferButton1: UIButton!
    @IBOutlet weak var invitingButton: UIButton!
    
    var friend: Friend = Friend(name: "unknow", status: 0, isTop: "0", fid: "000", updateDate: "20010101"){
        didSet{
            if friend.isTop == "1" {
                startImageView.isHidden = false
            } else {
                startImageView.isHidden = true
            }
            nameLabel.text = friend.name
            if friend.status == 2 {
                inviteArea.isHidden = false
            } else {
                inviteArea.isHidden = true
            }
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        transferButton.layer.borderWidth = 2.0
        transferButton.layer.borderColor = UIColor(red: 236/255, green: 0/255, blue: 140/255, alpha: 1).cgColor
        transferButton1.layer.borderWidth = 2.0
        transferButton1.layer.borderColor = UIColor(red: 236/255, green: 0/255, blue: 140/255, alpha: 1).cgColor
        invitingButton.layer.borderWidth = 2.0
        invitingButton.layer.borderColor = UIColor.gray.cgColor

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
