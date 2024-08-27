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
  
  enum Error: Swift.Error {
    case invalidData
  }
  
  func fetchArticles(with resource: Resource, _ completion: @escaping (Result) -> Void) {
    client.get(from: resource) { result in
      
      switch result  {
      case let .success((data, response)):
        completion(Self.map(data, response))
      case .failure:
        completion(.failure(Error.invalidData))
      }
    }
  }
  
  private static func map(_ data: Data, _ response: HTTPURLResponse) -> Result {
    do {
      let items = try RemoteItemsMapper.map(data, response)
      return .success(items)
    } catch {
      return .failure(error)
    }
  }
}
