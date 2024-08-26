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
    let configuration = URLSessionConfiguration.ephemeral
    let session = URLSession(configuration: configuration)
    let client = URLSessionHTTPClient(session: session)
    let apiservice = RemoteArticlesLoader(client: client)
    
    vc.viewModel = ArticlesViewModel(articlesService: apiservice, resource: resource)
    vc.selection = selection
    return vc
  }
}
