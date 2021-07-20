//
//  TableViewController.swift
//  Awesomechat
//
//  Created by LongDN on 05/07/2021.
//

import UIKit

class TableViewController: UIViewController {
    
    
    @IBOutlet weak var tableView: UITableView!
    var arrayDiction: [[String : Any]] = [[:]]
    var serverTableView = ServerApiUser()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .camera, target: self, action: #selector(tapBack))
        tableView.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: "TableViewCellID")
        
    }
    
    @objc func tapBack() {
        self.dismiss(animated: true, completion: nil)
    }
}

extension TableViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(arrayDiction.count)
        return arrayDiction.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCellID", for: indexPath)
        cell.textLabel?.text = "arrayDiction[indexPath.row]"
        return cell
    }
    
    
    
}
