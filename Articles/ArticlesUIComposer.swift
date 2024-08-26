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
    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    let vc = storyboard.instantiateInitialViewController() as! ArticlesViewController
    let client = URLSessionHTTPClient(session: URLSession(configuration: .ephemeral))
    let loader = MainQueueDispatchDecorator(
      decoratee: RemoteArticlesLoader(client: client))
    
    vc.viewModel = ArticlesViewModel(articlesService: loader, resource: resource)
    vc.selection = selection
    return vc
  }
}

private final class MainQueueDispatchDecorator: ArticlesLoader {
  private let decoratee: ArticlesLoader
  
  init(decoratee: ArticlesLoader) {
    self.decoratee = decoratee
  }
  
  func fetchArticles(with resource: Resource, _ completion: @escaping (ArticlesLoader.Result) -> Void) {
    decoratee.fetchArticles(with: resource) { result in
      if Thread.isMainThread {
        completion(result)
      } else {
        DispatchQueue.main.async {
          completion(result)
        }
      }
    }
  }
}
