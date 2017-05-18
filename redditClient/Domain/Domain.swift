//
//  Domain.swift
//  redditClient
//
//  Created by Mauro Gonzalez on 5/18/17.
//  Copyright © 2017 Mauro Gonzalez. All rights reserved.
//

import Foundation

class Domain{

    let dataSource : RepositoryManager
    let parser : Parser
    
    init(repository:RepositoryManager, parser:Parser) {
        self.dataSource = repository
        self.parser = parser
    }
    
    func getRedditTopList(completationResponse: @escaping(_ response: Any)->Void) {
        
        self.dataSource.getRedditTopList { (response) in
            do{
                let content = try self.parser.convert(responseBody: response as AnyObject)
                completationResponse(content)
            }
            catch{
                AppDebug.Log(title: "Error with the top list", info: response)
            }
        }
    }
}
