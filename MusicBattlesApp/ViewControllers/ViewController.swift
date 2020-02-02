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
    
    let sc = SWSegmentedControl(items: ["GALLERY", "PLAYER", "USER"])
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setGradientBackground()
        
        sc.frame = self.navigationView.frame
        sc.titleColor = .white
        sc.font = UIFont.boldSystemFont(ofSize: 16.0)
        sc.indicatorColor = .white
        sc.unselectedTitleColor = .blue
        sc.addTarget(self, action: #selector(updateView(_:)), for: UIControl.Event.valueChanged)
        self.view.addSubview(sc)
    }
    
    
    @objc func updateView(_ sender: Any) {
          
        
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

