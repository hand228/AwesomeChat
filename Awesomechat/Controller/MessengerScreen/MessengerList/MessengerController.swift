//
//  MessengerController.swift
//  Awesomechat
//
//  Created by admin on 7/30/21.
//

import UIKit

class MessengerController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var viewHeader: MessengerHeader!
    
    let servereMesenger = ServerMesenger()
    let serverApiUser = ServerApiUser.shared
    
    let pushDataMesenger = PushDataMesenger()
    var arrayChatRoom: [ChatRoom] = []
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
        
    }
    
    // MARK: REQUEST API MESSENGER
    func requestApiMesengerUser() {
        serverApiUser.requestApiUser(completionHandle: { (dataResuld) in

            self.servereMesenger.requestMesenger(completionHandle: {(arrayChatRoom)  in
                self.arrayChatRoom = arrayChatRoom
                
                self.tableView.reloadData()
            })
            
            self.tableView.reloadData()
        })
        
    }
    
    
//    func pushDataOnFirebase() {
//        pushDataMesenger.pushDataChat(completion: { () in
//
//        }, messenger: "")
//
//    }
    
    
}


extension MessengerController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
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
        
        let stringImg = URL(string: arrayChatRoom[indexPath.row].participant?.userImgUrl ?? "")
        let cell = tableView.dequeueReusableCell(withIdentifier: "MessengerTableViewCellID", for: indexPath) as! MessengerTableViewCell
        cell.lbName.text = arrayChatRoom[indexPath.row].participant?.userName
        cell.lbMesenger.text = arrayChatRoom[indexPath.row].chatMessages.last?.messenger
        cell.lbHours.text = arrayChatRoom[indexPath.row].chatMessages.last?.time
        //cell.textLabel?.text = arrayChatRoom[indexPath.row].chatMessages.last?.idReceiver
        do {
               let dataImg = try Data(contentsOf: stringImg!)
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
