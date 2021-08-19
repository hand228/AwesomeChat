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
    // let pushDataMesenger = PushDataMesenger()
    var arrayUser: [DataUser] = []
    var arrayMessengerLast: [String] = []
    var arrayChatMessenger: [[ChatMessage]] = []
    
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
            
            
            self.servereMesenger.requestMesenger(completionHandle: { (arrayMessengerLast, arrayUser, arrayChatMessenger)  in
                self.arrayUser = arrayUser
                self.arrayMessengerLast = arrayMessengerLast
                self.arrayChatMessenger = arrayChatMessenger

                self.tableView.reloadData()
            })


            self.tableView.reloadData()
        })
        
    }
    
    
    
    // MARK: PUSH DATA FAKE:
//    func pushDataOnFirebase() {
//        pushDataMesenger.pushDataChat(completion: { () in
//
//        })
//    }
    
    
}


extension MessengerController: UITableViewDelegate {
    
}

extension MessengerController: UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayUser.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let stringImg = URL(string: arrayUser[indexPath.row].userImgUrl)
        let cell = tableView.dequeueReusableCell(withIdentifier: "MessengerTableViewCellID", for: indexPath) as! MessengerTableViewCell
        cell.lbName.text = arrayUser[indexPath.row].userName
        cell.lbHours.text = arrayChatMessenger[indexPath.row].last?.date
        cell.lbMesenger.text = arrayMessengerLast[indexPath.row]
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
