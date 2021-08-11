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
    
    // Các button
    
    @IBOutlet weak var friend: UILabel!
    @IBOutlet weak var all: UILabel!
    @IBOutlet weak var request: UILabel!
    
    // Đường gạch chân
    @IBOutlet weak var friendView: UIView!
    @IBOutlet weak var allView: UIView!
    @IBOutlet weak var requestView: UIView!
    
    // Thanh tìm kiếm
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var separator: UIView!
    
    @IBOutlet weak var requestsCounter: UILabel!
    
    let gradient = CAGradientLayer()
    let friendsTab = FriendsListViewController(nibName: "FriendsListViewController", bundle: nil)
    let allTab = AllViewController(nibName: "AllViewController", bundle: nil)
    let requestsTab = RequestViewController(nibName: "RequestViewController", bundle: nil)
    var requestGroup: [DataFriend] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        configureUI()
        initTab()
        countFriendRequest()
        
//        searchBar.setupSearchBar()
    }
    
    // MARK: - Chỉnh sửa giao diện
    private func configureUI() {
        
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
        }
    }
}
