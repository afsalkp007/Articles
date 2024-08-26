//
//  ArticlesDataService.swift
//  Articles
//
//  Created by Afsal Mohammed on 3/9/22
//

import Foundation

final class RemoteArticlesLoader: ArticlesLoader {
  private let client: HTTPClient
  
  typealias Result = ArticlesLoader.Result
  
  init(client: HTTPClient) {
    self.client = client
  }
  
  private enum Error: Swift.Error {
    case invalidData
  }
  
  func fetchArticles(with resource: Resource, _ completion: @escaping (Result) -> Void) {
    client.get(from: resource) { result in
      DispatchQueue.main.async {
        completion(result.map(ArticlesResponse.make))
      }
    }
  }
}
