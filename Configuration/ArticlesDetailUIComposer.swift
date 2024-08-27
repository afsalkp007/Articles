//
//  ArticlesDetailCoordinator.swift
//  Articles
//
//  Created by Afsal Mohammed on 3/9/22
//

import UIKit

public final class ArticlesDetailUIComposer {
  private init() {}
  
  static func composedWith(_ model: ArticleImage) -> ArticlesDetailViewController {
    let storyboard = UIStoryboard.detail
    let vc = storyboard.instantiateInitialViewController() as! ArticlesDetailViewController
    vc.viewModel = ArticlesDetailViewModel(cellViewModel: model)
    return vc
  }
}

