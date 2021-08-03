//
//  MessengerDetail.swift
//  Awesomechat
//
//  Created by admin on 8/2/21.
//

import UIKit

class MessengerDetail: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet var viewHeader: UIView!
    @IBOutlet weak var viewContentChat: UIView!

    lazy var imgSelecter = UIImageView()
    let txtInputChat = UITextField()
    lazy var imgSenderMessenger = UIImageView()
    var arrayData: [String] = ["sdfsdf","fsdfsdfsd","dsffsdfds","dsffsdfs",
                               "sasdsdsads","sdfsdfsdfs","dfsdfsdfsdf","sdfsdfwrwerw"]
    var bottomContraint: NSLayoutConstraint?
    var bottomContraintTable: NSLayoutConstraint?
    var trailingContraintInputChat: NSLayoutConstraint?
    
   // let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapSelecterImg))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(viewContentChat)
        tableView.keyboardDismissMode = .onDrag
        
        tableView.register(UINib(nibName: "MessengerDetailCell", bundle: nil), forCellReuseIdentifier: "MessengerDetailCellID")
        
        setupInputComponents()
        setupKeyboardObserver()
        view.addConstraint(bottomContraintTable!)
        view.addConstraints([bottomContraint!])
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        //NotificationCenter.default.removeObserver(self)
    }
     
    func setupKeyboardObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardDidShow), name: UIResponder.keyboardDidShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardDidHide), name: UIResponder.keyboardDidHideNotification, object: nil)
        
        bottomContraint = NSLayoutConstraint(item: viewContentChat!, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1, constant: 0)
        bottomContraintTable = NSLayoutConstraint(item: tableView!, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1, constant: 75)
        
        
    }
    
    // MARK: HANDLE KEYBOARD SHOW
    @objc func handleKeyboardWillShow(notification: Notification) {
        guard let keyboardValue = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {
            return
        }
        bottomContraint!.constant = -keyboardValue.height - view.safeAreaInsets.bottom - 50
        bottomContraintTable?.constant = -keyboardValue.height - 60
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.tapSelecterImg))
        imgSelecter.isUserInteractionEnabled = true
        imgSelecter.addGestureRecognizer(tapGestureRecognizer)
        
        UIView.animate(withDuration: 0, delay: 0, options: .curveEaseOut, animations: {
            self.view.layoutIfNeeded()
        }, completion: { (completion) in
            self.tableView.scrollToRow(at: IndexPath(row: self.arrayData.count - 1, section: 0), at: .bottom, animated: true)
        })
    }
    
    // MARK: HANDLE KEYBOARD HIDE
    @objc func handleKeyboardWillHide() {
        bottomContraint!.constant = 0
        bottomContraintTable?.constant = 75
          
    }
    
    @objc func handleKeyboardDidShow() {
        
        self.viewContentChat.addSubview(self.imgSenderMessenger)
        self.viewContentChat.addSubview(self.imgSelecter)
        txtInputChat.translatesAutoresizingMaskIntoConstraints = false
        trailingContraintInputChat = txtInputChat.trailingAnchor.constraint(equalTo: viewContentChat.trailingAnchor, constant: -60)
        viewContentChat.addConstraints([trailingContraintInputChat!])
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapSelecterImgs))
        imgSelecter.isUserInteractionEnabled = true
        imgSelecter.addGestureRecognizer(tapGestureRecognizer)
        
        let tapSenderMessenger  = UITapGestureRecognizer(target: self, action: #selector(tapImgSenderMessenger))
        imgSenderMessenger.isUserInteractionEnabled = true
        imgSenderMessenger.addGestureRecognizer(tapSenderMessenger)
        
        imgSenderMessenger.accessibilityActivate()
        imgSenderMessenger.adjustsImageSizeForAccessibilityContentSizeCategory = true
        imgSenderMessenger.accessibilityElementIsFocused()
        
        
        imgSenderMessenger.translatesAutoresizingMaskIntoConstraints = false
        imgSenderMessenger.trailingAnchor.constraint(equalTo: viewContentChat.trailingAnchor, constant: -12).isActive = true
        imgSenderMessenger.topAnchor.constraint(equalTo: viewContentChat.topAnchor, constant: 24).isActive = true
        imgSenderMessenger.heightAnchor.constraint(equalToConstant: 22).isActive = true
        imgSenderMessenger.widthAnchor.constraint(equalToConstant: 26).isActive = true
        imgSenderMessenger.image = UIImage(named: "Group-2")
        
    }
    
    @objc func handleKeyboardDidHide() {
        viewContentChat.translatesAutoresizingMaskIntoConstraints = false
        txtInputChat.translatesAutoresizingMaskIntoConstraints = false
        viewContentChat.removeConstraints([trailingContraintInputChat!])
        //txtInputChat.removeFromSuperview()
        imgSenderMessenger.removeFromSuperview()
    }
    
    func setupInputComponents() {
        // IMGSELECT; TEXTFIELD
        viewContentChat.addSubview(imgSelecter)
        viewContentChat.addSubview(txtInputChat)
        imgSelecter.image = UIImage(named: "Add photo")
        imgSelecter.translatesAutoresizingMaskIntoConstraints = false
        imgSelecter.topAnchor.constraint(equalTo: viewContentChat.topAnchor, constant: 10).isActive = true
        imgSelecter.leadingAnchor.constraint(equalTo: viewContentChat.leadingAnchor, constant: 12).isActive = true
        imgSelecter.heightAnchor.constraint(equalToConstant: 52).isActive = true
        imgSelecter.widthAnchor.constraint(equalToConstant: 52).isActive = true
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.tapSelecterImg))
        imgSelecter.isUserInteractionEnabled = true
        imgSelecter.addGestureRecognizer(tapGestureRecognizer)
        
        txtInputChat.translatesAutoresizingMaskIntoConstraints = false
        txtInputChat.topAnchor.constraint(equalTo: viewContentChat.topAnchor, constant: 10).isActive = true
        txtInputChat.leadingAnchor.constraint(equalTo: imgSelecter.trailingAnchor, constant: 10).isActive = true
        txtInputChat.trailingAnchor.constraint(equalTo: viewContentChat.trailingAnchor, constant: -12).isActive = true
        txtInputChat.heightAnchor.constraint(equalToConstant: 52).isActive = true
        txtInputChat.backgroundColor = UIColor(rgb: 0xffF6F6F6)
        txtInputChat.layer.cornerRadius = CGFloat(25)
        txtInputChat.clipsToBounds = true
        txtInputChat.placeholder = "Nhập tin nhắn..."
        txtInputChat.font = UIFont(name: "Lato", size: 16)
        
        // IMGSTICKER
        let imgSticker = UIImageView()
        imgSticker.image = UIImage(named: "smile 1")
        let tapImageRight = UITapGestureRecognizer(target: self, action: #selector(tapImgStickerRights))
        imgSticker.isUserInteractionEnabled = true
        imgSticker.addGestureRecognizer(tapImageRight)
        txtInputChat.addSubview(imgSticker)
        txtInputChat.frame(forAlignmentRect: .infinite)
        
        imgSticker.translatesAutoresizingMaskIntoConstraints = false
        imgSticker.rightAnchor.constraint(equalTo: txtInputChat.rightAnchor, constant: -14).isActive = true
        imgSticker.heightAnchor.constraint(equalToConstant: 24).isActive = true
        imgSticker.widthAnchor.constraint(equalToConstant: 24).isActive = true
        imgSticker.topAnchor.constraint(equalTo: txtInputChat.topAnchor, constant: 14).isActive = true
    }
    
    
    @objc func tapImgSenderMessenger() {
        print("TAp Sender Messenger")
        
    }
    
    @objc func tapImgStickerRights() {
        print("ssdfdssdf")
        
    }

    @objc func tapSelecterImg() {
        print("sdsdfdfd")
        self.dismiss(animated: true, completion: nil)
        
    }
    @objc func tapSelecterImgs() {
        print("dfjdjfjd")
    }
}

extension MessengerDetail: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    
}

extension MessengerDetail: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MessengerDetailCellID", for: indexPath) as! MessengerDetailCell
        
        cell.textLabel?.text = arrayData[indexPath.row]
        return cell
    }
    
    
}
