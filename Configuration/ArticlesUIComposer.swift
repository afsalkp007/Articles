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
    let storyboard = UIStoryboard(name: "Articles", bundle: nil)
    let vc = storyboard.instantiateInitialViewController() as! ArticlesViewController
    
    vc.viewModel = ArticlesViewModel(
      articlesService: loader,
      resource: resource(for: .week))
    vc.selection = selection
    return vc
  }
  
  private static func resource(for period: Period) -> Resource {
    Resource(
      url: Constants.Urls.nytMostPopularUrl,
      path: "svc/mostpopular/v2/mostviewed/all-sections/\(period.rawValue).json",
      parameters: ["api-key": Constants.APIkey.nyt])
  }
}

