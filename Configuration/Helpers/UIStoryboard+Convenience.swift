//
//  UIStoryboard+Convenience.swift
//  Articles
//
//  Created by Afsal on 27/08/2024.
//

import UIKit

extension UIStoryboard {
  convenience init(name: String) {
    self.init(name: name, bundle: nil)
  }
  
  static var articles: UIStoryboard {
    UIStoryboard(name: "Articles")
  }
  
  static var detail: UIStoryboard {
    UIStoryboard(name: "Detail")
  }
}

