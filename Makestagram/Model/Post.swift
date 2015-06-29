//
//  Post.swift
//  Makestagram
//
//  Created by Diego Urquiza on 6/27/15.
//  Copyright (c) 2015 Make School. All rights reserved.
//

import Foundation
import Parse
import Bond
// 1 
class Post : PFObject, PFSubclassing {
  
  //2
  @NSManaged var imageFile: PFFile?
  @NSManaged var user: PFUser?
  
  var image: Dynamic<UIImage?> = Dynamic(nil)
  var photoUploadTask: UIBackgroundTaskIdentifier?
  
  func uploadPost() {
    //1
    let imageData = UIImageJPEGRepresentation(image.value, 0.8)
    let imageFile = PFFile(data: imageData)
    
    // 1 
    photoUploadTask = UIApplication.sharedApplication().beginBackgroundTaskWithExpirationHandler({ () -> Void in
      UIApplication.sharedApplication().endBackgroundTask(self.photoUploadTask!)
    })
    
    imageFile.saveInBackgroundWithBlock { (success:Bool, error:NSError?) -> Void in
      UIApplication.sharedApplication().endBackgroundTask(self.photoUploadTask!)
    }
    //2
    self.imageFile = imageFile
    user = PFUser.currentUser()
    saveInBackgroundWithBlock(nil)
  
  }
  
  func downloadImage() {
    // if image is not downloaded yet, het it 
    // 1 
    if (image.value == nil){
      // 2 
      imageFile?.getDataInBackgroundWithBlock({ (data, error) -> Void in
        if let data = data {
          let image = UIImage(data: data, scale:1.0)!
          // 3 
          self.image.value = image
        }
      })
    }
    
  }
  
  //MARK: PFSublassing Protocol 
  
  // 3
  static func parseClassName() -> String{
    return "Post"
  }
  
  //4 
  override init() {
    super.init()
  }
  
  override class func initialize() {
    var onceToken : dispatch_once_t = 0;
    dispatch_once(&onceToken) {
      // inform Parse about this subclass
      self.registerSubclass()
    }
  }
  
}
