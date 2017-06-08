//
//  MemeViewController.swift
//  Meme
//
//  Created by Mauricio A Cabreira on 03/06/17.
//  Copyright © 2017 Mauricio A Cabreira. All rights reserved.
//

import UIKit

class MemeViewerViewController: UIViewController, UINavigationControllerDelegate {

  
  var memeImage: UIImage!
  
  // MARK: Outlets
  
  @IBOutlet weak var imageView: UIImageView!
   
  
  // MARK: Actions
  
  @IBAction func backToSentMemes(_ sender: Any) {
    let controller = self.navigationController!.viewControllers[0]
    let _ = self.navigationController?.popToViewController(controller, animated: true)

    
  }
  
  // MARK: Life Cycle
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    
    self.imageView!.image = memeImage
      
    //This hides Main ViewController tab bar
    //tabBarController?.tabBar.isHidden = true
    navigationController?.isNavigationBarHidden = true

    //These line works too same way as lines above. Just another way to call it.
    //navigationController?.setNavigationBarHidden(true, animated: true)
    //navigationController?.setToolbarHidden(true, animated: true)
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    
    //Any of these 2 lines show back the Navigation bar of the ViewController that called MemeViewerViewController
    navigationController?.isNavigationBarHidden = false
    //self.navigationController?.setNavigationBarHidden(false, animated: true)
   
  }

}
