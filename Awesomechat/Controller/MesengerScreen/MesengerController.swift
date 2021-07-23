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
    let serverApiUserMessenger = ServerApiUserMessenger.shared
    let pushDataMesenger = PushDataMesenger()
    var arrayImage: [String] = []
    var arrayName: [String] = []
    var arrayKeyReceiver: [String] = []
    var arrayDictionaryData: [[String: Any]] = [[:]]
    var dataChatss: [DataChats] = []
    var arrayUser: [DataUser] = []
    var lastMessengers: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "MesengerTableViewCell", bundle: nil), forCellReuseIdentifier: "MesengerTableViewCellID")
        requestApiUserMessenger()
        
    }
    
    @objc func tapImageIcon() {
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        
    }
    
    // MARK: PUSH DATA FAKE:
    func pushDataOnFirebase() {
        pushDataMesenger.pushDataChat(completion: { () in
            
        })
    }
    
    
    // MARK: REQUEST API USER:
    func requestApiUserMessenger() {
        
        serverApiUserMessenger.requestApiUserMessenger(completionHandle: { (lastMessenger, dataUser)  in
            self.arrayUser = dataUser
            self.lastMessengers = lastMessenger
            
            self.tableView.reloadData()
            
        })
    }
    
}


extension MesengerController: UITableViewDelegate {
    
}

extension MesengerController: UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayUser.count
    }
    
    // MARK: CUSTOM HEADER MESSENGER
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let viewHeader = MesengerHeader()
        return viewHeader
        
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 180
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MesengerTableViewCellID", for: indexPath) as! MesengerTableViewCell
        cell.lbName.text = arrayUser[indexPath.row].userEmail
        cell.lbHours.text = arrayUser[indexPath.row].userId
        cell.lbMesenger.text = lastMessengers[indexPath.row]
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
}
