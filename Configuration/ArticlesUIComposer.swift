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
    resource: Resource,
    selection: @escaping (ArticleImage) -> Void
  ) ->  ArticlesViewController {
    let storyboard = UIStoryboard(name: "Articles", bundle: nil)
    let controller = storyboard.instantiateInitialViewController(creator: { coder in
      return ArticlesViewController(coder: coder, loader: loader, resource: resource)
    })
    
    controller?.selection = selection
    return controller!
  }
}

