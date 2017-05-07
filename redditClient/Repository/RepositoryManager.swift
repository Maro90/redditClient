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

    static func getRedditTopList(completationResponse: @escaping(_ response: [RedditDataModel])->Void) {
        
        let baseURL = "https://www.reddit.com/top/.json"
        
        Alamofire.request(baseURL).responseJSON { (response) in
            
            if let json = response.result.value{
                
                let itemList : [RedditDataModel]

                do{
                    itemList = try RedditParser.convert(responseBody: json as AnyObject)
                }
                catch{
                    itemList = [RedditDataModel]()
                }
                
                completationResponse(itemList)

                
            } else {
                AppDebug.Log(title: "Error with the top list", info: response)
            }
        }
        
    }
}
