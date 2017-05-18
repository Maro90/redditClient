//
//  ListReddictItemsViewController.swift
//  redditClient
//
//  Created by Mauro Gonzalez on 5/6/17.
//  Copyright © 2017 Mauro Gonzalez. All rights reserved.
//

import UIKit

class ListReddictItemsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    var redditList = [RedditDataModel]()
    
    let domain = Domain(repository: RepositoryAlamofire(), parser: RedditParser())
    
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(ListReddictItemsViewController.refreshData(_:)), for: UIControlEvents.valueChanged)
        
        return refreshControl
    }()

    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView.addSubview(self.refreshControl)
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight = 60
        self.tableView.register(UINib(nibName: "RedditCell", bundle: nil), forCellReuseIdentifier: "redditCell")

        self.refreshData(nil)

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //------------------Refresh Data ----------------------------------//

    func refreshData(_ refreshControl: UIRefreshControl?) {
        self.refreshControl.beginRefreshing()
        
        
        domain.getRedditTopList() { (data) in
            
            guard data is [RedditDataModel] else {
                AppDebug.Log(title: "Wrong Model", info: data)
                return
            }
            
            self.redditList = data as! [RedditDataModel]
            self.tableView.reloadData()
            self.refreshControl.endRefreshing()
        }
    }

    
    //--------------TableViewDataSource Protocol----------------------//
    
    public func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return redditList.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "redditCell", for: indexPath) as! RedditCell
        
        // Configure the cell...
        cell.loadData(self.redditList[indexPath.row])
        
        return cell
    }
}

