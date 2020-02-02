//
//  LoginViewController.swift
//  MusicBattlesApp
//
//  Created by Oswaldo Morales on 1/30/20.
//  Copyright © 2020 Oswaldo Morales. All rights reserved.
//

import UIKit
import TTGSnackbar

class LoginViewController: UIViewController {
    
    @IBOutlet weak var userTXT: UITextField!
    @IBOutlet weak var passTXT: UITextField!
    @IBOutlet weak var loginBTN: UIButton!
    @IBOutlet weak var registerBTN: UIButton!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.initViews()
        self.setGradientBackground()
    }
    
    private func initViews(){
        
        userTXT.layer.cornerRadius = 10
        passTXT.layer.cornerRadius = 10
        loginBTN.layer.cornerRadius = 10
        
        loginBTN.addTarget(self, action: #selector(login_(Sender:)), for: .touchUpInside)
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))

        view.addGestureRecognizer(tap)
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
            
            
            userTXT.layer.borderWidth = 0
            passTXT.layer.borderWidth = 0
            
            
            self.performSegue(withIdentifier: "goToMain", sender: self)
            
        }else{
            debugPrint("Error Login")
            userTXT.layer.borderColor = UIColor.red.cgColor
            passTXT.layer.borderColor = UIColor.red.cgColor
            userTXT.layer.borderWidth = 1
            passTXT.layer.borderWidth = 1
            let snackbar = TTGSnackbar(message: "Completa los datos faltantes", duration: .middle)
            snackbar.show()
        }
        
       
        
        
    }



}
