//
//  RequestViewController.swift
//  Awesomechat
//
//  Created by Apple on 2021/8/5.
//

import UIKit
import Firebase

class RequestViewController: UIViewController {

    @IBOutlet weak var requestTable: UITableView!
    let label: UILabel = {
        let lbl = UILabel()
        lbl.text = "Không có dữ liệu"
        lbl.textColor = UIColor.headerText
        lbl.font = UIFont(name: "Lato-Bold", size: 17)
        return lbl
    }()
    
    var sendGroup: [DataFriend] = []
    var requestGroup: [DataFriend] = []
    var group: [[DataFriend]] = []
    
    
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
    }
    
    // Custom table
    private func configureTable() {
        requestTable.register(UINib(nibName: "RequestTableViewCell", bundle: nil), forCellReuseIdentifier: "RequestTableViewCellID")
        
        requestTable.delegate = self
        requestTable.dataSource = self
        
        requestTable.rowHeight = 75
        requestTable.backgroundColor = UIColor.white
    }
    
    // Lấy dữ liệu
    private func initData() {
     
        ServerApiUser.shared.requestApiUser { _ in
            FriendAPI().getMyFriends { friends in
                self.requestGroup.removeAll()
                self.sendGroup.removeAll()
                self.group.removeAll()
                for friend in friends {
                    if friend.type == FriendType.friendRequest {
                        self.requestGroup.append(friend)
                    } else if friend.type == FriendType.sendRequest {
                        self.sendGroup.append(friend)
                    }
                }
                self.group.append(self.requestGroup)
                self.group.append(self.sendGroup)
                if self.requestGroup.isEmpty && self.sendGroup.isEmpty {
                    self.requestTable.isHidden = true
                    self.label.isHidden = false
                } else {
                    self.label.isHidden = true
                    self.requestTable.isHidden = false
                }
                self.requestTable.reloadData()
            }
        }
    }
}

extension RequestViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return group.count
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 30))
        view.backgroundColor = UIColor.white
        var header: String = ""
        let label = UILabel(frame: CGRect(x: view.frame.minX + 15, y: 0, width: tableView.frame.size.width, height: 17))
        label.textColor = UIColor.headerText
        label.font = UIFont(name: "Lato-Bold", size: 16)
        if section == 0 {
            header = "lời mời kết bạn"
            label.text = header.uppercased()
        } else {
            header = "đã gửi kết bạn"
            label.text = header.uppercased()
        }
        view.addSubview(label)
        return view
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return group[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RequestTableViewCellID") as! RequestTableViewCell
        cell.friendType = group[indexPath.section][indexPath.row]
        cell.btn.addTarget(self, action: #selector(deleteRow), for: .touchUpInside)
        return cell
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        var swipeConfiguration = UISwipeActionsConfiguration()
        let person = group[indexPath.section][indexPath.row]
        print("Position of tableview at section and row \(self.group[indexPath.section][indexPath.row])")
        if indexPath.section == 0 {
            let deleteAction = UIContextualAction(style: .destructive, title: "Từ chối") { (action, sourceView, completionHandler) in
                FriendAPI.shared.unfriend(withID: person.friendId)
                self.group[indexPath.section].remove(at: indexPath.row)
                self.requestTable.deleteRows(at: [indexPath], with: .fade)
                completionHandler(true)
            }
            swipeConfiguration = UISwipeActionsConfiguration(actions: [deleteAction])
        }
        return swipeConfiguration
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let firstView: UIView = {
            let firstBackground = UIView()
            firstBackground.frame = CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 20)
            firstBackground.backgroundColor = UIColor.white
            return firstBackground
        }()
        let secondView: UIView = {
            let secondBackground = UIView()
            secondBackground.frame = CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 0)
            secondBackground.backgroundColor = UIColor.white
            return secondBackground
        }()
        let separator: UIView = {
            let line = UIView()
            line.frame = CGRect(x: firstView.frame.minX, y: firstView.frame.minY, width: tableView.frame.size.width, height: 5)
            line.backgroundColor = UIColor.myGray
            return line
        }()
        firstView.addSubview(separator)
        if requestGroup.isEmpty {
            return secondView
        }
        return section == 0 ? firstView : secondView
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 && requestGroup.isEmpty {
            return 0
        } else if section == 1 && sendGroup.isEmpty {
            return 0
        }
        return 30
    }
    
    @objc func deleteRow(_ sender: UIButton) {
        let point = sender.convert(CGPoint.zero, to: requestTable)
        guard let indexPath = requestTable.indexPathForRow(at: point) else {
            return
        }
        let friend = group[indexPath.section][indexPath.row]
        if indexPath.section == 0 {
            FriendAPI.shared.acceptFriendRequest(withID: friend.friendId)
        } else {
            FriendAPI.shared.unfriend(withID: friend.friendId)
        }
        group[indexPath.section].remove(at: indexPath.row)
        requestTable.beginUpdates()
        requestTable.deleteRows(at: [IndexPath(row: indexPath.row, section: indexPath.section)], with: .fade)
        requestTable.endUpdates()
    }
}
