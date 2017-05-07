//
//  RedditCell.swift
//  redditClient
//
//  Created by Mauro Gonzalez on 5/6/17.
//  Copyright © 2017 Mauro Gonzalez. All rights reserved.
//

import UIKit

class RedditCell: UITableViewCell {

    @IBOutlet var titleLabel:       UILabel!
    @IBOutlet var authorLabel:      UILabel!
    @IBOutlet var dateLabel:        UILabel!
    @IBOutlet var imageThumbnail:   UIImageView!
    @IBOutlet var cantComments:     UILabel!
    @IBOutlet var subreddit:        UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func loadData(_ data: RedditDataModel){
        
        self.titleLabel.text = data.title
        self.authorLabel.text = data.author

        if let thumbnail = data.thumbnail{
            self.imageThumbnail.imageURL(thumbnail, placeholder: #imageLiteral(resourceName: "reddit"))
        }
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm"
        let stringDate = formatter.string(from: data.date)

        
        self.dateLabel.text = "\(stringDate)"
        
        self.cantComments.text = "Total Comments: \(data.commentsCount)"
        self.subreddit.text = data.subReddit
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
