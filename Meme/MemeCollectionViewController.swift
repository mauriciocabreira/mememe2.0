//
//  MemeCollectionViewController.swift
//  Meme
//
//  Created by Mauricio A Cabreira on 03/06/17.
//  Copyright © 2017 Mauricio A Cabreira. All rights reserved.
//
import Foundation
import UIKit

// MARK: - VillainCollectionViewController: UICollectionViewController

class MemeCollectionViewController: UICollectionViewController {
  
  // MARK: Properties
  
  @IBOutlet weak var flowLayout: UICollectionViewFlowLayout!
  
  
  // MARK: Life Cycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    let space:CGFloat = 3.0
    let wDimension = (view.frame.size.width - (2 * space)) / 3.0
    let hDimension = (view.frame.size.height - (2 * space)) / 3.0
    
    flowLayout.minimumInteritemSpacing = space
    flowLayout.minimumLineSpacing = space
    flowLayout.itemSize = CGSize(width: wDimension, height: hDimension)
    
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    tabBarController?.tabBar.isHidden = false
    
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(true)
    collectionView?.reloadData()
    
  }

  
  // MARK: Collection View Data Source
  
  override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    return appDelegate.memes.count
 
    //return memes.count
    
  }
  
  override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MemeCollectionViewCell", for: indexPath) as! MemeCollectionViewCell
    
     let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let meme = appDelegate.memes[(indexPath as NSIndexPath).row]
    cell.memeImageView.image = meme.memedImage
       
    return cell
  }
  
  override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath:IndexPath) {
    
    let detailController = self.storyboard!.instantiateViewController(withIdentifier: "MemeViewerViewController") as! MemeViewerViewController
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    detailController.memeImage = appDelegate.memes[(indexPath as NSIndexPath).row].memedImage
    
    self.navigationController!.pushViewController(detailController, animated: true)
    
  }
  
}
