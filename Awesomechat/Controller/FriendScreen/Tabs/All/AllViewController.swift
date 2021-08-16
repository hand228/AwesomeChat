//
//  AllViewController.swift
//  Awesomechat
//
//  Created by Apple on 2021/8/9.
//

import UIKit

class AllViewController: UIViewController {

    @IBOutlet weak var allTable: UITableView!
    
    let label: UILabel = {
        let lbl = UILabel()
        lbl.text = "Không có dữ liệu"
        lbl.textColor = UIColor.headerText
        lbl.font = UIFont(name: "Lato-Bold", size: 17)
        return lbl
    }()
    var allUsers: [DataUser] = []
    var allFriends: [DataFriend] = []
    var userDict: [String: [DataUser]] = [:]
    var userSectionTitles: [String] = []

    override func viewDidLoad() {
        super.viewDidLoad()
                
        allTable.register(UINib(nibName: "AllTableViewCell", bundle: nil), forCellReuseIdentifier: "AllTableViewCellID")
        allTable.delegate = self
        allTable.dataSource = self
//        allTable.scrollToBottom()

        // Thêm và ràng buộc label text khi dữ liệu rỗng
        view.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 140).isActive = true
        label.topAnchor.constraint(equalTo: view.topAnchor, constant: 200).isActive = true
        label.widthAnchor.constraint(equalToConstant: 200).isActive = true
        label.heightAnchor.constraint(equalToConstant: 50).isActive = true

        initData()


    }

    private func initData() {
        ServerApiUser.shared.requestApiUser { users in
            for user in users {
                self.allUsers = users
                var components = user.userName.components(separatedBy: " ")
                let userKey = String(components.removeLast().prefix(1))
                if var userValues = self.userDict[userKey] {
                    userValues.append(user)
                    self.userDict[userKey] = userValues
                } else {
                    self.userDict[userKey] = [user]
                }
            }
            FriendAPI().getMyFriends { friends in
                self.allFriends.removeAll()
                self.allFriends = friends
                self.allTable.reloadData()
            }

            if self.userDict.isEmpty {
                self.label.isHidden = false
                self.allTable.isHidden = true
            } else {
                self.label.isHidden = true
                self.allTable.isHidden = false
            }
            self.userSectionTitles = [String](self.userDict.keys)
            self.userSectionTitles = self.userSectionTitles.sorted(by: {
                $0.compare($1, locale: NSLocale(localeIdentifier: "vi_VN") as Locale) == .orderedAscending
            })
            self.allTable.reloadData()
        }
    }
}

extension AllViewController: UITableViewDelegate, UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return userSectionTitles.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let userKey = userSectionTitles[section]
        if let userValues = userDict[userKey] {
            return userValues.count
        }
        return 0
    }


    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AllTableViewCellID", for: indexPath) as! AllTableViewCell
        cell.img.image = UIImage(named: "default")
        let userKey = userSectionTitles[indexPath.section]
        if let userValues = userDict[userKey] {
            cell.name.text = userValues[indexPath.row].userName
            let friend = allFriends.first(where: { f in
                return f.friendId == userValues[indexPath.row].userId
            })
            if friend == nil {
                cell.btn.setTitle("Kết bạn", for: .normal)
                cell.btn.setTitleColor(UIColor.white, for: .normal)
                cell.btn.backgroundColor = UIColor.myBlue
                cell.btn.addTarget(self, action: #selector(addFriend), for: .touchUpInside)
            } else {
                if friend?.type == FriendType.friend {
                    cell.btn.isHidden = true
                } else if friend?.type == FriendType.sendRequest {
                    cell.btn.setTitle("Huỷ", for: .normal)
                    cell.btn.setTitleColor(UIColor.myBlue, for: .normal)
                    cell.btn.backgroundColor = .white
                    cell.btn.addTarget(self, action: #selector(unfriend), for: .touchUpInside)
                } else if friend?.type == FriendType.friendRequest {
                    cell.btn.setTitle("Đồng ý", for: .normal)
                    cell.btn.setTitleColor(UIColor.white, for: .normal)
                    cell.btn.backgroundColor = UIColor.myBlue
                    cell.btn.addTarget(self, action: #selector(acceptFriend), for: .touchUpInside)
                }
            }
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
        label.text = userSectionTitles[section].uppercased()
        label.textColor = UIColor.black
        view.addSubview(label)
        return view
    }

    @objc func unfriend(_ sender: UIButton) {
        let point = sender.convert(CGPoint.zero, to: allTable)
        guard let indexPath = allTable.indexPathForRow(at: point) else {
            return
        }
        print("Section: \(indexPath.section)")
        print("Row: \(indexPath.row)")
        let userKey = userSectionTitles[indexPath.section]
        let userId = userDict[userKey]![indexPath.row]
        FriendAPI().unfriend(withID: userId.userId)

        sender.setTitle("Kết bạn", for: .normal)
        sender.setTitleColor(UIColor.white, for: .normal)
        sender.backgroundColor = UIColor.myBlue
    }

    @objc func addFriend(_ sender: UIButton) {
        let point = sender.convert(CGPoint.zero, to: allTable)
        guard let indexPath = allTable.indexPathForRow(at: point) else {
            return
        }
        print("User Dictionary: \(userDict)")
        print("Section: \(indexPath.section)")
        print("Row: \(indexPath.row)")
        let userKey = userSectionTitles[indexPath.section]
        let userId = userDict[userKey]![indexPath.row]
        print("Sections of row: \(userKey)")
        print("User: \(userId)")
        FriendAPI().addFriend(withID: userId.userId)

        sender.setTitle("Huỷ", for: .normal)
        sender.setTitleColor(UIColor.myBlue, for: .normal)
        sender.backgroundColor = .white
        sender.addTarget(self, action: #selector(unfriend), for: .touchUpInside)
    }

    @objc func acceptFriend(_ sender: UIButton) {
        let point = sender.convert(CGPoint.zero, to: allTable)
        guard let indexPath = allTable.indexPathForRow(at: point) else {
            return
        }
        print("Section: \(indexPath.section)")
        print("Row: \(indexPath.row)")
        let userKey = userSectionTitles[indexPath.section]
        let userId = userDict[userKey]![indexPath.row]
        FriendAPI().acceptFriendRequest(withID: userId.userId)

        sender.isHidden = true
    }
}

