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
    @IBOutlet weak var viewHeader: MessengerHeader!
    
    let servereMesenger = ServerMesenger()
    let serverApiUser = ServerApiUser.shared
    
    let pushDataMesenger = PushDataMesenger()
    var arrayChatRoom: [ChatRoom] = []
    var checkIsRead: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "MessengerTableViewCell", bundle: nil), forCellReuseIdentifier: "MessengerTableViewCellID")
        tableView.layer.cornerRadius = CGFloat(30)
        requestApiMesengerUser()
        
    }
    
    @objc func tapImageIcon() {
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        //tableView.reloadData()
        
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
                self.tableView.reloadData()
            })
        })
        
    }
    
}


extension MessengerController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // Push lại giá trị isRead khi người dùng đọc tin nhắn:
        
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
        
        print(arrayChatRoom[indexPath.row].chatMessages[0].messageId)
        
        let messengerDetail = MessengerDetail()
        messengerDetail.dataChatRoom = arrayChatRoom[indexPath.row]
        
        messengerDetail.modalPresentationStyle = UIModalPresentationStyle.fullScreen
        messengerDetail.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        self.present(messengerDetail, animated: true, completion: nil)
        
    }
}

extension MessengerController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayChatRoom.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let stringImg = URL(string: arrayChatRoom[indexPath.row].participant?.userImgUrl ?? "defauld.png")
        let cell = tableView.dequeueReusableCell(withIdentifier: "MessengerTableViewCellID", for: indexPath) as! MessengerTableViewCell
        
//        // đếm số tin nhắn chưa đọc và hiển thị ra của từng cell một bang cách check đến từng isRead.
//        for i in 0..<arrayChatRoom[indexPath.row].chatMessages.count {
//            if (arrayChatRoom[indexPath.row].chatMessages[i].isRead == "false") {
//                checkIsRead += 1
//
//            } else {
//                checkIsRead = 0
//            }
//            print(checkIsRead)
//        }

        cell.lbName.text = arrayChatRoom[indexPath.row].participant?.userName
        cell.lbMesenger.text = arrayChatRoom[indexPath.row].chatMessages.last?.messenger
        cell.lbHours.text = arrayChatRoom[indexPath.row].chatMessages.last?.time
        
        print(arrayChatRoom[indexPath.row].participant?.userName)
        
        do {
            let dataImg = try Data(contentsOf: stringImg ?? URL(string: "defauld.png")!)
               cell.imgAvatar.image = UIImage(data: dataImg)
           } catch {
               cell.imgAvatar.image = UIImage(named: "default")
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
