//
//  FriendsListViewController.swift
//  Awesomechat
//
//  Created by MaiNQ on 21/07/2021.
//

import UIKit
import FirebaseAuth
import Firebase

class FriendsListViewController: UIViewController {

    @IBOutlet weak var friendsList: UITableView!
    let label: UILabel = {
        let lbl = UILabel()
        lbl.text = "Không có dữ liệu"
        lbl.textColor = UIColor.headerText
        lbl.font = UIFont(name: "Lato-Bold", size: 17)
        return lbl
    }()
    
    var friendDict: [String: [DataFriend]] = [:]
    var friendsSectionTitles: [String] = []
//    var filterFriends: [DataFriend] = []
    
    var arrayChatRoom: [String: [ChatRoom]] = [:]
    var chatRoomSection: [String] = []
    var serverApiUser = ServerApiUser.shared
    var servereMesenger = ServerMesenger()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Thêm và ràng buộc label text khi dữ liệu rỗng
        view.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 140).isActive = true
        label.topAnchor.constraint(equalTo: view.topAnchor, constant: 200).isActive = true
        label.widthAnchor.constraint(equalToConstant: 200).isActive = true
        label.heightAnchor.constraint(equalToConstant: 50).isActive = true
    
        // Hiển thị dữ liệu
        configureTable()
        initData()
        requestApiMesengerUser()
    }
    
    private func configureTable() {
        friendsList.register(UINib(nibName: "FriendsTableViewCell", bundle: nil), forCellReuseIdentifier: "FriendsTableViewCellID")
        
        friendsList.delegate = self
        friendsList.dataSource = self
    }
   
    private func initData() {
      
        ServerApiUser.shared.requestApiUser { _ in
            FriendAPI().getMyFriends { friends in
                self.friendDict.removeAll()
                self.friendsSectionTitles.removeAll()
                for friend in friends {
                    if friend.type == FriendType.friend {
                        var components = friend.info?.userName.components(separatedBy: " ")
                        let firstName = components!.removeLast()
                        let friendKey = String(firstName.prefix(1))
                        if var friendValues = self.friendDict[friendKey] {
                            friendValues.append(friend)
                            self.friendDict[friendKey] = friendValues
                        } else {
                            self.friendDict[friendKey] = [friend]
                        }
                    }
                }
                if self.friendDict.isEmpty {
                    self.label.isHidden = false
                    self.friendsList.isHidden = true
                } else {
                    self.label.isHidden = true
                    self.friendsList.isHidden = false
                }
                self.friendsSectionTitles = [String](self.friendDict.keys)
//                self.friendsSectionTitles = self.friendsSectionTitles.sorted(by: { $0 < $1 })
                self.friendsSectionTitles = self.friendsSectionTitles.sorted(by: {
                    $0.compare($1, locale: NSLocale(localeIdentifier: "vi_VN") as Locale) == .orderedAscending
                })
                self.friendsList.reloadData()
            }
        }
    }
}

extension FriendsListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return friendsSectionTitles.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //print(section)
        let friendKey = friendsSectionTitles[section]
        if let friendValues = friendDict[friendKey] {
            return friendValues.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FriendsTableViewCellID", for: indexPath) as! FriendsTableViewCell
        cell.img.image = UIImage(named: "default")
        let friendKey = friendsSectionTitles[indexPath.section]
        if let friendValues = friendDict[friendKey] {
            cell.name.text = friendValues[indexPath.row].info?.userName
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 30))
        view.backgroundColor = UIColor.myGray
        let label = UILabel(frame: CGRect(x: view.frame.minX + 15, y: 0, width: tableView.frame.size.width, height: 30))
        label.text = friendsSectionTitles[section].uppercased()
        label.textColor = UIColor.black
        view.addSubview(label)
        return view
    }
    
    // Lấy id và truyền về màn detailMessenger:
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let friendKey = friendsSectionTitles[indexPath.section]
        guard let friendValues = friendDict[friendKey] else {
            return
        }
        
        
        let messengerDetail = MessengerDetail()
        messengerDetail.userToFriend = friendValues[indexPath.row].info
        messengerDetail.roomIdToFriend = friendValues[indexPath.row].friendId
        
        let chatRoomKey = chatRoomSection[indexPath.section]
        guard let chatRoomValue = arrayChatRoom[chatRoomKey] else {
            return
        }
        messengerDetail.dataChatRoom = chatRoomValue[indexPath.row]
        
//        print(friendValues[indexPath.row].friendId)
//        print(friendValues[indexPath.row].info)
//        print(indexPath.section)
//        print(indexPath.row)
        
        messengerDetail.roomId = Auth.auth().currentUser!.uid + friendValues[indexPath.row].friendId
        
        
        messengerDetail.modalPresentationStyle = UIModalPresentationStyle.fullScreen
        messengerDetail.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        self.present(messengerDetail, animated: true, completion: nil)
        
        
    }
    
    // cần phải lấy hết data của ChatRoom khi bấm vào từng bạn bè cụ thể: làm tương tự như CellMessege
    
    // MARK: REQUEST API MESSENGER
    func requestApiMesengerUser() {
        serverApiUser.requestApiUser(completionHandle: { (dataResuld) in
            self.servereMesenger.requestMesenger(completionHandle: {(arrayChatRooms)  in
                var arrayChatRoomValue: [ChatRoom] = []
                
                for i in 0..<arrayChatRooms.count {
                    if (Auth.auth().currentUser?.uid == arrayChatRooms[i].chatMessages[0].idSender  || Auth.auth().currentUser?.uid == arrayChatRooms[i].chatMessages[0].idReceiver) {
                        arrayChatRoomValue.append(arrayChatRooms[i])
                        
                        
                    }
                }
                //self.arrayChatRoom = arrayChatRoomValue
                
                
            })
        })
        
    }
}

