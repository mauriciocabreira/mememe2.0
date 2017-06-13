//
//  ViewController.swift
//  MeMe
//
//  Created by Mauricio A Cabreira on 22/05/17.
//  Copyright © 2017 Mauricio A Cabreira. All rights reserved.
//
import UIKit




class MemeEditorViewController: UIViewController, UINavigationControllerDelegate {
  
  // MARK: Properties
  
  var clearTopField = true
  var clearBottomField = true
  
  
  let memeTextAttributes:[String:Any] = [
    NSStrokeColorAttributeName: UIColor.black,
    NSForegroundColorAttributeName: UIColor.white,
    NSFontAttributeName: UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
    NSStrokeWidthAttributeName: -3]
  
  
  
  // MARK: Outlets
  
  @IBOutlet weak var topText: UITextField!
  @IBOutlet weak var bottomText: UITextField!
  @IBOutlet weak var rawImage: UIImageView!
  @IBOutlet weak var cameraButton: UIBarButtonItem!
  @IBOutlet weak var navigationBar: UINavigationBar!
  @IBOutlet weak var toolBar: UIToolbar!
  @IBOutlet weak var shareButton: UIBarButtonItem!
  
  
  // MARK: ViewController Events
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    //Setting delegates
    topText.delegate = self
    bottomText.delegate = self
    
    //Put app into initial status
    resetStatus()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    subscribeToKeyboardNotifications()
    
    cameraButton.isEnabled = UIImagePickerController.isSourceTypeAvailable(.camera)
    
    //This line shows the tool and nav bars of this VC...
    displayToolbar(true)
    
    //toolBar.isHidden = false
    
    //navigationBar.isHidden = false
    
    //This hide the VC bars that invoked this VC
    tabBarController?.tabBar.isHidden = true
    navigationController?.isNavigationBarHidden = true
    
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    
    super.viewWillDisappear(animated)
    unsubscribeFromKeyboardNotifications()
    
    //These both lines shws the NavBar of the VC who invoked this one
    //self.tabBarController?.tabBar.isHidden = false
    navigationController?.isNavigationBarHidden = false
  }
  
 
  
  // MARK: Actions
  
  //User hit cancel, return to original state: no image, default text.
  @IBAction func cancelMeme(_ sender: Any) {
    
    //Put app into initial status
    resetStatus()
    let controller = self.navigationController!.viewControllers[0]
    let _ = self.navigationController?.popToViewController(controller, animated: true)
 }
 
 
 
  @IBAction func exportMeme(_ sender: Any) {
    
    // Create the meme
    let memedImage = generateMemedImage()
    let meme = Meme(topText: topText.text!, bottomText: bottomText.text!, originalImage: rawImage.image!, memedImage: memedImage)
    let controller = UIActivityViewController(activityItems: [meme.memedImage], applicationActivities: nil)
    self.present(controller, animated: true, completion: nil)
    
    controller.completionWithItemsHandler = {
      (activityType, complete, returnedItems, activityError ) in
      
      if complete {
        self.save(meme)
        self.dismiss(animated: true, completion: nil)
        self.resetStatus()
        let controller = self.navigationController!.viewControllers[0]
        let _ = self.navigationController?.popToViewController(controller, animated: true)

        
      }
    }
    
  }
  
  
  @IBAction func pickAnImageFromAlbum(_ sender: Any) {
    pickAnImageFrom(.photoLibrary)
  }
  
  @IBAction func pickAnImageFromCamera(_ sender: Any) {
    pickAnImageFrom(.camera)
  }
  
  
  
  // MARK: Subscription functions
  
  //Keyboard notifications (un)subscription
  func subscribeToKeyboardNotifications() {
    
    //Keyboard will show subscription
    NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: .UIKeyboardWillShow, object: nil)
    
    //Keyboard will show subscription
    NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: .UIKeyboardWillHide, object: nil)
    
  }
  
  func unsubscribeFromKeyboardNotifications() {
    
    //Keyboard will show unsubscription
    NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillShow, object: nil)
    
    //Keyboard will hide unsubscription
    NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillHide, object: nil)
  }
  
  
  // MARK: Auxiliar functions
  
  func resetStatus() {
    
    // Reset Labels to original state
    configureTextField(.topField, topText, "TOP")
    configureTextField(.bottomField, bottomText, "BOTTOM")
    
    //Disable share button
    shareButton.isEnabled = false
    
    //Clean image
    rawImage.image = nil
  }
  
  func keyboardWillShow(_ notification:Notification) {
    
    print("frame origin: \(view.frame.origin.y)")
    print("kb height: \(getKeyboardHeight(notification))")
    
      
    if bottomText.isFirstResponder {
      view.frame.origin.y = 0 - getKeyboardHeight(notification)
    }
    
    //Changes after reviewer review to not hide the TOP field on the iPhone 5s, landscape mode
    if topText.isFirstResponder {
      view.frame.origin.y = -15
    }
    
  }
  
  func keyboardWillHide(_ notification:Notification) {
    
    if bottomText.isFirstResponder || topText.isFirstResponder {
      view.frame.origin.y = 0
    }
  }
  
  func getKeyboardHeight(_ notification:Notification) -> CGFloat {
    
    let userInfo = notification.userInfo
    let keyboardSize = userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue // of CGRect
    return keyboardSize.cgRectValue.height
  }
  
  
  
  
  
  func generateMemedImage() -> UIImage {
    
    //Hide navigation and toolbars so they dont appear in the rendered image
    
    //Meme1.0 - hide bars to generate meme
    //self.navigationController?.setNavigationBarHidden(true, animated: true)
    //self.navigationController?.setToolbarHidden(true, animated: true)
    
    
    //Meme2.0 - hide bars to generate meme
    displayToolbar(false)
    
    
    // Render view to an image
    UIGraphicsBeginImageContext(self.view.frame.size)
    view.drawHierarchy(in: self.view.frame, afterScreenUpdates: true)
    let memedImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
    UIGraphicsEndImageContext()
    
    // Meme1.0 - put bars back
    //self.navigationController?.setNavigationBarHidden(false, animated: true)
    //self.navigationController?.setToolbarHidden(false, animated: true)
    
    //Meme2.0 - put bars back
    displayToolbar(true)
    
    return memedImage
  }
  
  func save(_ meme: Meme) {
     let appDelegate = UIApplication.shared.delegate as! AppDelegate
    appDelegate.memes.append(meme)
  }
  
  
  
}


//MARK: Image related functions

extension MemeEditorViewController: UIImagePickerControllerDelegate {
  
  func pickAnImageFrom(_ source: ImageSource) {
    
    let imagePicker = UIImagePickerController()
    imagePicker.delegate = self
    if source == ImageSource.camera {
      imagePicker.sourceType = .camera
    }
    present(imagePicker, animated: true, completion: nil)
    
  }
  
  func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
    
    if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
      rawImage.image = image
      rawImage.contentMode = UIViewContentMode.scaleAspectFit
      dismiss(animated: true, completion: nil)
      shareButton.isEnabled = true
    }
  }
  
  func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
    dismiss(animated: true, completion: nil)
    shareButton.isEnabled = false
    
  }
}


// MARK: UITextFieldDelegate delegates
extension MemeEditorViewController: UITextFieldDelegate {
  
  func textFieldDidBeginEditing(_ textField: UITextField) {
    
    
    if topText.isFirstResponder {
      
      //If field has the original text, clean it, otherwise keep the already edited text
      if clearTopField {
        clearTopField = false
        cleanTextField(textField)
      }
    }
    if bottomText.isFirstResponder {
      
      //If field has the original text, clean it, otherwise keep the already edited text
      if clearBottomField {
        clearBottomField = false
        cleanTextField(textField)
      }
    }
  }
  
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    
    //Dismiss the keyboard
    textField.resignFirstResponder()
    
    return true
  }
  
  
  func configureTextField(_ fieldPosition: Field, _ textField: UITextField, _ text: String) {
    textField.text = text
    
    switch fieldPosition {
    case .topField:
      topText.defaultTextAttributes = memeTextAttributes
      topText.textAlignment = .center
      clearTopField = true
      
    case .bottomField:
      bottomText.defaultTextAttributes = memeTextAttributes
      bottomText.textAlignment = .center
      clearBottomField = true
    }
  }
  
  func cleanTextField(_ textField: UITextField) {
    
    textField.text = ""
  }
  
  func displayToolbar(_ show: Bool){
    
    //changed after reviewer suggestion. Thanks :)
    toolBar.isHidden = !show
    navigationBar.isHidden = !show
    }

}

