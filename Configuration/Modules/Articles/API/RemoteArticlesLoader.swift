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
      
      if case let .success((data, response)) = result {
        guard response.isOK else { return }
        
        do {
          let result = try JSONDecoder().decode(ArticlesResponse.self, from: data)
          completion(.success(result.images))
        } catch {
          completion(.failure(error))
        }
      }
    }
  }
}
