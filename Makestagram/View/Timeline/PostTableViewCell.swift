//
//  PostTableViewCell.swift
//  Makestagram
//
//  Created by Diego Urquiza on 6/29/15.
//  Copyright (c) 2015 Make School. All rights reserved.
//

import UIKit
import Bond

class PostTableViewCell: UITableViewCell {

  @IBOutlet weak var likeButton: UIButton!
  
  @IBOutlet weak var moreButton: UIButton!
  
  @IBOutlet weak var likesLabel: UILabel!
  
  @IBOutlet weak var likesIconImageView: UIImageView!
  
  @IBAction func likeButtonTapped(sender: AnyObject) {
  }
  @IBAction func moreButtonTapped(sender: AnyObject) {
  }
  
  
  var post:Post? {
    didSet {
      // 1 
      if let post = post {
        //2
        // bind the image of the post to the 'postImage view
        post.image ->> postImageView
      }
    }
  }
  
  @IBOutlet weak var postImageView: UIImageView!
  
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
