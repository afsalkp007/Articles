//
//  ArticlesViewModel.swift
//  Articles
//
//  Created by Afsal Mohammed on 3/9/22.
//

import Foundation

final class ArticlesViewModel {
  
  private let articlesService: ArticlesLoader
  
  init(articlesService: ArticlesLoader) {
    self.articlesService = articlesService
  }
  
  func getArticles(_ completion: @escaping (Result<[ArticlesCellViewModel], Error>) -> Void) {
    articlesService.fetchArticles(for: .week) { result in
      switch result {
      case let .success(result):
        guard let articles = result?.articles else { return }
        completion(.success(articles.compactMap(ArticlesCellViewModel.init)))
      case let .failure(error):
        completion(.failure(error))
      }
    }
  }
}
