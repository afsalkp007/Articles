//
//  ArticlesViewModel.swift
//  Articles
//
//  Created by Afsal Mohammed on 3/9/22.
//

import Foundation

final class ArticlesViewModel {
  
  let articlesService: APIServiceProtocol
  var updateUI: () -> Void = { }
  var title = ""
  
  var viewModels = [ArticlesCellViewModel]() {
    didSet {
      updateView()
      updateUI()
    }
  }
  
  init(
    articlesService: APIServiceProtocol = APIService()
  ) {
    self.articlesService = articlesService
    getArticles()
  }

  func getArticles() {
    articlesService.fetchArticles(for: .week) { [weak self] result in
      switch result {
      case .success(let results):
        guard let self = self, let articles = results?.articles else { return }
        self.viewModels = articles.compactMap(ArticlesCellViewModel.init)
      case .failure(let error):
        print(error.localizedDescription)
      }
    }
  }
  
  func updateView() {
    title = "Articles"
  }
  
  func modelFor(indexPath: IndexPath) -> ArticlesCellViewModel {
    return viewModels[indexPath.row]
  }
}
