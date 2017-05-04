//
//  RedditDataModel.swift
//  redditClient
//
//  Created by Mauro Gonzalez on 5/4/17.
//  Copyright © 2017 Mauro Gonzalez. All rights reserved.
//

import UIKit

class RedditDataModel: NSObject {
    
    var title : String!
    var author : String!
    var date : String!
    var thumbnail : String?
    var commentsCount = 0
    var subReddit : String!

    init(title: String, author: String, date: String, thumbnail: String?, commentsCount: Int, subReddit: String) {
        
        self.title = title
        self.author = author
        self.date = date
        self.thumbnail = thumbnail
        self.commentsCount = commentsCount
        self.subReddit = subReddit
    }

}
