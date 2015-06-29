//
//  TimelineViewController.swift
//  Makestagram
//
//  Created by Diego Urquiza on 6/26/15.
//  Copyright (c) 2015 Make School. All rights reserved.
//

import UIKit
import Parse

class TimelineViewController: UIViewController {

  var photoTakingHelper: PhotoTakingHelper?
  var posts: [Post] = []
  
  
  @IBOutlet weak var tableView: UITableView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.
    self.tabBarController?.delegate = self
  
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  override func viewDidAppear(animated: Bool) {
    super.viewDidAppear(animated)
    
        ParseHelper.timelineRequestforCurrentUser{
          (result: [AnyObject]?, error:NSError?) -> Void in
            // 8
            self.posts = result as? [Post] ?? []
      
            self.tableView.reloadData()
      
        }
    
  }
  
  func takePhoto() {
    // instantiate photo taking class, provide callback for when photo  is selected
    photoTakingHelper = PhotoTakingHelper(viewController: self.tabBarController!) { (image: UIImage?) in
      println("received a callback")
      
      let post = Post()
      post.image.value = image!
      post.uploadPost()
    }
  }
  
  
}

// MARK: Tab Bar Delegate
extension TimelineViewController : UITabBarControllerDelegate {
  
  func tabBarController(tabBarController: UITabBarController, shouldSelectViewController viewController: UIViewController) -> Bool {
    
    if viewController is PhotoViewController {
      takePhoto()
      return false
    } else{
      return true
    }
  
  }
  
}

// MARK: Table data source
extension TimelineViewController: UITableViewDataSource {
  
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    //1
    return posts.count
  }
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    //2 
    let cell = tableView.dequeueReusableCellWithIdentifier("PostCell") as! PostTableViewCell
    
    let post = posts[indexPath.row]
    // 1 
    post.downloadImage()
    // 2 
    cell.post = post
    
    return cell
  }
  
}