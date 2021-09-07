//
//  MessengerController.swift
//  Awesomechat
//
//  Created by admin on 7/30/21.
//

import UIKit
import FirebaseAuth
import Firebase

class MessengerController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var viewHeader: UIView!
    @IBOutlet weak var lbTitle: UILabel!
    @IBOutlet weak var imgIconChat: UIImageView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    
    let servereMesenger = ServerMesenger()
    let serverApiUser = ServerApiUser.shared
    let pushDataMesenger = PushDataMesenger()
    var arrayChatRoom: [ChatRoom] = []
    
    var arrayChatRoomSearch: [ChatRoom] = []
    var checkIsRead: [Int] = []
    var counter = 0
    var indexSetValue: Int?
    var searching = false
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "MessengerTableViewCell", bundle: nil), forCellReuseIdentifier: "MessengerTableViewCellID")
        tableView.layer.cornerRadius = CGFloat(30)
        tableView.separatorStyle = .none
        requestApiMesengerUser()
        customGradients()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        //tableView.reloadData()
        
        
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
       // tableView.reloadData()
    }
    
    func setValueCounter(setCounter: Int) {
        self.counter = setCounter
    }
    
    // MARK: REQUEST API MESSENGER
    func requestApiMesengerUser() {
        serverApiUser.requestApiUser(completionHandle: { (dataResuld) in
            self.servereMesenger.requestMesenger(completionHandle: {(arrayChatRooms)  in
                var arrayChatRoomValue: [ChatRoom] = []
                for i in 0..<arrayChatRooms.count {
                    // Check ID tương ứng với UID đã nhắn tin với người nào:
                    if(
                        (Auth.auth().currentUser?.uid ?? "") + arrayChatRooms[i].chatMessages[0].idSender == arrayChatRooms[i].roomId || arrayChatRooms[i].chatMessages[0].idSender + (Auth.auth().currentUser?.uid ?? "") == arrayChatRooms[i].roomId ||
                        (Auth.auth().currentUser?.uid ?? "") + arrayChatRooms[i].chatMessages[0].idReceiver == arrayChatRooms[i].roomId ||
                        arrayChatRooms[i].chatMessages[0].idReceiver + (Auth.auth().currentUser?.uid ?? "") == arrayChatRooms[i].roomId
                        ) {
                        
                        arrayChatRoomValue.append(arrayChatRooms[i])
                    }
                }
                
                self.arrayChatRoom = arrayChatRoomValue
                self.CoutingMessengerIsRead()
                self.tableView.reloadData()
            })
        })
        
    }
    
    
    func CoutingMessengerIsRead() {
        // trong hàm này sẽ đếm các tin nhắn chưa đọc. Và đếm tin nhắn của người nhận chứ ko phải là tin nhắn từ mk:
        // cần phải check xem id từ người nhận mà có tin nhắn cuối cùng thì mới hiên thị ra:
        for i in 0..<arrayChatRoom.count {
            if (arrayChatRoom[i].chatMessages.last?.idSender != Auth.auth().currentUser?.uid) {
                for j in 0..<arrayChatRoom[i].chatMessages.count {
                    if(arrayChatRoom[i].chatMessages[j].isRead == "true") {
                        counter = 0
                    } else if (arrayChatRoom[i].chatMessages[j].isRead == "false") {
                        counter += 1
                    }
                }
            }
            checkIsRead.append(counter)
            counter = 0
        }
    }
    
    func customGradients() {
        let colorTop =  UIColor(rgb: 0xff4356B4).cgColor
        let colorBottom = UIColor(rgb: 0xff3DCFCF).cgColor
                    
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [colorTop, colorBottom]
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.frame = CGRect(x: 0.0, y: 0.0, width: self.viewHeader.frame.size.width, height: self.viewHeader.frame.size.height )
                
        self.viewHeader.layer.addSublayer(gradientLayer)
        self.viewHeader.addSubview(lbTitle)
        self.viewHeader.addSubview(imgIconChat)
        self.viewHeader.addSubview(searchBar)
        //contenView.addSubview(tableView)
        
        imgIconChat.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tapGesture)))
        imgIconChat.isUserInteractionEnabled = true
        
        // CustomSearchBar:
        searchBar.layer.cornerRadius = CGFloat(20)
        searchBar.clipsToBounds = true
        searchBar.setImage(UIImage(named: "Group (2)"), for: .search, state: .normal)
        
    }
    
    @objc func tapGesture() {
        print("mmmmmmmmmmmmmmmm")
    }
}


extension MessengerController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let messengerDetail = MessengerDetail()
        // Push lại giá trị isRead khi người dùng đọc tin nhắn:
        indexSetValue = indexPath.row
        
        if searching {
            if (arrayChatRoomSearch[indexPath.row].chatMessages.last?.idSender != Auth.auth().currentUser?.uid) {
                   let valuePost: [String: Any] = [
                       "date": arrayChatRoomSearch[indexPath.row].chatMessages.last!.date,
                       "idReceiver":arrayChatRoomSearch[indexPath.row].chatMessages.last!.idReceiver,
                       "idSender": arrayChatRoomSearch[indexPath.row].chatMessages.last!.idSender,
                       "isRead": "true",
                       "messenger": arrayChatRoomSearch[indexPath.row].chatMessages.last!.messenger,
                       "time": arrayChatRoomSearch[indexPath.row].chatMessages.last!.time,
                       "timeLong": arrayChatRoomSearch[indexPath.row].chatMessages.last!.timeLong,
                       "type": arrayChatRoomSearch[indexPath.row].chatMessages.last!.type
                   ]
                   let ref: DatabaseReference?
                   ref = Database.database().reference()
               ref?.child("chats/\(arrayChatRoomSearch[indexPath.row].roomId)/\(arrayChatRoomSearch[indexPath.row].chatMessages.last!.messageId)").setValue(valuePost, andPriority: .none)
            }
            messengerDetail.dataChatRoom = arrayChatRoomSearch[indexPath.row]
        } else {
            if (arrayChatRoom[indexPath.row].chatMessages.last?.idSender != Auth.auth().currentUser?.uid) {
                   let valuePost: [String: Any] = [
                       "date": arrayChatRoom[indexPath.row].chatMessages.last!.date,
                       "idReceiver":arrayChatRoom[indexPath.row].chatMessages.last!.idReceiver,
                       "idSender": arrayChatRoom[indexPath.row].chatMessages.last!.idSender,
                       "isRead": "true",
                       "messenger": arrayChatRoom[indexPath.row].chatMessages.last!.messenger,
                       "time": arrayChatRoom[indexPath.row].chatMessages.last!.time,
                       "timeLong": arrayChatRoom[indexPath.row].chatMessages.last!.timeLong,
                       "type": arrayChatRoom[indexPath.row].chatMessages.last!.type
                   ]
                   let ref: DatabaseReference?
                   ref = Database.database().reference()
               ref?.child("chats/\(arrayChatRoom[indexPath.row].roomId)/\(arrayChatRoom[indexPath.row].chatMessages.last!.messageId)").setValue(valuePost, andPriority: .none)
            }
            messengerDetail.dataChatRoom = arrayChatRoom[indexPath.row]
        }
        
        
        print(arrayChatRoom[indexPath.row].chatMessages[0].messageId)
        
        messengerDetail.modalPresentationStyle = UIModalPresentationStyle.fullScreen
        messengerDetail.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        self.present(messengerDetail, animated: true, completion: nil)
        tableView.reloadData()
    }
}

extension MessengerController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if searching {
            return arrayChatRoomSearch.count
        } else {
            return arrayChatRoom.count
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let stringImg = URL(string: arrayChatRoom[indexPath.row].participant?.userImgUrl ?? "defauld.png")
        let cell = tableView.dequeueReusableCell(withIdentifier: "MessengerTableViewCellID", for: indexPath) as! MessengerTableViewCell

        if searching {
            
            if (checkIsRead[indexPath.row] != 0) {
                cell.lbName.text = arrayChatRoomSearch[indexPath.row].participant?.userName
                cell.lbMesenger.text = "\(arrayChatRoomSearch[indexPath.row].chatMessages.count) tin nhắn phù hợp"
                cell.lbMesenger.textColor = UIColor.black
                cell.lbHours.text = arrayChatRoomSearch[indexPath.row].chatMessages.last?.time
                cell.lbHours.textColor = UIColor.black
                cell.customImgIsRead(numberIsRead: checkIsRead[indexPath.row])

                
            } else {
                
                cell.lbName.text = arrayChatRoomSearch[indexPath.row].participant?.userName
                cell.lbMesenger.text = "\(arrayChatRoomSearch[indexPath.row].chatMessages.count) tin nhắn phù hợp"
                cell.lbMesenger.textColor = UIColor(rgb: 0xff999999)
                
                cell.lbHours.text = arrayChatRoomSearch[indexPath.row].chatMessages.last?.time
                cell.lbHours.textColor = UIColor(rgb: 0xff999999)
                //cell.customImgNoIsRead()
            }
            
            do {
                let dataImg = try Data(contentsOf: stringImg ?? URL(string: "defauld.png")!)
                   cell.imgAvatar.image = UIImage(data: dataImg)
               } catch {
                   cell.imgAvatar.image = UIImage(named: "default")
               }
        } else {
            
            if (checkIsRead[indexPath.row] != 0) {
                cell.lbName.text = arrayChatRoom[indexPath.row].participant?.userName
                cell.lbMesenger.text = arrayChatRoom[indexPath.row].chatMessages.last?.messenger
                cell.lbMesenger.textColor = UIColor.black
                cell.lbHours.text = arrayChatRoom[indexPath.row].chatMessages.last?.time
                cell.lbHours.textColor = UIColor.black
                cell.customImgIsRead(numberIsRead: checkIsRead[indexPath.row])

                
            } else {
                
                cell.lbName.text = arrayChatRoom[indexPath.row].participant?.userName
                cell.lbMesenger.text = arrayChatRoom[indexPath.row].chatMessages.last?.messenger
                cell.lbMesenger.textColor = UIColor(rgb: 0xff999999)
                
                cell.lbHours.text = arrayChatRoom[indexPath.row].chatMessages.last?.time
                cell.lbHours.textColor = UIColor(rgb: 0xff999999)
                //cell.customImgNoIsRead()
            }
            
            do {
                let dataImg = try Data(contentsOf: stringImg ?? URL(string: "defauld.png")!)
                   cell.imgAvatar.image = UIImage(data: dataImg)
               } catch {
                   cell.imgAvatar.image = UIImage(named: "default")
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
         if (indexPath.section == 0 && indexPath.row == 0) {
              return 104
         }
         return 92
    }

}

extension MessengerController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        let textSearch = searchBar.text! + searchText
        arrayChatRoomSearch = arrayChatRoom.compactMap({ chatRoom in
            let matchedMessenger = chatRoom.chatMessages.filter({ message in
                
               // message.messenger.contains(textSearch)
                message.messenger.localizedCaseInsensitiveContains(textSearch)
            })
            print(matchedMessenger.count)
            if (matchedMessenger.count <= 0) {
                return nil
            }
            let newRoom = chatRoom
            newRoom.chatMessages = matchedMessenger
            return newRoom
        })
        
        searching = true
        
        if arrayChatRoomSearch.isEmpty {
            // Custom view, hiển thị thông báo không có kết quả phù hợp:

        } else {
             
        }
        tableView.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searching = false
        searchBar.text = ""
        tableView.reloadData()
    }
    
    
}
