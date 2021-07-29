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
    
    @IBOutlet weak var headerView: MesengerHeader!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "MesengerTableViewCell", bundle: nil), forCellReuseIdentifier: "MesengerTableViewCellID")
       
        // headerView?.imgIconChat.image = UIImage(named: "aa")
        requestApiMesengerAndUser()
        
        tableView.layer.cornerRadius = CGFloat(30)
        //view.addSubview(headerView)
    }
    
    @objc func tapImageIcon() {
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        
    }
    
    // MARK: REQUEST API MESSENGER
    func requestApiMesengerAndUser() {
        serverApiUser.requestApiUser(completionHandle: { (dataResuld) in
            
            self.servereMesenger.requestMesenger(completionHandle: {(arrayMessengerLast, arrayUser) in
                self.arrayUser = arrayUser
                self.arrayMessengerLast = arrayMessengerLast
                
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
    
    // MARK: CUSTOM HEADER MESSENGER
//    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        let viewHeader = UIView()
//        return viewHeader
//
//    }
    
//    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//        return 180
//    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MesengerTableViewCellID", for: indexPath) as! MesengerTableViewCell
        cell.lbName.text = arrayUser[indexPath.row].userName
        cell.lbHours.text = arrayUser[indexPath.row].userId
        cell.lbMesenger.text = arrayMessengerLast[indexPath.row]
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
}
