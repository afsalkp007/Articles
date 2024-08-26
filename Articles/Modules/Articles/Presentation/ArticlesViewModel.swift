//
//  ArticlesViewModel.swift
//  Articles
//
//  Created by Afsal Mohammed on 3/9/22.
//

import Foundation

final class ArticlesViewModel {
  
  private let articlesService: ArticlesLoader
  private let resource: Resource
  
  init(articlesService: ArticlesLoader, resource: Resource) {
    self.articlesService = articlesService
    self.resource = resource
  }
  
  func getArticles(_ completion: @escaping (Result<[ArticleImage], Error>) -> Void) {
    articlesService.fetchArticles(with: resource) { result in
      switch result {
      case let .success(result):
        guard let articles = result?.articles else { return }
        completion(.success(articles.compactMap(ArticleImage.init)))
      case let .failure(error):
        completion(.failure(error))
      }
    }
  }
}
