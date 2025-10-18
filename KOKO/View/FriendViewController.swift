//
//  FriendViewController.swift
//  KOKO
//
//  Created by David Shiue on 2025/10/16.
//

import UIKit

class FriendViewController: UIViewController {
    @IBOutlet weak var showInviteAreaButton: UIButton!
    @IBOutlet weak var manArea: UIView!
    @IBOutlet weak var myNameLabel: UILabel!
    @IBOutlet weak var myIdLabel: UILabel!
    @IBOutlet weak var friendInviteArea: UIView!
    @IBOutlet weak var friendInviteTableView: UITableView!
    @IBOutlet weak var friendTableView: UITableView!
    @IBOutlet weak var noFriendView: UIView!
    //@IBOutlet weak var noFriendScrollView: UIScrollView!
    @IBOutlet weak var addFriendTextView: UITextView!
    
    private let searchController = UISearchController(searchResultsController: nil)
    private var filteredItems: [Friend] = []
    
    private var isSearching: Bool {
        return searchController.isActive && !(searchController.searchBar.text?.isEmpty ?? true)
    }
    
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
                        self.showInviteAreaButton.isHidden = true
                    } else {
                        self.friendInviteArea.isHidden = false
                        self.showInviteAreaButton.isHidden = false
                    }
                    if self.friendViewModel.friends_list.count == 0 {
                        //self.noFriendScrollView.isHidden = false
                        self.noFriendView.isHidden = false
                        self.noFriendView.frame.size.height = 445
                    } else {
                        //self.noFriendScrollView.isHidden = true
                        self.noFriendView.isHidden = true
                        self.noFriendView.frame.size.height = 0
                    }
                    self.friendInviteTableView.reloadData()
                    self.friendTableView.reloadData()
                }
            }
        }
        if GlobalData.shared.scene != 0 {
            setupSearchControllerInHeader()
            friendTableView.refreshControl = UIRefreshControl()
            friendTableView.refreshControl?.addTarget(self, action: #selector(handleRefresh), for: .valueChanged)
        }
    }
    
    private func setupSearchControllerInHeader() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "想轉一筆給誰呢？"
        searchController.searchBar.delegate = self
        
        // 将 searchBar 设置为 tableView 的 tableHeaderView
        friendTableView.tableHeaderView = searchController.searchBar
        
        // 设置 searchBar 的尺寸
        searchController.searchBar.sizeToFit()
        
        definesPresentationContext = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // 隐藏导航栏
        //navigationController?.setNavigationBarHidden(true, animated: animated)
        friendViewModel.getMan()
        friendViewModel.getFriends(sceneIndex: GlobalData.shared.scene)
    }

    override func viewDidAppear(_ animated: Bool) {
        //...
        friendTableView.refreshControl?.attributedTitle = NSAttributedString(string: "更新中...")
    }

    @objc func handleRefresh(){
        friendViewModel.getFriends(sceneIndex: GlobalData.shared.scene)
        friendTableView.refreshControl?.endRefreshing()
        friendTableView.reloadData()
    }
    
    @IBAction func showInviteClick(_ sender: Any) {
        showInviteAreaButton.isSelected.toggle()
        if showInviteAreaButton.isSelected && (friendViewModel.friends_invite.count > 0) {
            friendInviteArea.isHidden = false
        } else {
            friendInviteArea.isHidden = true
        }
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
        return isSearching ? filteredItems.count : friendViewModel.friends_list.count
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
        let friend = isSearching ? filteredItems[indexPath.row] : friendViewModel.friends_list[indexPath.row]

        cell.friend = friend
        return cell
    }
    
}

extension FriendViewController: UISearchResultsUpdating, UISearchBarDelegate {
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchText = searchController.searchBar.text?.lowercased() else { return }
        
        if searchText.isEmpty {
            filteredItems = friendViewModel.friends_list
        } else {
            // 过滤数据
            filteredItems = friendViewModel.friends_list.filter { $0.name.lowercased().contains(searchText) }
        }
        
        friendTableView.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        // 取消搜索时恢复原始数据
        filteredItems.removeAll()
        manArea.isHidden = false
        if self.friendViewModel.friends_invite.count == 0 {
            self.friendInviteArea.isHidden = true
        } else {
            self.friendInviteArea.isHidden = false
        }
        friendTableView.reloadData()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            // 搜索文本为空时显示所有数据
            filteredItems = friendViewModel.friends_list
            friendTableView.reloadData()
        }
    }
    
    /// 搜索栏开始编辑时调用（获得焦点）
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        print("搜索栏开始编辑")
        
        // 显示取消按钮
        searchBar.setShowsCancelButton(true, animated: true)
        
        manArea.isHidden = true
        friendInviteArea.isHidden = true
    }

}
