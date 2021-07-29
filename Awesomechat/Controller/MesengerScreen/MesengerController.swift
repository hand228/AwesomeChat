//
//  MesengerController.swift
//  Awesomechat
//
//  Created by LongDN on 02/07/2021.
//

import UIKit
import Firebase

class MesengerController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    let servereMesenger = ServerMesenger()
    let serverApiUser = ServerApiUser.shared
    //let pushDataMesenger = PushDataMesenger()
    var arrayUser: [DataUser] = []
    var arrayMessengerLast: [String] = []
    var arrayChatMessenger: [[ChatMessage]] = []
    
    @IBOutlet weak var headerView: MesengerHeader!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "MesengerTableViewCell", bundle: nil), forCellReuseIdentifier: "MesengerTableViewCellID")
        requestApiMesengerAndUser()
        tableView.layer.cornerRadius = CGFloat(30)
    }
    
    @objc func tapImageIcon() {
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        
    }
    
    // MARK: REQUEST API MESSENGER
    func requestApiMesengerAndUser() {
        serverApiUser.requestApiUser(completionHandle: { (dataResuld) in
            self.servereMesenger.requestMesenger(completionHandle: {(arrayMessengerLast, arrayUser, arrayChatMessenger)  in
                self.arrayUser = arrayUser
                self.arrayMessengerLast = arrayMessengerLast
                self.arrayChatMessenger = arrayChatMessenger
                self.tableView.reloadData()
            })
            
             self.tableView.reloadData()
        })
         
    }
    
    // MARK: PUSH DATA FAKE:
    func pushDataOnFirebase() {
//        pushDataMesenger.pushDataChat(completion: { () in
//
//        })
    }
    
}


extension MesengerController: UITableViewDelegate {
    
}

extension MesengerController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayUser.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let stringImg = URL(string: arrayUser[indexPath.row].userImgUrl)
        let cell = tableView.dequeueReusableCell(withIdentifier: "MesengerTableViewCellID", for: indexPath) as! MesengerTableViewCell
        cell.lbName.text = arrayUser[indexPath.row].userName
        cell.lbHours.text = arrayChatMessenger[indexPath.row].last?.date
        cell.lbMesenger.text = arrayMessengerLast[indexPath.row]
        do {
            let dataImg = try Data(contentsOf: stringImg!)
            cell.imgAvatar.image = UIImage(data: dataImg)
        } catch {
            cell.imgAvatar.image = UIImage(named: "defauld")
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
