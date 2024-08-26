//
//  ArticlesViewCoordinator.swift
//  Articles
//
//  Created by Afsal Mohammed on 3/9/22.
//

import UIKit

final class ArticlesUIComposer {
  private init() {}
  
  static func composed(with resource: Resource, selection: @escaping (ArticleImageViewModel) -> Void) ->  ArticlesViewController {
    let storyboard = UIStoryboard(name: "Articles", bundle: nil)
    let vc = storyboard.instantiateInitialViewController() as! ArticlesViewController
    let client = URLSessionHTTPClient(session: URLSession(configuration: .ephemeral))
    let loader = MainQueueDispatchDecorator(
      decoratee: RemoteArticlesLoader(client: client))
    
    vc.viewModel = ArticlesViewModel(articlesService: loader, resource: resource)
    vc.selection = selection
    return vc
  }
}
