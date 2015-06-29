//
//  ParseHelper.swift
//  Makestagram
//
//  Created by Diego Urquiza on 6/29/15.
//  Copyright (c) 2015 Make School. All rights reserved.
//

import Foundation
import Parse

// 1 
class ParseHelper {
  
  // Following Relation
  static let ParseFollowClass       = "Follow"
  static let ParseFollowFromUser    = "fromUser"
  static let ParseFollowToUser      = "toUser"
  
  // Like Relation
  static let ParseLikeClass         = "Like"
  static let ParseLikeToPost        = "toPost"
  static let ParseLikeFromUser      = "fromUser"
  
  // Post Relation
  static let ParsePostUser          = "user"
  static let ParsePostCreatedAt     = "createdAt"
  
  // Flagged Content Relation
  static let ParseFlaggedContentClass    = "FlaggedContent"
  static let ParseFlaggedContentFromUser = "fromUser"
  static let ParseFlaggedContentToPost   = "toPost"
  
  // User Relation
  static let ParseUserUsername      = "username"
  
  class func timelineRequestforCurrentUser(completionBlock: PFArrayResultBlock) {
    let followingQuery = PFQuery(className: ParseFollowClass)
    followingQuery.whereKey(ParseFollowFromUser, equalTo:PFUser.currentUser()!)
    
    let postsFromFollowedUsers = Post.query()
    postsFromFollowedUsers!.whereKey(ParsePostUser, matchesKey: ParseFollowToUser, inQuery: followingQuery)
    
    let postsFromThisUser = Post.query()
    postsFromThisUser!.whereKey(ParsePostUser, equalTo: PFUser.currentUser()!)
    
    let query = PFQuery.orQueryWithSubqueries([postsFromFollowedUsers!, postsFromThisUser!])
    query.includeKey(ParsePostUser)
    query.orderByDescending(ParsePostCreatedAt )
    
    // 3
    query.findObjectsInBackgroundWithBlock(completionBlock)

  }
  
  static func likePost(user: PFUser, post: Post) {
    
    let likeObject = PFObject(className: ParseLikeClass)
    likeObject[ParseLikeToPost] = user
    likeObject[ParseLikeFromUser] = post
    
    likeObject.saveInBackgroundWithBlock(nil)
    
  }
  
}