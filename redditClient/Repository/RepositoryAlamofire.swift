//
//  RepositoryAlamofire.swift
//  redditClient
//
//  Created by Mauro Gonzalez on 5/18/17.
//  Copyright © 2017 Mauro Gonzalez. All rights reserved.
//

import Foundation
import Alamofire

class RepositoryAlamofire : RepositoryManager {
    
    func getRedditTopList(completationResponse: @escaping(_ response: Any)->Void) {
        
        let baseURL = "https://www.reddit.com/top/.json"
        
        Alamofire.request(baseURL).responseJSON { (response) in
            
            guard let json = response.result.value else{
                return AppDebug.Log(title: "Error with service", info: response)
            }
            completationResponse(json)
        }
    }
}
