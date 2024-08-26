//
//  ArticlesDetailCoordinator.swift
//  Articles
//
//  Created by Afsal Mohammed on 3/9/22
//

import UIKit

public final class ArticlesDetailUIComposer {
  private init() {}
  
  static func composedWith(_ model: ArticlesCellViewModel) -> ArticlesDetailViewController {
    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    let vc = storyboard.instantiateViewController(withIdentifier: "ArticlesDetailViewController") as! ArticlesDetailViewController
    vc.viewModel = ArticlesDetailViewModel(cellViewModel: model)
    return vc
  }
}

