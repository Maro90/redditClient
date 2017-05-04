//
//  AppDebug.swift
//  redditClient
//
//  Created by Mauro Gonzalez on 5/4/17.
//  Copyright © 2017 Mauro Gonzalez. All rights reserved.
//

import Foundation

public class AppDebug {
    static let shouldDebugLog = true
    static let shouldDebugThrow = true
    
    public class func Log(title:String , info:Any) {
        if shouldDebugLog {
            print("👁 Log: \(title) --")
            print(info)
            print("-----------------------------------")
        }
    }
    
    public class func Throw(info: String, error: Error) -> Error {
        if shouldDebugThrow {
            print("⚠️ Exception: \(error) --")
            print(info)
            print("-----------------------------------")
        }
        return error
    }
}
