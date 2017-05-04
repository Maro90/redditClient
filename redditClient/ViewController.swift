//
//  ViewController.swift
//  redditClient
//
//  Created by Mauro Gonzalez on 5/4/17.
//  Copyright © 2017 Mauro Gonzalez. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        RepositoryManager.getRedditTopList(baseURL: "https://www.reddit.com/top/.json") { (data, error) in
            
            print(data)
            
            
        }
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

