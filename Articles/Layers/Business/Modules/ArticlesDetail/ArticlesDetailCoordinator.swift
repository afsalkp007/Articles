//
//  ArticlesDetailCoordinator.swift
//  Articles
//
//  Created by Afsal Mohammed on 3/9/22
//

import UIKit

final class ArticlesDetailCoordinator: Coordinator {
  
  var navigationController: UINavigationController
  
  init(navigationController: UINavigationController) {
    self.navigationController = navigationController
  }
  
  func start(_ model: ArticlesCellViewModel) {
    let vc = ArticlesDetailViewController.instantiate()
    vc.viewModel = ArticlesDetailViewModel(cellViewModel: model)
    navigationController.pushViewController(vc, animated: true)
  }
}
