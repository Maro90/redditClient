//
//  RepositoryManager.swift
//  redditClient
//
//  Created by Mauro Gonzalez on 5/4/17.
//  Copyright © 2017 Mauro Gonzalez. All rights reserved.
//

import UIKit

protocol RepositoryManager {
    func getRedditTopList(completationResponse: @escaping(_ response: Any)->Void)
}
