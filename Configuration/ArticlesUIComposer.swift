//
//  ArticlesViewCoordinator.swift
//  Articles
//
//  Created by Afsal Mohammed on 3/9/22.
//

import UIKit

final class ArticlesUIComposer {
  private init() {}
  
  static func composedWith(
    loader: ArticlesLoader,
    selection: @escaping (ArticleImage) -> Void
  ) ->  ArticlesViewController {
    let storyboard = UIStoryboard.articles
    let controller = storyboard.instantiateInitialViewController { coder in
      return ArticlesViewController(coder: coder, loader: loader)
    }
    
    controller?.selection = selection
    controller?.title = "Articles"
    return controller!
  }
}
