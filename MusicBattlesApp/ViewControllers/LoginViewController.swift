//
//  LoginViewController.swift
//  MusicBattlesApp
//
//  Created by Oswaldo Morales on 1/30/20.
//  Copyright © 2020 Oswaldo Morales. All rights reserved.
//

import UIKit
import TTGSnackbar
import CoreData

class LoginViewController: UIViewController {
    
    @IBOutlet weak var userTXT: UITextField!
    @IBOutlet weak var passTXT: UITextField!
    @IBOutlet weak var loginBTN: UIButton!
    @IBOutlet weak var registerBTN: UIButton!
    
    var userCoreData = [User]()
    var userArray: Array<String> = []
    
    

    override func viewDidLoad() {

        let defaults = UserDefaults.standard
        let user_ = defaults.string(forKey: "user")
        if user_ != nil{
        self.performSegue(withIdentifier: "goToMain", sender: self)
        }
        super.viewDidLoad()
        
        self.initViews()
        self.setGradientBackground()
        self.loadUsers()
    }
    
    private func initViews(){
        
        userTXT.layer.cornerRadius = 10
        passTXT.layer.cornerRadius = 10
        loginBTN.layer.cornerRadius = 10
        
        loginBTN.addTarget(self, action: #selector(login_(Sender:)), for: .touchUpInside)
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))

        view.addGestureRecognizer(tap)
        self.navigationController?.isNavigationBarHidden = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
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
    
    @objc func dismissKeyboard() {
             //Causes the view (or one of its embedded text fields) to resign the first responder status.
             view.endEditing(true)
      }
    
    @objc func login_(Sender: Any){
        
     
        view.endEditing(true)
        
        if (!userTXT.text!.isEmpty || !passTXT.text!.isEmpty){
            
            if userCoreData.count > 0 {
                
                 if userArray.contains(userTXT.text!){
                    
                    let indexUser = userArray.firstIndex(of: userTXT.text!)!
                    let pass = userCoreData[indexUser].password
                    
                    if pass == passTXT.text{
                        
                        
                        userTXT.layer.borderWidth = 0
                        passTXT.layer.borderWidth = 0
                        let defaults = UserDefaults.standard
                        defaults.set(userTXT.text, forKey: "user")
                        self.performSegue(withIdentifier: "goToMain", sender: self)
                                  
                        
                    }else{
                        
                        debugPrint("Error Login 2 No Match Pass")
                        self.showErrorLogin()
                    }
                    
                    
                    
                 }else{
                    
                    debugPrint("Error Login 2 No User in DB")
                    self.showErrorLogin()
                    
                }
                
                
            }else{
                
                debugPrint("Error Login 2 No DB")
                showErrorLogin()
            }
            
          
        }else{
            debugPrint("Error Login 1")
            userTXT.layer.borderColor = UIColor.red.cgColor
            passTXT.layer.borderColor = UIColor.red.cgColor
            userTXT.layer.borderWidth = 1
            passTXT.layer.borderWidth = 1
            let snackbar = TTGSnackbar(message: "Completa los datos faltantes", duration: .middle)
            snackbar.show()
        }
        
    
    }
    
    private func showErrorLogin(){
        
        userTXT.layer.borderColor = UIColor.red.cgColor
        passTXT.layer.borderColor = UIColor.red.cgColor
        userTXT.layer.borderWidth = 1
        passTXT.layer.borderWidth = 1
        let snackbar = TTGSnackbar(message: "Usuario o Contraseña incorrectos", duration: .middle)
        snackbar.show()

        
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
                       
                            debugPrint("User CoreData  No Data ")
                       }
                      
                  }catch{}
           
           
       }
       



}
