//
//  MesengerController.swift
//  Awesomechat
//
//  Created by LongDN on 02/07/2021.
//

import UIKit
import Firebase

class MesengerController: UIViewController {
    
    @IBOutlet weak var lbTinNhan: UILabel!
    @IBOutlet weak var imgIconMessenger: UIImageView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    let servereMesenger = ServerMesenger()
    
    let serverApiUser = ServerApiUser()
    var arrayDictionaryData: [[String: Any]] = [[:]]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UINib(nibName: "MesengerTableViewCell", bundle: nil), forCellReuseIdentifier: "MesengerTableViewCellID")
        customGradients()
        requestApiMesenger()
        let tapImage = UITapGestureRecognizer(target: self, action: #selector(tapImageIcon))
        imgIconMessenger.isUserInteractionEnabled = true
        imgIconMessenger.addGestureRecognizer(tapImage)
    }
    
    @objc func tapImageIcon() {
        serverApiUser.requestDataFirebase(completion: { (data) in
            //print(data)
        })
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
    }
    
    // MARK: CUSTOM GRADIEN
    func customGradients() {
        let colorTop =  UIColor(rgb: 0xff4356B4).cgColor
        let colorBottom = UIColor(rgb: 0xff3DCFCF).cgColor
                    
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [colorTop, colorBottom]
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.frame = CGRect(x: 0.0, y: 0.0, width: self.view.frame.size.width, height: self.view.frame.size.height / 4)
                
        self.view.layer.addSublayer(gradientLayer)
        view.addSubview(lbTinNhan)
        view.addSubview(imgIconMessenger)
        view.addSubview(searchBar)
        view.addSubview(tableView)
        
    }
    
    // MARK: REQUEST API MESSENGER
    func requestApiMesenger() {
        servereMesenger.requestMesenger(completionHandle: { (arrayDictionary) in
            print(arrayDictionary)
            self.arrayDictionaryData = arrayDictionary
            
            // Call Data return in callBack.
            for i in 0..<self.arrayDictionaryData.count {
//                print(self.arrayDictionaryData.count)
//                print(self.arrayDictionaryData[i])
//                print(self.arrayDictionaryData[i].keys)
                
                // lấy ra các key của từng phần tử trong mảng:
                for dataItems in self.arrayDictionaryData[i].keys {
                    
                    // lấy ra từng giá trị thông qua cái key của mảng:
                    guard let dataDetail = self.arrayDictionaryData[i][dataItems] as? [String: Any] else {
                        return
                    }
                    print(dataItems)
                    
                    // lây ra từng giá trị trong một mảng thông qua cái DictionAry nhỏ ben trong của nó:
                    print(dataDetail["time"] ?? "time")
                    
                }
            }
            
        })
        
        
    }
}


extension MesengerController: UITableViewDelegate {
    
}

extension MesengerController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MesengerTableViewCellID", for: indexPath) as! MesengerTableViewCell
        
        cell.roundCorners(corners: [.topLeft, .topRight], radius: 20)
        cell.imgAvatar.image = UIImage(named: "random1")
        cell.lbName.text = "aaaaaa"
        cell.lbHours.text = "11:33"
        cell.lbMesenger.text = "Anh đứng đây từ chiều"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    
    
    
}
