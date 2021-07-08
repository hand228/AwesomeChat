//
//  MesengerController.swift
//  Awesomechat
//
//  Created by LongDN on 02/07/2021.
//

import UIKit

class MesengerController: UIViewController {
    
    @IBOutlet weak var viewGradient: UIView!
    @IBOutlet weak var lbTinNhan: UILabel!
    @IBOutlet weak var imgIconMessenger: UIImageView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.yellow
        
//        customGradient()
//        custom()
        
        tableView.register(UINib(nibName: "MesengerTableViewCell", bundle: nil), forCellReuseIdentifier: "MesengerTableViewCellID")
    }
    
    func custom() {
        
        let view = UILabel()
        view.frame = CGRect(x: 0, y: 0, width: 375, height: 228)
        view.backgroundColor = .white
        let layer0 = CAGradientLayer()
        layer0.colors = [
          UIColor(red: 0.263, green: 0.337, blue: 0.706, alpha: 1).cgColor,
          UIColor(red: 0.239, green: 0.812, blue: 0.812, alpha: 1).cgColor
        ]
        layer0.locations = [0, 1]
        layer0.startPoint = CGPoint(x: 0.25, y: 0.5)
        layer0.endPoint = CGPoint(x: 0.75, y: 0.5)
        layer0.transform = CATransform3DMakeAffineTransform(CGAffineTransform(a: 0, b: 1, c: -1, d: 0, tx: 1, ty: 0))
        layer0.bounds = view.bounds.insetBy(dx: -0.5*view.bounds.size.width, dy: -0.5*view.bounds.size.height)
        layer0.position = view.center
        view.layer.addSublayer(layer0)
        var parent = self.view!
        parent.addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.widthAnchor.constraint(equalToConstant: 375).isActive = true
        view.heightAnchor.constraint(equalToConstant: 228).isActive = true
        view.leadingAnchor.constraint(equalTo: parent.leadingAnchor, constant: 0).isActive = true
        view.topAnchor.constraint(equalTo: parent.topAnchor, constant: 0).isActive = true
    }
    
    func customGradient() {
        let layer0 = CAGradientLayer()
        layer0.colors = [
            UIColor(rgb: 0xff4356B4).cgColor,
            UIColor(rgb: 0xff3DCFCF).cgColor
        ]
        layer0.locations = [0, 0.5]
        layer0.startPoint = CGPoint(x: 0, y: 0.5)
        layer0.endPoint = CGPoint(x: 0.25, y: 0.5)
        
        //layer0.transform = CATransform3DMakeAffineTransform(CGAffineTransform(a: 0, b: 1, c: -1, d: 0, tx: 1, ty: 0))
        //layer0.bounds = viewGradient.bounds.insetBy(dx: -0.5*view.bounds.size.width, dy: -0.5*view.bounds.size.height)
        layer0.position = viewGradient.center
        viewGradient.layer.addSublayer(layer0)
        
        tableView.roundCorners(corners: [.topLeft, .topRight], radius: 20)
        viewGradient.addSubview(lbTinNhan)
        viewGradient.addSubview(imgIconMessenger)
        viewGradient.addSubview(searchBar)
        view.addSubview(tableView)

        searchBar.backgroundColor = UIColor.clear
        searchBar.layer.cornerRadius = 20
        
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
