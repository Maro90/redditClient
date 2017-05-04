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
        case RedditModelsWithOutData
        case RedditModelWithOutTitle
        case RedditModelWithOutId
        case RedditModelWithOutDescription
        case RedditModelWithOutPrice
        case RedditModelWithOutDisplayPrice
    }
    
    
    public static func convert(responseBody : AnyObject?) throws -> [RedditDataModel]{
        var redditList = [RedditDataModel]()
        
        if responseBody == nil {
            throw AppDebug.Throw(info: "Response body is null", error:RedditModelParserError.RedditModelsWithOutData)
        }
        
        if let body = responseBody as? Dictionary<String, AnyObject> {
            if let data = body["data"] as? [Dictionary<String, AnyObject>] {
                if data.count == 0 {
                    throw AppDebug.Throw(info: "error array empty", error:RedditModelParserError.RedditModelsWithOutData)
                }
                
                for object in data {
                    do {
                        let RedditModel = try self.createRedditDataModel(data: object)
                        if RedditModel != nil {
                            redditList.append(RedditModel!)
                        }
                    } catch {
//                        AppDebug.Log(title: object, info: "Exception Block")
                    }
                }
                
            } else {
                throw AppDebug.Throw(info: "RedditModels List error", error:RedditModelParserError.RedditModelsWithOutData)
            }
        } else {
            throw AppDebug.Throw(info: "Object not valid", error:RedditModelParserError.RedditModelsWithOutData)
            
        }
        
        if redditList.count == 0 {
            throw AppDebug.Throw(info: "RedditModel List is empty", error:RedditModelParserError.RedditModelsWithOutData)
            
        }
        
        return redditList
    }
    
    
    public static func createRedditDataModel( data : Dictionary<String, AnyObject>) throws -> RedditDataModel? {
        if let title = data["title"] as? String {
            
            if let id = data["id"] as? NSNumber {
                
                if let info = data["description"] as? String {
                    
                    if let price = data["price"] as? Dictionary<String, AnyObject> {
                        
                        if let priceValue = price["displayPrice"] as? String{
                            
                            return RedditDataModel()
                            
                        } else {
                            throw AppDebug.Throw(info: "RedditModel without value of price", error:RedditModelParserError.RedditModelWithOutDisplayPrice)
                        }
                        
                    } else {
                        throw AppDebug.Throw(info: "RedditModel without Price", error:RedditModelParserError.RedditModelWithOutPrice)
                    }
                    
                } else {
                    throw AppDebug.Throw(info: "RedditModel without Description", error:RedditModelParserError.RedditModelWithOutDescription)
                }
                
            } else {
                throw AppDebug.Throw(info: "RedditModel without Id", error:RedditModelParserError.RedditModelWithOutId)
            }
            
        } else {
            throw AppDebug.Throw(info: "RedditModel without title", error:RedditModelParserError.RedditModelWithOutTitle)
        }        
    }
}
