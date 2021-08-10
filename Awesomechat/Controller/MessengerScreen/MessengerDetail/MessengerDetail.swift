//
//  MessengerDetail.swift
//  Awesomechat
//
//  Created by admin on 8/2/21.
//

import UIKit
import FirebaseAuth

class MessengerDetail: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var viewHeader: UIView!
    @IBOutlet weak var viewContentChat: UIView!
    @IBOutlet weak var viewHeaderDetaild: UIView!
    
    @IBOutlet weak var btBack: UIButton!
    @IBOutlet weak var imgAvatarDetail: UIImageView!
    @IBOutlet weak var lbNameFriend: UILabel!
    @IBOutlet weak var lbDateStarMessenger: UILabel!
    @IBOutlet weak var viewContentLbDateStarMessenger: UIView!
    
    let pushDataMessenger = PushDataMesenger()
    
    
    var imgSelecter = UIImageView()
    let txtInputChat = UITextField()
    var imgSenderMessenger = UIImageView()
    let imgSticker = UIImageView()
    
    var dataChatRoom: ChatRoom?
    
    var arrayDataDate: [String] = []
    
    var bottomContraintTable: NSLayoutConstraint?
    var trailingContraintInputChat: NSLayoutConstraint?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(viewContentChat)
        view.backgroundColor = UIColor(rgb: 0xffE5E5E5)
        tableView.keyboardDismissMode = .onDrag
        tableView.separatorStyle = .none
        tableView.layer.cornerRadius = 30
        
        
        //MessengerDetailCellID
        tableView.register(MessengerDetailCell.self, forCellReuseIdentifier: "MessengerDetailCellID")
        
        // checkMessengerContinue()
        setupInputComponents()
        setupKeyboardObserver()
        handleDisplayData()
        view.addConstraint(bottomContraintTable!)
        //view.addConstraints([bottomContraint!])
        
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
        
//        bottomContraint = NSLayoutConstraint(item: viewContentChat!, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1, constant: 0)
        bottomContraintTable = NSLayoutConstraint(item: tableView!, attribute: .bottom, relatedBy: .equal, toItem: view.safeAreaLayoutGuide, attribute: .bottom, multiplier: 1, constant: 75)
        
    }
    
    // MARK: HANDLE DISPLAY DATA
    func handleDisplayData() {
        lbNameFriend.text = dataChatRoom?.participant?.userName
        
    }
    
    // MARK: HANDLE KEYBOARD WILL SHOW
    @objc func handleKeyboardWillShow(notification: Notification) {
        guard let keyboardValue = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {
            return
        }
        //bottomContraint?.constant = -keyboardValue.height
        bottomContraintTable?.constant = -keyboardValue.height - 40
        UIView.animate(withDuration: 0, delay: 0, options: .curveEaseOut, animations: {
            self.view.layoutIfNeeded()
        }, completion: { (completion) in
            self.tableView.scrollToRow(at: IndexPath(row: (self.dataChatRoom?.chatMessages.count ?? 1) - 1, section: 0), at: .bottom, animated: true)
        })
        
    }
    
    // MARK: HANDLE KEYBOARD DID SHOW
    @objc func handleKeyboardDidShow() {
        self.viewContentChat.addSubview(self.imgSenderMessenger)
        self.viewContentChat.addSubview(self.imgSelecter)
        txtInputChat.translatesAutoresizingMaskIntoConstraints = false
        trailingContraintInputChat = txtInputChat.trailingAnchor.constraint(equalTo: viewContentChat.trailingAnchor, constant: -60)
        viewContentChat.addConstraints([trailingContraintInputChat!])
        
        let tapSenderMessenger = UITapGestureRecognizer(target: self, action: #selector(tapImgSenderMessenger))
        imgSenderMessenger.isUserInteractionEnabled = true
        imgSenderMessenger.addGestureRecognizer(tapSenderMessenger)

        let tapImgSticker = UITapGestureRecognizer(target: self, action: #selector(tapImgStickerRights))
        imgSticker.isUserInteractionEnabled = true
        imgSticker.addGestureRecognizer(tapImgSticker)
        
        imgSenderMessenger.translatesAutoresizingMaskIntoConstraints = false
        imgSenderMessenger.trailingAnchor.constraint(equalTo: viewContentChat.trailingAnchor, constant: -12).isActive = true
        imgSenderMessenger.topAnchor.constraint(equalTo: viewContentChat.topAnchor, constant: 24).isActive = true
        imgSenderMessenger.heightAnchor.constraint(equalToConstant: 22).isActive = true
        imgSenderMessenger.widthAnchor.constraint(equalToConstant: 26).isActive = true
        imgSenderMessenger.image = UIImage(named: "Group-2")
        
    }
    
    // MARK: HANDLE KEYBOARD HIDE
    @objc func handleKeyboardWillHide() {
        //bottomContraint!.constant = 0
        bottomContraintTable?.constant = 75
    }
    
    @objc func handleKeyboardDidHide() {
        viewContentChat.translatesAutoresizingMaskIntoConstraints = false
        viewContentChat.removeConstraint(trailingContraintInputChat!)
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
        
        let tapImgSeclecter = UITapGestureRecognizer(target: self, action: #selector(self.tapImgSelecter))
        imgSelecter.isUserInteractionEnabled = true
        imgSelecter.addGestureRecognizer(tapImgSeclecter)
        
        txtInputChat.translatesAutoresizingMaskIntoConstraints = false
        txtInputChat.topAnchor.constraint(equalTo: viewContentChat.topAnchor, constant: 10).isActive = true
        txtInputChat.leadingAnchor.constraint(equalTo: imgSelecter.trailingAnchor, constant: 10).isActive = true
        txtInputChat.trailingAnchor.constraint(equalTo: viewContentChat.trailingAnchor, constant: -12).isActive = true
        txtInputChat.heightAnchor.constraint(equalToConstant: 52).isActive = true
        txtInputChat.backgroundColor = UIColor(rgb: 0xffF6F6F6)
        txtInputChat.layer.cornerRadius = CGFloat(25)
        txtInputChat.clipsToBounds = true
        txtInputChat.placeholder = "  Nhập tin nhắn..."
        txtInputChat.font = UIFont(name: "Lato", size: 16)
        
        // IMGSTICKER
        imgSticker.image = UIImage(named: "smile 1")
        let tapImgSticker = UITapGestureRecognizer(target: self, action: #selector(tapImgStickerRights))
        imgSticker.isUserInteractionEnabled = true
        imgSticker.addGestureRecognizer(tapImgSticker)
        txtInputChat.addSubview(imgSticker)
        imgSticker.translatesAutoresizingMaskIntoConstraints = false
        txtInputChat.rightView = imgSticker
        txtInputChat.rightViewMode = .always
        
        //MARK: VIEW HEADER:
        
        viewContentLbDateStarMessenger.layer.cornerRadius = 20
        viewContentLbDateStarMessenger.backgroundColor = UIColor(rgb: 0xffE5E5E5)
        lbDateStarMessenger.text = "Hôm qua"
        viewHeaderDetaild.backgroundColor = UIColor(rgb: 0xffE5E5E5)
        
    }
    
    @IBAction func btBackToListMessenger(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
        
    }
    
    
    // MARK: PUSH DATA MESSENGER:
    @objc func tapImgSenderMessenger() {
        guard let textInput = txtInputChat.text else {
            return
        }
        if textInput.isEmpty {
            return
        }
         print(self.dataChatRoom?.chatMessages.last?.timeLong)
        pushDataMessenger.pushDataChat(completion: { (dataChatMessage) in
            print("Completion")
            print(textInput)
           
            let inserIndexChatMessage = self.dataChatRoom?.chatMessages.count
            self.dataChatRoom?.chatMessages.append(dataChatMessage)
            
            self.tableView.insertRows(at: [IndexPath(item: (inserIndexChatMessage)! - 1, section: 0)], with: .bottom)
            self.tableView.scrollToRow(at: IndexPath(item: (inserIndexChatMessage)! - 1, section: 0), at: .bottom, animated: true)
            self.txtInputChat.text = nil
            self.tableView.reloadData()
//            print(self.dataChatRoom?.chatMessages[count].timeLong )
//            print(self.dataChatRoom?.chatMessages[count - 1].timeLong )
            
            
        }, messenger: textInput, idReceiver: dataChatRoom?.participant?.userId ?? "", idSender: Auth.auth().currentUser?.uid ?? "", idChatRoom: dataChatRoom?.roomId ?? "")
        tableView.reloadData()
        
        print(dataChatRoom?.participant?.userId ?? "")
        
        
    }
    
    @objc func tapImgStickerRights() {
        print("ssdfdssdf")
        
    }

    @objc func tapImgSelecter() {
        print("sdsdfdfd")
        self.dismiss(animated: true, completion: nil)
        
    }
}

extension MessengerDetail: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
}

extension MessengerDetail: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataChatRoom?.chatMessages.count ?? 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let stringImg = URL(string: dataChatRoom?.participant?.userImgUrl ?? "")
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "MessengerDetailCellID") as! MessengerDetailCell
        cell.lbContentMessenger.text = dataChatRoom?.chatMessages[indexPath.row].messenger
        
        do {
            let dataImg = try Data(contentsOf: stringImg!)
            cell.imgAvatarCell.image = UIImage(data: dataImg)
        } catch {
            cell.imgAvatarCell.image = UIImage(named: "defauld")
        }
        
        cell.isInComing = dataChatRoom?.chatMessages[indexPath.row].idSender != Auth.auth().currentUser?.uid
        
        
        cell.lbDateMessenger.text = dataChatRoom?.chatMessages[indexPath.row].time
        //cell.textLabel?.text = String(dataChatRoom?.chatMessages[indexPath.row].timeLong)
        
        return cell
    }
    
    
}
