//
//  FriendViewController.swift
//  KOKO
//
//  Created by David Shiue on 2025/10/16.
//

import UIKit

class FriendViewController: UIViewController {
    @IBOutlet weak var myNameLabel: UILabel!
    @IBOutlet weak var myIdLabel: UILabel!
    @IBOutlet weak var friendInviteArea: UIView!
    @IBOutlet weak var friendInviteTableView: UITableView!
    @IBOutlet weak var friendTableView: UITableView!
    @IBOutlet weak var noFriendView: UIView!
    @IBOutlet weak var addFriendTextView: UITextView!
    
    private var friendViewModel = FriendViewModel(){
        didSet{
            self.friendViewModel.bindManToViewController = { [weak self] in
                DispatchQueue.main.async {
                    if let self = self {
                        self.myNameLabel.text = self.friendViewModel.man.name
                        self.myIdLabel.text = self.friendViewModel.man.id
                    }
                }

            }
            self.friendViewModel.bindFriendsToViewController = { [weak self] in
                DispatchQueue.main.async {
                    if let self = self {
                        self.friendInviteTableView.reloadData()
                        self.friendTableView.reloadData()
                    }
                }

            }

            /*DispatchQueue.main.async {
                self.noFileView.isHidden = self.localListViewModel.viewModels.count == 0 ? false : true
                self.tableView.reloadData()
            }*/
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let nib1 = UINib(nibName: "FriendInviteTableViewCell", bundle: nil)
        friendInviteTableView.register(nib1, forCellReuseIdentifier: "FriendInviteTableViewCell")
        
        let nib2 = UINib(nibName: "FriendTableViewCell", bundle: nil)
        friendTableView.register(nib2, forCellReuseIdentifier: "FriendTableViewCell")

        let attributedText = NSMutableAttributedString()
        
        // 标题
        let title = NSAttributedString(
            string: "幫助好友更快找到你？",
            attributes: [
                .font: UIFont.boldSystemFont(ofSize: 14),
                .foregroundColor: UIColor.gray
            ]
        )
        
        // 正文
        let body = NSAttributedString(
            string: "設定 KOKO ID",
            attributes: [
                .font: UIFont.systemFont(ofSize: 14),
                .foregroundColor: UIColor.systemPink,
                .underlineStyle: NSUnderlineStyle.single.rawValue  // 加入底線

            ]
        )
                
        attributedText.append(title)
        attributedText.append(body)
        
        addFriendTextView.attributedText = attributedText

        //WebApiManager.shared.getFriend1()
        self.friendViewModel.bindManToViewController = { [weak self] in
            DispatchQueue.main.async {
                if let self = self {
                    self.myNameLabel.text = self.friendViewModel.man.name
                    self.myIdLabel.text = "KOKO ID： " + self.friendViewModel.man.id
                }
            }
        }
        self.friendViewModel.bindFriendsToViewController = { [weak self] in
            DispatchQueue.main.async {
                if let self = self {
                    if self.friendViewModel.friends_invite.count == 0 {
                        self.friendInviteArea.isHidden = true
                    } else {
                        self.friendInviteArea.isHidden = false
                    }
                    if self.friendViewModel.friends_list.count == 0 {
                        self.noFriendView.isHidden = false
                    } else {
                        self.noFriendView.isHidden = true

                    }
                    self.friendInviteTableView.reloadData()
                    self.friendTableView.reloadData()
                }
            }

        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // 隐藏导航栏
        friendViewModel.getMan()
        friendViewModel.getFriends(sceneIndex: GlobalData.shared.scene)
        //navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension FriendViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if tableView == friendInviteTableView {
            return 80.0
        }else{
            return 60.0
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == friendInviteTableView {
            return friendInviteTableView(numberOfRowsInSection: section)
        }else{
            return friendTableView(numberOfRowsInSection: section)
        }
    }
        
    func friendInviteTableView(numberOfRowsInSection section: Int) -> Int {
        return friendViewModel.friends_invite.count
    }
        
    func friendTableView(numberOfRowsInSection section: Int) -> Int {
        return friendViewModel.friends_list.count
    }
}

extension FriendViewController: UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == friendInviteTableView {
            return friendInviteTableView(cellForRowAt: indexPath)
        }else{
            return friendTableView(cellForRowAt: indexPath)
        }
    }
    
    func friendInviteTableView(cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:FriendInviteTableViewCell  = self.friendInviteTableView.dequeueReusableCell(withIdentifier: "FriendInviteTableViewCell",for: indexPath) as! FriendInviteTableViewCell
        let friend = friendViewModel.friends_invite[indexPath.row]
        cell.friend = friend
        return cell
    }
    
    func friendTableView(cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:FriendTableViewCell = self.friendTableView.dequeueReusableCell(withIdentifier: "FriendTableViewCell",for: indexPath) as! FriendTableViewCell
        let friend = friendViewModel.friends_list[indexPath.row]
        cell.friend = friend
        return cell
    }
    
}
