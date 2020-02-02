//
//  ViewController.swift
//  MusicBattlesApp
//
//  Created by Oswaldo Morales on 1/29/20.
//  Copyright © 2020 Oswaldo Morales. All rights reserved.
//

import UIKit
import SWSegmentedControl

class ViewController: UIViewController {
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var navigationView: UIView!
    
    var galleryView_: galleryView!
    var playerView_: playerView!
    var userView: userView_!
    
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
    
    //PRAGMA MARK: UserView
    
    @objc func logoutUser(_ Sender: Any){
        
        debugPrint("Logout User")
        //self.dismiss(animated: true, completion: nil)
       // self.navigationController?.popToRootViewController(animated: true)
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
       


}

