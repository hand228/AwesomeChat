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
    
    var arrayImage: [String] = []
    var arrayName: [String] = []
    
    
    var arrayKeyReceiver: [String] = []
    var arrayDictionaryData: [[String: Any]] = [[:]]
    
    var dataChatss: [[DataChats]] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "MesengerTableViewCell", bundle: nil), forCellReuseIdentifier: "MesengerTableViewCellID")
        
        requestApiMesenger()
        //requestApiUser()
        //pushDataOnFirebase
        
        
        
    }
    
    @objc func tapImageIcon() {
        serverApiUser.requestDataFirebase(completion: { (data) in
            
        })
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
    }

    
    
    // MARK: REQUEST API MESSENGER
    func requestApiMesenger() {
        servereMesenger.requestMesenger(completionHandle: { (arrayDictionary, arrayKeyReceiver, arrayDataChat) in
            print(arrayDictionary)
            print(arrayDataChat)
            
            self.dataChatss = arrayDataChat
            self.arrayDictionaryData = arrayDictionary
            self.arrayKeyReceiver = arrayKeyReceiver
            print(arrayKeyReceiver)
            print(arrayDataChat)
            
            
            // MARK: C1: Khi lấy đc Id rồi request tiếp
            let ref: DatabaseReference?
            ref = Database.database().reference()
            
//            ref?.child("users").child(arrayDataChat[0].idReceive ?? "").getData(completion: { (error, dataSnap) in
//                guard error == nil else {
//                    return
//                }
//                let dataUser = DataUser(snapShot: dataSnap)
//                print(dataUser.userName)
            
            
//            })
            
            
            
            self.tableView.reloadData()
            
            // MARK: C2: Lấy data bằng cách request đến từng phần tử:
            
//            // Call Data return in callBack.
//            for i in 0..<self.arrayDictionaryData.count {
//                // lấy ra các key của từng phần tử trong mảng:
//                for dataItems in self.arrayDictionaryData[i].keys {
//                    // lấy ra từng giá trị thông qua cái key của mảng:
//                    guard let dataDetail = self.arrayDictionaryData[i][dataItems] as? [String: Any] else {
//                        return
//                    }
//                    print(dataItems)
//                    // lây ra từng giá trị trong một mảng thông qua cái DictionAry nhỏ ben trong của nó:
//                    print(dataDetail["time"] ?? "time")
//                    self.arrayImage.append(dataDetail["userImgUrl"] as? String ?? "defauld" )
//                    self.arrayName.append(dataDetail["userName"] as? String ?? "NO Name")
//                }
//                print(self.arrayName)
//            }
            
        })
        
        
    }
    
    func pushDataOnFirebase(){
        servereMesenger.pushDataChat(completion: { () in
            
        })
    }
    
    
    
    func requestApiUser() {
        serverApiUser.requestApiUser(completionHandle: { [weak self] (dataResuld) in
            
        })
    }
    
}


extension MesengerController: UITableViewDelegate {
    
}

extension MesengerController: UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         //print(arrayKeyUser.count)
        //print(dataChatss.count)
        return dataChatss.count
    }
    
    // MARK: CUSTOM HEADER MESSENGER
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let viewHeader = MesengerHeader()
        //viewHeader.lbTest.text = "test"
        
        return viewHeader
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 180
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MesengerTableViewCellID", for: indexPath) as! MesengerTableViewCell
        
        // cell.roundCorners(corners: [.topLeft, .topRight], radius: 20)
        
//        cell.imgAvatar.image = UIImage(named: arrayImage[indexPath.row])
        //cell.lbName.text = "arrayName[indexPath.row]"
        
        cell.lbName.text = dataChatss[indexPath.row][indexPath.row].idReceive
        cell.lbHours.text = dataChatss[1][indexPath.row].messenger
        cell.lbMesenger.text = dataChatss[2][indexPath.row].idSender
        
        
        
        //cell.textLabel?.text = "Anh đứng đây từ chiều"
        
        return cell
        
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    
    
    
}
