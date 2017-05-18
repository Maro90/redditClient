//
//  RedditParser.swift
//  redditClient
//
//  Created by Mauro Gonzalez on 5/4/17.
//  Copyright © 2017 Mauro Gonzalez. All rights reserved.
//

import UIKit

class RedditParser: Parser{
    
    enum RedditModelParserError: Error {
        case RedditListInvalid
        case RedditListWithOutData
        case RedditListWithoutChildren
        case RedditListChildrenEmpthy
        case RedditListChildrenWithoutData
        case RedditListChildrenWithoutAnyValid
        
        case RedditModelWithoutTitle
        case RedditModelWithoutAuthor
        case RedditModelWithoutCreated
        case RedditModelWithoutNumComments
        case RedditModelWithoutSubreddit
    }
    
    
    public func convert(responseBody : AnyObject?) throws -> [AnyObject]{
        var redditList = [RedditDataModel]()
        
        guard let body = responseBody as? [String:AnyObject] else{
            throw AppDebug.Throw(info: "Response body is null", error:RedditModelParserError.RedditListInvalid)
        }
        
        guard let data = body["data"] as? [String: AnyObject] else {
            throw AppDebug.Throw(info: "RedditModels List error", error:RedditModelParserError.RedditListWithOutData)
        }
        
        guard let children = data["children"] as? [[String: AnyObject]] else{
            throw AppDebug.Throw(info: "RedditModels List error", error:RedditModelParserError.RedditListWithoutChildren)
        }
        
        if children.count == 0 {
            throw AppDebug.Throw(info: "error array empty", error:RedditModelParserError.RedditListChildrenEmpthy)
        }
                    
        for object in children {
            guard let childrenData = object["data"] as? [String:AnyObject] else {
                throw AppDebug.Throw(info: "RedditModels List error", error:RedditModelParserError.RedditListChildrenWithoutData)
            }
            do {
                let RedditModel = try self.createRedditDataModel(data: childrenData)
                if RedditModel != nil {
                    redditList.append(RedditModel!)
                }
            } catch {
                AppDebug.Log(title: "Exception Block", info: object)
            }
            
        }

        if redditList.count == 0 {
            throw AppDebug.Throw(info: "RedditModel List is empty", error:RedditModelParserError.RedditListChildrenWithoutAnyValid)
        }
        
        return redditList
    }
    
    
    public func createRedditDataModel( data : Dictionary<String, AnyObject>) throws -> RedditDataModel? {
        guard let title = data["title"] as? String else {
            throw AppDebug.Throw(info: "RedditModel without title", error:RedditModelParserError.RedditModelWithoutTitle)
        }
            
        guard let author = data["author"] as? String else {
            throw AppDebug.Throw(info: "RedditModel without author", error:RedditModelParserError.RedditModelWithoutAuthor)
        }
        
        guard let date = data["created"] as? NSNumber else {
            throw AppDebug.Throw(info: "RedditModel without Created", error:RedditModelParserError.RedditModelWithoutCreated)
        }
        
        guard let num_comments = data["num_comments"] as? Int else {
            throw AppDebug.Throw(info: "RedditModel without num_comments", error:RedditModelParserError.RedditModelWithoutNumComments)
        }
        guard let subreddit = data["subreddit_id"] as? String else {
            throw AppDebug.Throw(info: "RedditModel without subreddit_id", error:RedditModelParserError.RedditModelWithoutSubreddit)
        }
        
        //Could be null
        let thumbnail = data["thumbnail"] as? String
                            
        return RedditDataModel(title: title, author: author, date: date, thumbnail: thumbnail, commentsCount: num_comments, subReddit: subreddit)
        
    }
}
