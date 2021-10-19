//
//  PersonalProfile.swift
//  Awesomechat
//
//  Created by admin on 9/20/21.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseStorage

class PersonalProfile: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    
    @IBOutlet weak var viewContentAvatar: UIView!
    @IBOutlet weak var viewGradient: UIView!
    @IBOutlet weak var imgAvatar: UIImageView!
    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var txtPhoneNumber: UITextField!
    @IBOutlet weak var txtDateOfBirth: UITextField!
    @IBOutlet weak var viewContent: UIView!
    @IBOutlet weak var btBack: UIButton!
    @IBOutlet weak var lbTitle: UILabel!
    @IBOutlet weak var btSave: UIButton!
    
    let viewContentCamera = UIView()
    let imgCamera = UIImageView()
    var selectImagePicker: UIImage?
    var imagePicker = UIImagePickerController()
    let storage = Storage.storage().reference()
    var dataUser: DataUser?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        customComponent()
        customAvatar()
        
    }
    
    func customAvatar() {
        
        viewContent.layer.cornerRadius = CGFloat(30)
        
        viewContentAvatar.translatesAutoresizingMaskIntoConstraints = false
        imgAvatar.translatesAutoresizingMaskIntoConstraints = false
        viewContentCamera.translatesAutoresizingMaskIntoConstraints = false
        imgCamera.translatesAutoresizingMaskIntoConstraints = false
        
        viewContentAvatar.addSubview(viewContentCamera)
        viewContentCamera.addSubview(imgCamera)
        imgAvatar.layer.cornerRadius = imgAvatar.frame.height / 2
        imgAvatar.clipsToBounds = true
        viewContentAvatar.backgroundColor = UIColor.white
        imgAvatar.sizeToFit()
        
        NSLayoutConstraint(item: viewContentCamera, attribute: .centerX, relatedBy: .equal, toItem: imgAvatar, attribute: .centerX, multiplier: 1.7, constant: 0).isActive = true
        NSLayoutConstraint(item: viewContentCamera, attribute: .centerY, relatedBy: .equal, toItem: imgAvatar, attribute: .centerY, multiplier: 1.7, constant: 0).isActive = true
        viewContentCamera.heightAnchor.constraint(equalToConstant: 60).isActive = true
        viewContentCamera.widthAnchor.constraint(equalToConstant: 60).isActive = true
        
        viewContentCamera.layer.cornerRadius = CGFloat(30)
        viewContentCamera.clipsToBounds = false
        viewContentCamera.backgroundColor = UIColor(rgb: 0xff4356B4)
        viewContentCamera.layer.borderWidth = 2.5
        viewContentCamera.layer.borderColor = UIColor.white.cgColor
        viewContentCamera.layer.cornerRadius = CGFloat(30)

        //viewContentCamara.sizeToFit()
        viewContentCamera.addSubview(imgCamera)
        imgCamera.image = UIImage(named: "photo-camera")
        
        // contraint:
        NSLayoutConstraint(item: imgCamera, attribute: .centerY, relatedBy: .equal, toItem: viewContentCamera, attribute: .centerY, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: imgCamera, attribute: .centerX, relatedBy: .equal, toItem: viewContentCamera, attribute: .centerX, multiplier: 1, constant: 0).isActive = true
        imgCamera.heightAnchor.constraint(equalToConstant: 40).isActive = true
        imgCamera.widthAnchor.constraint(equalToConstant: 40).isActive = true
        imgCamera.clipsToBounds = true
        imgCamera.isUserInteractionEnabled = true
        
        let tapGetureImg = UITapGestureRecognizer(target: self, action: #selector(tapCamera))
        imgCamera.addGestureRecognizer(tapGetureImg)
        
        
        
        // set vi tri cua view nam ben duoi cai avatar:
         
    }
    
    func customComponent() {
        
        let ref: DatabaseReference?
        ref = Database.database().reference()
        
        let colorTop =  UIColor(rgb: 0xff4356B4).cgColor
        let colorBottom = UIColor(rgb: 0xff3DCFCF).cgColor
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [colorTop, colorBottom]
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.frame = CGRect(x: 0.0, y: 0.0, width: self.viewGradient.frame.size.width, height: self.viewGradient.frame.size.height )
        viewGradient.addSubview(btBack)
        viewGradient.addSubview(btSave)
        viewGradient.addSubview(lbTitle)
        viewGradient.layer.addSublayer(gradientLayer)
        ref?.child("users/\(Auth.auth().currentUser!.uid)").getData(completion: {(error, dataSnapshot) in
            guard error == nil else {
                return
            }
            
            self.dataUser = DataUser(snapShot: dataSnapshot)
            
            
            DispatchQueue.main.async {
                self.txtName.text = self.dataUser?.userName
                self.txtDateOfBirth.text = self.dataUser?.userDateOfBirth
                self.txtPhoneNumber.text = self.dataUser?.userPhone
                
                do {
                    let dataImg = try Data(contentsOf: URL(string: self.dataUser?.userImgUrl ?? "") ?? URL(string: "defauld.png")!)
                    self.imgAvatar.image = UIImage(data: dataImg)
                } catch {
                    self.imgAvatar.image = UIImage(named: "default")
                }
            }
        })
        
        
    }
    
    
    @objc func tapCamera() {
        // thuc hien viec lien ke đến thu viện camera:
        imagePicker.allowsEditing = true
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            imagePicker.delegate = self
            imagePicker.sourceType = .camera
            self.present(imagePicker, animated: true, completion: nil)
            
        } else {
            imagePicker.delegate = self
            imagePicker.sourceType = .photoLibrary
            self.present(imagePicker, animated: true, completion: nil)
           
        }
        
    }
    
    
    
    @IBAction func actionSave(_ sender: Any) {
        
        let ref: DatabaseReference?
        ref = Database.database().reference()
        
        // chia ra 2 truong hop, khi ma nguoi dung chi thay doi ten va ngay sinh thoi: thi khong can phai push image len: cho nay dang hien thi sai: 
        guard let imageData = selectImagePicker?.pngData() else {
            // truong hop chi muon thay doi ngay sinh, ten:
            let valuePost: [String: Any] = [
                "userStatus": "online",
                "userDateOfBirth": self.txtDateOfBirth.text ?? "",
                "email": self.dataUser?.userEmail ?? "",
                "userId": Auth.auth().currentUser?.uid ?? "",
                "userImgUrl": self.dataUser?.userImgUrl ?? "",
                "userName": self.txtName.text ?? "",
                "userPhone": self.txtPhoneNumber.text ?? ""
                
            ]
            ref?.child("users").child(Auth.auth().currentUser?.uid ?? "").setValue(valuePost)
            
            let alert = UIAlertController(title: "Thông Báo ", message: "Đã cập nhật thành công", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Thoát", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            
            return
        }
        
        
        pushImageAvatarToStore(imgData: imageData, completionHandle: { imgStringUrl in
            //imgStringUrls = imgStringUrl
            
            let valuePost: [String: Any] = [
                "userStatus": "online",
                "userDateOfBirth": self.txtDateOfBirth.text ?? "",
                "email": self.dataUser?.userEmail ?? "",
                "userId": Auth.auth().currentUser?.uid ?? "",
                "userImgUrl": imgStringUrl,
                "userName": self.txtName.text ?? "",
                "userPhone": self.txtPhoneNumber.text ?? ""
                
            ]
            
            ref?.child("users").child(Auth.auth().currentUser?.uid ?? "").setValue(valuePost)
            let alert = UIAlertController(title: "Thông Báo ", message: "Đã cập nhật thành công", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Thoát", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        })
        self.reloadInputViews()
        
    }
    
    @IBAction func actionBack(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        // chon image tu thu vien hoac tu camera:
        
        if let editImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            selectImagePicker = editImage
        } else if let originImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            selectImagePicker = originImage
        }
        
        imgAvatar.image = selectImagePicker
        
        self.dismiss(animated: true, completion: nil)
        print("image Picker")

        
    }
    
    //let urlString: String = ""
    
    func pushImageAvatarToStore(imgData: Data, completionHandle: @escaping (String) -> Void ) {
        let ref = storage.child("user_image").child(Auth.auth().currentUser?.uid ?? "").child(NSUUID().uuidString)
        
        ref.putData(imgData, metadata: nil, completion: { (strongMeta, error) in
            guard error == nil else { return }
                     
            ref.downloadURL(completion: { (url, error) in
                guard let urlString = url?.absoluteString else {
                    return
                }
                DispatchQueue.main.async {
                    completionHandle(urlString)
                }
                
                
            })
        })
    }
}
