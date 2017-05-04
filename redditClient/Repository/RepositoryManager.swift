//
//  RepositoryManager.swift
//  redditClient
//
//  Created by Mauro Gonzalez on 5/4/17.
//  Copyright © 2017 Mauro Gonzalez. All rights reserved.
//

import UIKit
import Alamofire

class RepositoryManager: NSObject {

    static func getRedditTopList(baseURL:String, completationResponse: @escaping(_ response: AnyObject, _ error: Error?)->Void) {
        
        Alamofire.request(baseURL).responseJSON { (response) in
            
            if let json = response.result.value{
            
                print("JSON \(json)")
                
            }
        }
        
    }
}
