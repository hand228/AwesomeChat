//
//  FriendsController.swift
//  Awesomechat
//
//  Created by MaiNQ on 20/07/2021.
//

import UIKit

class FriendsController: UIViewController {
    

    // Outlets
    @IBOutlet weak var headerLayer: UIView!
    @IBOutlet weak var bodyLayer: UIView!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var header: UIView!
    
    // Các button
    
    @IBOutlet weak var friend: UILabel!
    @IBOutlet weak var all: UILabel!
    @IBOutlet weak var request: UILabel!
    @IBOutlet weak var titleTab: UILabel!
    
    // Đường gạch chân
    @IBOutlet weak var friendView: UIView!
    @IBOutlet weak var allView: UIView!
    @IBOutlet weak var requestView: UIView!
    @IBOutlet weak var separator: UIView!

    
    @IBOutlet weak var searchText: UITextField!
    
    @IBOutlet weak var requestsCounter: UILabel!
    
    @IBOutlet weak var searchResultTable: UITableView!
    
    let gradient = CAGradientLayer()
    let friendsTab = FriendsListViewController(nibName: "FriendsListViewController", bundle: nil)
    let allTab = AllViewController(nibName: "AllViewController", bundle: nil)
    let requestsTab = RequestViewController(nibName: "RequestViewController", bundle: nil)
    var requestGroup: [DataFriend] = []
    var isFriendTab: Bool = false
    var isAllTab: Bool = false
    var isRequestTab: Bool = false
    var originalArr: [DataUser] = []
    var sortedOriginalArr: [DataUser] = []
    var searchArrRes: [DataUser] = []
    var originalAllArr: [DataUser] = []
    var originalFriendsArr: [DataUser] = []
    var originalRequestsArr: [DataUser] = []

    var searching: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchResultTable.register(UINib(nibName: "FriendsTableViewCell", bundle: nil), forCellReuseIdentifier: "FriendsTableViewCellID")
        searchResultTable.delegate = self
        searchResultTable.dataSource = self
        searchText.delegate = self
        
        configureUI()
        initTab()
        countFriendRequest()
        getData()
        
//        searchBar.setupSearchBar()
    }
    
    // MARK: - Chỉnh sửa giao diện
    private func configureUI() {
        
        // Title of Tab
        titleTab.text = "Bạn bè".localized()
        friend.text = "Bạn bè".localized().uppercased()
        all.text = "Tất cả".localized().uppercased()
        request.text = "Yêu cầu".localized().uppercased()
        
        // Đổi màu cho header
        gradient.frame = headerLayer.bounds
        gradient.colors = [UIColor.colorTop, UIColor.colorBottom]
        headerLayer.layer.insertSublayer(gradient, at: 0)
        separator.backgroundColor = UIColor.viewBackground
        
        // Bo góc body layer
        bodyLayer.clipsToBounds = true
        bodyLayer.layer.cornerRadius = 35
        bodyLayer.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner] // Top right corner, Top left corner respectively
        
        // Chỉnh sửa phần hiển thị số yêu cầu kết bạn
        requestsCounter.backgroundColor = UIColor.counterBackground
        requestsCounter.text = ""
        requestsCounter.isHidden = true
        requestsCounter.textColor = UIColor.white
        requestsCounter.textAlignment = .center
        requestsCounter.font = UIFont(name: "Lato-Bold", size: 12)
        requestsCounter.layer.cornerRadius = requestsCounter.frame.size.width/2
        requestsCounter.clipsToBounds = true
        
        // Custom UI search field
        searchText.layer.cornerRadius = 20
        searchText.backgroundColor = UIColor.white
        searchText.clipsToBounds = true
        searchText.returnKeyType = .search
        searchText.font = UIFont(name: "Lato-Regular", size: 16)
        searchText.placeholder = "Tìm kiếm bạn bè...".localized()
//        let placeholder = searchText.placeholder ?? ""
//        searchText.attributedPlaceholder = NSAttributedString(string: placeholder, attributes: [NSAttributedString.Key.foregroundColor: UIColor.myGray])
        let iconView = UIImageView(frame:CGRect(x: 17, y: 5, width: 18, height: 18))
        iconView.image = UIImage(named: "search")
        let iconContainerView: UIView = UIView(frame:CGRect(x: 0, y: 0, width: 45, height: 30))
        iconContainerView.addSubview(iconView)
        searchText.leftView = iconContainerView
        searchText.leftViewMode = .always
        
        searchResultTable.isHidden = true
        searchResultTable.separatorStyle = .none
    }
    
    // MARK: - Khởi tạo tab ban đầu
    private func initTab() {
        friend.textColor = UIColor.myBlue
        friendView.backgroundColor = UIColor.myBlue
        
        all.textColor = UIColor.lightGray
        allView.backgroundColor = UIColor.white
        
        request.textColor = UIColor.lightGray
        requestView.backgroundColor = UIColor.white
        
        contentView.addSubview(friendsTab.view)
        friendsTab.didMove(toParent: self)
        
        allTab.willMove(toParent: nil)
        allTab.removeFromParent()
        allTab.view.removeFromSuperview()
        
        requestsTab.willMove(toParent: nil)
        requestsTab.removeFromParent()
        requestsTab.view.removeFromSuperview()
        
        isFriendTab = true
        isAllTab = false
        isRequestTab = false
    }
    
    // MARK: - Lấy dữ liệu hiển thị số yêu cầu kết bạn
    private func countFriendRequest() {
        ServerApiUser.shared.requestApiUser { _ in
            FriendAPI().getMyFriends { friends in
                self.requestGroup.removeAll()
                for friend in friends {
                    if friend.type == FriendType.friendRequest {
                        self.requestGroup.append(friend)
                    }
                }
                if self.requestGroup.isEmpty {
                    self.requestsCounter.isHidden = true
                } else {
                    self.requestsCounter.isHidden = false
                    self.requestsCounter.text = String(self.requestGroup.count)
                }
            }
        }
    }
    
    // MARK: - Lấy dữ liệu của mỗi tab để tìm kiếm
    private func getData() {
        ServerApiUser.shared.requestApiUser { users in
            self.originalAllArr = users
            FriendAPI().getMyFriends { friends in
                self.originalFriendsArr.removeAll()
                self.originalRequestsArr.removeAll()
                for f in friends {
                    if f.type == FriendType.friend {
                        if let friend = f.info {
                            self.originalFriendsArr.append(friend)
                        }
                        
                    } else if f.type == FriendType.friendRequest {
                        if let request = f.info {
                            self.originalRequestsArr.append(request)
                        }
                    }
                }
                self.originalFriendsArr.sort (by: {
                    var firstUser = $0.userName.components(separatedBy: " ")
                    var secondUser = $1.userName.components(separatedBy: " ")
                    let firstUserName = firstUser.removeLast()
                    let secondUserName = secondUser.removeLast()
                    return firstUserName.compare(secondUserName, locale: NSLocale(localeIdentifier: "vi_VN") as Locale) == .orderedAscending
                })
                self.originalRequestsArr.sort (by: {
                    var firstUser = $0.userName.components(separatedBy: " ")
                    var secondUser = $1.userName.components(separatedBy: " ")
                    let firstUserName = firstUser.removeLast()
                    let secondUserName = secondUser.removeLast()
                    return firstUserName.compare(secondUserName, locale: NSLocale(localeIdentifier: "vi_VN") as Locale) == .orderedAscending
                })
                
                print("Sorted Friend Array: \(self.originalFriendsArr)")
                print("Sorted Friend Request Array: \(self.originalRequestsArr)")
                self.searchResultTable.reloadData()
            }
            self.originalAllArr.sort (by: {
                var firstUser = $0.userName.components(separatedBy: " ")
                var secondUser = $1.userName.components(separatedBy: " ")
                let firstUserName = firstUser.removeLast()
                let secondUserName = secondUser.removeLast()
                return firstUserName.compare(secondUserName, locale: NSLocale(localeIdentifier: "vi_VN") as Locale) == .orderedAscending
            })
            print("Sorted All Array: \(self.originalAllArr)")
            self.searchResultTable.reloadData()
        }
    }

    // MARK: - Thêm action để di chuyển qua lại các tab
    @IBAction func clickBtn(_ sender: UIButton) {
        let tag = sender.tag
        
        if tag == 1 {
           initTab()
        } else if tag == 2 {
            all.textColor = UIColor.myBlue
            allView.backgroundColor = UIColor.myBlue
            
            friend.textColor = UIColor.lightGray
            friendView.backgroundColor = UIColor.white
            
            request.textColor = UIColor.lightGray
            requestView.backgroundColor = UIColor.white
            
            contentView.addSubview(allTab.view)
            allTab.didMove(toParent: self)
            
            friendsTab.willMove(toParent: nil)
            friendsTab.removeFromParent()
            friendsTab.view.removeFromSuperview()
            
            requestsTab.willMove(toParent: nil)
            requestsTab.removeFromParent()
            requestsTab.view.removeFromSuperview()
            
            isFriendTab = false
            isAllTab = true
            isRequestTab = false
        } else {
            request.textColor = UIColor.myBlue
            requestView.backgroundColor = UIColor.myBlue
            
            friend.textColor = UIColor.lightGray
            friendView.backgroundColor = UIColor.white
            
            all.textColor = UIColor.lightGray
            allView.backgroundColor = UIColor.white
            
            contentView.addSubview(requestsTab.view)
            requestsTab.didMove(toParent: self)
            
            friendsTab.willMove(toParent: nil)
            friendsTab.removeFromParent()
            friendsTab .view.removeFromSuperview()
            
            allTab.willMove(toParent: nil)
            allTab.removeFromParent()
            allTab.view.removeFromSuperview()
            
            isFriendTab = false
            isAllTab = false
            isRequestTab = true
        }
    }
}

extension FriendsController: UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if searchText.text == "" {
            searchResultTable.isHidden = true
            contentView.isHidden = false
            separator.isHidden = false
            header.isHidden = false
        }
        
        searchText.resignFirstResponder()
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        searchResultTable.isHidden = false
        contentView.isHidden = true
        separator.isHidden = true
        header.isHidden = true
        
        let search = searchText.text! + string
        
        // Add matching text to array
        if isFriendTab == true {
            searchArrRes = self.originalFriendsArr.filter({($0.userName.localizedCaseInsensitiveContains(search))})
        } else if isAllTab == true {
            searchArrRes = self.originalAllArr.filter({($0.userName.localizedCaseInsensitiveContains(search))})
        } else if isRequestTab == true {
            searchArrRes = self.originalRequestsArr.filter({($0.userName.localizedCaseInsensitiveContains(search))})
        }
        
        print("Search Array \(searchArrRes)")
        if searchArrRes.count == 0 {
            searching = false
        } else {
            searching = true
        }
        
        self.searchResultTable.reloadData()
        
        return true
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchArrRes.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 30))
        view.backgroundColor = UIColor.white
        var header: String = ""
        let label = UILabel(frame: CGRect(x: view.frame.minX + 15, y: 0, width: tableView.frame.size.width, height: 17))
        label.textColor = UIColor.headerText
        label.font = UIFont(name: "Lato-Bold", size: 16)
        if isFriendTab {
            header = "Bạn bè".localized()
            label.text = header.uppercased()
        } else if isAllTab == true {
            header = "Tất cả".localized()
            label.text = header.uppercased()
        } else if isRequestTab == true {
            header = "Yêu cầu".localized()
            label.text = header.uppercased()
        }
        view.addSubview(label)
        return view
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FriendsTableViewCellID", for: indexPath) as! FriendsTableViewCell
        cell.img.image = UIImage(named: "default")
        cell.name.text = searchArrRes[indexPath.row].userName
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }

    
    
}
