//
//  AppDelegate.swift
//  Meme
//
//  Created by Mauricio A Cabreira on 22/05/17.
//  Copyright © 2017 Mauricio A Cabreira. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
  
  var window: UIWindow?
  
  //Saved memes repository.
  var memes = [Meme]()
  
  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
    // Override point for customization after application launch.
    createMockupMemes()
    return true
  }
  
 
  func createMockupMemes() {
    
    let memesMockup = [
      Meme(topText: "Forget the movie", bottomText: "Let´s go to the gym", originalImage: UIImage(named: "test1"), memedImage: UIImage(named: "test1")),
      Meme(topText: "Finished my workout", bottomText: "Forgot my protein", originalImage: UIImage(named: "test2"), memedImage: UIImage(named: "test2")),
      Meme(topText: "Too much protein?", bottomText: "No whey", originalImage: UIImage(named: "test3"), memedImage: UIImage(named: "test3")),
      Meme(topText: "Love is in the air?", bottomText: "WRONG", originalImage: UIImage(named: "test4"), memedImage: UIImage(named: "test4")),
      Meme(topText: "I have no idea", bottomText: "what I´m doing", originalImage: UIImage(named: "test5"), memedImage: UIImage(named: "test5")),
     
    ]
    
    for meme in memesMockup {
      self.memes.append(meme)
    }

    
    
  }
  
}

