//
//  Coordinator.swift
//  Articles
//
//  Created by Afsal Mohammed on 3/9/22
//

import Foundation
import UIKit

protocol Coordinator {
  var navigationController: UINavigationController { get set }
  func start()
  func start(_ model: ArticlesCellViewModel)
}

extension Coordinator {
  func start() { }
  func start(_ model: ArticlesCellViewModel) { }
}
