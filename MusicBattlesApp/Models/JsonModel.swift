//
//  JsonModel.swift
//  MusicBattlesApp
//
//  Created by Oswaldo Morales on 2/3/20.
//  Copyright © 2020 Oswaldo Morales. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import SDWebImage


class JsonModel: NSObject {
    
    var tittleArray : [String] = [];
    var viewsArray : [Int] = [];
    var descriptionArray : [String] = [];
    var linkArray : [String] = [];
    var upsArray : [Int] = [];
    var scoreArray : [Int] = [];
    var downArray : [Int] = [];
    //var delegate : reloadTable! = nil
    
    

    
    /*func restService(category: String, sort: String, showViral: Bool) -> (title:[String], description:[String]) {
        
        //Set Your Client ID Number
        let headers = ["Authorization": "Client-ID **********"]
        let baseURL = "https://api.imgur.com/3/gallery/\(category)/\(sort)/0/day/\(showViral).json"
        
        print("Base URL:  \(baseURL)")
        
      Alamofire.request(baseURL, method: .get , parameters: nil ,encoding: JSONEncoding.default, headers: headers).responseJSON{ response in
               
                        
                        
                    }
                    
        
                    
                    
            
                    
                }*/
                
                
        


}
