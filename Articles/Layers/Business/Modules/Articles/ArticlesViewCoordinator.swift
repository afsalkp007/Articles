//
//  ArticlesViewCoordinator.swift
//  Articles
//
//  Created by Afsal Mohammed on 3/9/22.
//

import UIKit

final class ArticlesViewCoordinator: Coordinator {
  var navigationController: UINavigationController
  
  init(navigationController: UINavigationController) {
    self.navigationController = navigationController
  }
  
  func start() {
    let vc = ArticlesViewController.instantiate()
    vc.coordinator = ArticlesDetailCoordinator(navigationController: navigationController)
    vc.viewModel = ArticlesViewModel()
    navigationController.pushViewController(vc, animated: false)
  }
}
