//
//  MemeMeStruct.swift
//  Meme
//
//  Created by Mauricio A Cabreira on 24/05/17.
//  Copyright © 2017 Mauricio A Cabreira. All rights reserved.
//

import Foundation
import UIKit

struct Meme {
  var topText: String!
  var bottomText: String!
  var originalImage: UIImage!
  var memedImage: UIImage!
  
  //static let MemedImage = "MemedImage"
  
  // MARK: Initializer
  
  // Generate a Meme from a four entry dictionary
  
  /*
  init(dictionary: [String : String]) {
    
    
    self.topText = ""
    self.bottomText = ""
    self.memedImage = UIImage(named: dictionary[Meme.MemedImage]!)!
    self.originalImage = UIImage(named: dictionary[Meme.MemedImage]!)!
    
  }
 */
  
  
}

enum ImageSource: Int {
  case camera = 0, photoLibrary
}

enum Field: Int {
  case topField = 0, bottomField
}

/*
extension Meme {
  
  // Generate an array full of all of the memes in
  static var allMemes: [Meme] {
    
    var memeArray = [Meme]()
    
    for d in Meme.localMemeData() {
      memeArray.append(Meme(dictionary: d))
    }
    
    return memeArray
  }
  
  static func localMemeData() -> [[String : String]] {
    return [
      [Meme.MemedImage : "test1"],
      [Meme.MemedImage : "test2"],
      [Meme.MemedImage : "test3"]
 
    ]
  }
}

 */
