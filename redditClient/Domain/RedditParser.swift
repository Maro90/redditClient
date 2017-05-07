//
//  RedditParser.swift
//  redditClient
//
//  Created by Mauro Gonzalez on 5/4/17.
//  Copyright © 2017 Mauro Gonzalez. All rights reserved.
//

import UIKit

class RedditParser: NSObject {
    
    enum RedditModelParserError: Error {
        case RedditModelWithOutData
        case RedditListNull
        case RedditListEmpthy
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
    
    
    public static func convert(responseBody : AnyObject?) throws -> [RedditDataModel]{
        var redditList = [RedditDataModel]()
        
        if responseBody == nil {
            throw AppDebug.Throw(info: "Response body is null", error:RedditModelParserError.RedditListNull)
        }
        
        if let body = responseBody as? [String: AnyObject] {
            if let data = body["data"] as? [String: AnyObject] {
                if let children = data["children"] as? [[String: AnyObject]] {
                    
                    
                    if children.count == 0 {
                        throw AppDebug.Throw(info: "error array empty", error:RedditModelParserError.RedditListChildrenEmpthy)
                    }
                    
                    for object in children {
                        if let childrenData = object["data"] as? [String:AnyObject] {
                            do {
                                let RedditModel = try self.createRedditDataModel(data: childrenData)
                                if RedditModel != nil {
                                    redditList.append(RedditModel!)
                                }
                            } catch {
                                AppDebug.Log(title: "Exception Block", info: object)
                            }

                        }
                        else{
                            throw AppDebug.Throw(info: "RedditModels List error", error:RedditModelParserError.RedditListChildrenWithoutData)
                        }
                    }
                    
                } else {
                    throw AppDebug.Throw(info: "RedditModels List error", error:RedditModelParserError.RedditListWithoutChildren)
                }
            } else {
                throw AppDebug.Throw(info: "RedditModels List error", error:RedditModelParserError.RedditListWithOutData)
            }
        } else {
            throw AppDebug.Throw(info: "Object not valid", error:RedditModelParserError.RedditListEmpthy)
            
        }
        
        if redditList.count == 0 {
            throw AppDebug.Throw(info: "RedditModel List is empty", error:RedditModelParserError.RedditListChildrenWithoutAnyValid)
            
        }
        
        return redditList
    }
    
    
    public static func createRedditDataModel( data : Dictionary<String, AnyObject>) throws -> RedditDataModel? {
        if let title = data["title"] as? String {
            
            if let author = data["author"] as? String {
                
                if let date = data["created"] as? NSNumber {
                    
                    if let num_comments = data["num_comments"] as? Int {
                        
                        if let subreddit = data["subreddit_id"] as? String{
                            
                            
                            //Could be null
                            let thumbnail = data["thumbnail"] as? String
                            
                            return RedditDataModel(title: title, author: author, date: date, thumbnail: thumbnail, commentsCount: num_comments, subReddit: subreddit)
                            
                            
                        } else {
                            throw AppDebug.Throw(info: "RedditModel without subreddit_id", error:RedditModelParserError.RedditModelWithoutSubreddit)
                        }
                        
                    } else {
                        throw AppDebug.Throw(info: "RedditModel without num_comments", error:RedditModelParserError.RedditModelWithoutNumComments)
                    }
                    
                } else {
                    throw AppDebug.Throw(info: "RedditModel without Created", error:RedditModelParserError.RedditModelWithoutCreated)
                }
                
            } else {
                throw AppDebug.Throw(info: "RedditModel without author", error:RedditModelParserError.RedditModelWithoutAuthor)
            }
            
        } else {
            throw AppDebug.Throw(info: "RedditModel without title", error:RedditModelParserError.RedditModelWithoutTitle)
        }        
    }
}
