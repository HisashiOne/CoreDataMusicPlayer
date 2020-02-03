//
//  ViewController.swift
//  MusicBattlesApp
//
//  Created by Oswaldo Morales on 1/29/20.
//  Copyright © 2020 Oswaldo Morales. All rights reserved.
//

import UIKit
import SWSegmentedControl
import TTGSnackbar
import CoreData


class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate,  UITextViewDelegate {
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var navigationView: UIView!
    
    var galleryView_: galleryView!
    var playerView_: playerView!
    var userView: userView_!
    
    var userDB: String!
    var indexUser: Int!
    var userCoreData = [User]()
    var userArray: Array<String> = []
    let imagePicker = UIImagePickerController()
    
    let sc = SWSegmentedControl(items: ["GALLERY", "PLAYER", "USER"])
    

    override func viewDidLoad() {
        super.viewDidLoad()
    
        
        
        sc.frame = self.navigationView.frame
        sc.titleColor = .white
        sc.font = UIFont.boldSystemFont(ofSize: 16.0)
        sc.indicatorColor = .white
        sc.unselectedTitleColor = .blue
        sc.addTarget(self, action: #selector(updateView(_:)), for: UIControl.Event.valueChanged)
        self.view.addSubview(sc)
        

        self.navigationController?.isNavigationBarHidden = true
        self.navigationController?.isNavigationBarHidden = true
        self.setGradientBackground()
       
        
        let defaults = UserDefaults.standard
        userDB = defaults.string(forKey: "user")
        
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
              
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
              view.addGestureRecognizer(tap)
        
        self.loadUsers()
        self.loadIndexUser()
        
         self.initView()
        
   
        

    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
    }
    
    
    private func initView(){
        
        
        var frame_1: CGRect = CGRect(x: 0, y: 0, width: 0, height: 0)
        frame_1.size = self.containerView.frame.size
    
        //GalleryView
        let bundle_1 = Bundle(for: galleryView.self)
        let nib_1 = UINib(nibName: "galleryView", bundle: bundle_1)
        galleryView_ = nib_1.instantiate(withOwner: self, options: nil)[0] as? galleryView
        galleryView_.frame =  self.containerView.frame
        galleryView_.frame.origin.y =  self.containerView.frame.origin.y - 100
        containerView.addSubview(galleryView_)
        
        
        //PlayerView
        let bundle_2 = Bundle(for: playerView.self)
        let nib_2 = UINib(nibName: "playerView", bundle: bundle_2)
        playerView_ = nib_2.instantiate(withOwner: self, options: nil)[0] as? playerView
        playerView_.frame =  self.containerView.frame
        playerView_.frame.origin.y =  self.containerView.frame.origin.y - 100
        containerView.addSubview(playerView_)
        playerView_.isHidden = true
        
        //UserView
        let bundle_3 = Bundle(for: userView_.self)
        let nib_3 = UINib(nibName: "userView", bundle: bundle_3)
        userView = nib_3.instantiate(withOwner: self, options: nil)[0] as? userView_
        userView.frame =  self.containerView.frame
        userView.frame.origin.y =  self.containerView.frame.origin.y - 100
        containerView.addSubview(userView)
        userView.isHidden = true
        
        initUser()
    
        userView.logoutBTN.addTarget(self, action: #selector(logoutUser(_:)), for: .touchUpInside)
        self.navigationController?.isNavigationBarHidden = true
        
        
        
    }
    
    @objc func updateView(_ sender: Any) {
        
        if sc.selectedSegmentIndex == 0 {
            debugPrint("Show Gallery")
            userView.isHidden = true
            playerView_.isHidden = true
            galleryView_.isHidden = false
                   
            }else if sc.selectedSegmentIndex == 1 {
            debugPrint("Show Player")
            userView.isHidden = true
            playerView_.isHidden = false
            galleryView_.isHidden = true
               
            }
            else{
            debugPrint("Show User")
            userView.isHidden = false
            playerView_.isHidden = true
            galleryView_.isHidden = true
            
            }
          
        
    }
    
    @objc func dismissKeyboard() {
                //Causes the view (or one of its embedded text fields) to resign the first responder status.
                view.endEditing(true)
         }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
             if self.view.frame.origin.y == 0{
                 self.view.frame.origin.y -= keyboardSize.height - 100
             }
         }
     }
     
     @objc func keyboardWillHide(notification: NSNotification) {
        if ((notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue) != nil {
             if self.view.frame.origin.y != 0{
                 //self.view.frame.origin.y += keyboardSize.height
                 
                 let screenSize: CGRect = UIScreen.main.bounds
                 
                 self.view.backgroundColor = .white
                 self.view.frame =  CGRect.init(x: 0, y: 0, width: screenSize.width, height: screenSize.height)
                 
             }
         }
     }
     
    
    
    //PRAGMA MARK: UserView
    
    @objc func logoutUser(_ Sender: Any){
        
        debugPrint("Logout User")
        //self.dismiss(animated: true, completion: nil)
       // self.navigationController?.popToRootViewController(animated: true)
        
        let defaults = UserDefaults.standard
        defaults.removeObject(forKey: "user")
        _ = navigationController?.popViewController(animated: true)
        
    }
    
    func setGradientBackground() {
           let colorTop =  UIColor(red:0.00, green:0.83, blue:1.00, alpha:1.0).cgColor
           let colorBottom = UIColor(red:0.00, green:0.00, blue:0.36, alpha:1.0).cgColor

           let gradientLayer = CAGradientLayer()
           gradientLayer.colors = [colorTop, colorBottom]
           gradientLayer.locations = [0.0, 1.0]
           gradientLayer.frame = self.view.bounds

           self.view.layer.insertSublayer(gradientLayer, at:0)
       }
    
    //PRAGMA MARK: User
    
    func initUser(){
        
        userView.avatarImage.layer.cornerRadius = 50
        userView.nameTXT.layer.cornerRadius = 10
        userView.seccondTXT.layer.cornerRadius = 10
        userView.birthBTN.layer.cornerRadius = 10
        userView.passTXT.layer.cornerRadius = 10
        
        userView.saveBTN.layer.cornerRadius = 10
        userView.saveBTN.layer.borderColor = UIColor.white.cgColor
        userView.saveBTN.layer.borderWidth = 1
     
        userView.logoutBTN.layer.cornerRadius = 10
        userView.logoutBTN.layer.borderColor = UIColor.white.cgColor
        userView.logoutBTN.layer.borderWidth = 1
        
        userView.avatarBTN.layer.cornerRadius = 10
        userView.avatarBTN.layer.borderColor = UIColor.white.cgColor
        userView.avatarBTN.layer.borderWidth = 1
        
        userView.userLBL.text = userCoreData[indexUser].user
        userView.nameTXT.text =  userCoreData[indexUser].name
        userView.seccondTXT.text = userCoreData[indexUser].secondname
        userView.passTXT.text = userCoreData[indexUser].password
        userView.bioTXT.text =  userCoreData[indexUser].bio
        userView.birthBTN.setTitle(userCoreData[indexUser].birthdate, for: .normal)
        
        userView.avatarImage.contentMode = .scaleAspectFill
        
        userView.birthBTN.addTarget(self, action: #selector(datePicker(sender:)), for: .touchUpInside)

        
        let data_ = userCoreData[indexUser].avatar!
        let image_ = UIImage(data: data_)
        userView.avatarImage.image = image_
        
        imagePicker.delegate = self
        
        userView.saveBTN.addTarget(self, action: #selector(updateUser(_:)), for: .touchUpInside)
        userView.avatarBTN.addTarget(self, action: #selector(photoPicker(sender:)), for: .touchUpInside)
        
        
        
        
        
        
    }
    
    @objc func datePicker(sender: Any){
           
       view.endEditing(true)
           
        let myDatePicker: UIDatePicker = UIDatePicker()
        myDatePicker.timeZone = NSTimeZone.local
        myDatePicker.frame = CGRect(x: 0, y: 15, width: 270, height: 200)
           myDatePicker.datePickerMode = .date
        let alertController = UIAlertController(title: "\n\n\n\n\n\n\n\n", message: nil, preferredStyle: UIAlertController.Style.alert)
        alertController.view.addSubview(myDatePicker)
        let selectAction = UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: { _ in
           
           
           
           let formatter = DateFormatter()
           formatter.dateFormat = "dd-MM-yyyy"
           formatter.timeZone = NSTimeZone(forSecondsFromGMT: 0) as TimeZone?
           let dateSelected = (formatter.string(from: myDatePicker.date)).uppercased()
            self.userView.birthBTN.setTitle(dateSelected, for: .normal)
          // print("Selected Date: \(myDatePicker.date)")
           
        })
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel, handler: nil)
        alertController.addAction(selectAction)
        alertController.addAction(cancelAction)
        present(alertController, animated: true, completion:{})
           
       }
       
    
    
    @objc func updateUser(_ sender: Any){
        
        debugPrint("Update User")
        
        
        if !userView.nameTXT.text!.isEmpty{
            userCoreData[indexUser].name = userView.nameTXT.text!
        }
        
        if !userView.seccondTXT.text!.isEmpty{
            userCoreData[indexUser].secondname = userView.seccondTXT.text!
        }
        if !userView.passTXT.text!.isEmpty{
            userCoreData[indexUser].password = userView.passTXT.text!
        }
        
        if !userView.bioTXT.text!.isEmpty{
            userCoreData[indexUser].bio = userView.bioTXT.text!
        }
        
        userCoreData[indexUser].birthdate = userView.birthBTN.currentTitle
        let image = userView.avatarImage.image
        let data = image?.jpegData(compressionQuality: 0.5)
        
        userCoreData[indexUser].avatar = data
    
        
        persitantService.saveContext()
        
        let snackbar = TTGSnackbar(message: "Datos Guardados Crrectamente", duration: .middle)
        snackbar.show()
        
        
    }
    
    @objc func photoPicker(sender: Any){
           
           imagePicker.allowsEditing = false
           imagePicker.sourceType = .photoLibrary
                 
           present(imagePicker, animated: true, completion: nil)
           
       }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
           
           if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
           
           debugPrint("Selected Image")
            userView.avatarImage.contentMode = .scaleAspectFill
            userView.avatarImage.image = pickedImage
           }
           
           dismiss(animated: true, completion: nil)
       }
       
       

     
       func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
           
           dismiss(animated: true, completion: nil)
           
       }
       
    
    
    
    
    //PRAGMA MARK: Core Data
      func loadUsers(){
              let  fetchRequest: NSFetchRequest<User> = User.fetchRequest()
             
             
             do{
                 let userCoreData = try
                     persitantService.context.fetch(fetchRequest)
                        self.userCoreData = userCoreData
                        if userCoreData.count > 0 {

                 
                         let userNames = userCoreData[0].user!
                         
                         debugPrint("User CoreData  DB Total  \(userCoreData)")
                         debugPrint("User Array 0 \(userNames)")
                         
                         for index in 0..<userCoreData.count{
                                            
                         let user_ =  userCoreData[index].user!
                         userArray.append(user_)
                             
                         }
                         
                        }else{
                         
                           
                         }
                        
                    }catch{}
             
             
         }
         
    
    private func loadIndexUser(){
        indexUser = userArray.firstIndex(of: userDB)!
        
        debugPrint("Home User Index \(indexUser ?? 0)")
        
        
    }
       


}

