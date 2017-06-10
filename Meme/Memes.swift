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
  let topText: String!
  let bottomText: String!
  let originalImage: UIImage!
  let memedImage: UIImage!
  
}

enum ImageSource: Int {
  case camera = 0, photoLibrary
}

enum Field: Int {
  case topField = 0, bottomField
}
