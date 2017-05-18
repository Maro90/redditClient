//
//  Parser.swift
//  redditClient
//
//  Created by Mauro Gonzalez on 5/18/17.
//  Copyright © 2017 Mauro Gonzalez. All rights reserved.
//

import Foundation

protocol Parser {
    func convert(responseBody : AnyObject?) throws -> [AnyObject]
}
