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
    let serverApiUser = ServerApiUser()
    let pushDataMesenger = PushDataMesenger()
    var arrayImage: [String] = []
    var arrayName: [String] = []
    var arrayKeyReceiver: [String] = []
    var arrayDictionaryData: [[String: Any]] = [[:]]
    var dataChatss: [DataChats] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "MesengerTableViewCell", bundle: nil), forCellReuseIdentifier: "MesengerTableViewCellID")
        
        requestApiUser()
        requestApiMesenger()
        
    }
    
    @objc func tapImageIcon() {
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        
    }
    
    // MARK: REQUEST API MESSENGER
    func requestApiMesenger() {
        servereMesenger.requestMesenger(completionHandle: {(arrayKeyReceiver, arrayDataChat) in
            
            print(arrayDataChat)
            self.arrayKeyReceiver = arrayKeyReceiver
            print(arrayKeyReceiver)
            print(arrayDataChat)
            
            
            let ref: DatabaseReference?
            ref = Database.database().reference()
            self.tableView.reloadData()
            
            
        })
    }
    
    // MARK: PUSH DATA FAKE:
    func pushDataOnFirebase() {
        pushDataMesenger.pushDataChat(completion: { () in
            
        })
    }
    
    
    // MARK: REQUEST API USER:
    func requestApiUser() {
        serverApiUser.requestApiUser(completionHandle: { (dataResuld) in
            
        })
    }
    
}


extension MesengerController: UITableViewDelegate {
    
}

extension MesengerController: UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataChatss.count
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
        cell.lbName.text = dataChatss[indexPath.row].idReceiver
        cell.lbHours.text = dataChatss[indexPath.row].messenger
        cell.lbMesenger.text = dataChatss[indexPath.row].idSender
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
}
