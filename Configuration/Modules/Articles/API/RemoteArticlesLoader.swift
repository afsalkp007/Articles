//
//  ArticlesDataService.swift
//  Articles
//
//  Created by Afsal Mohammed on 3/9/22
//

import Foundation

public final class RemoteArticlesLoader: ArticlesLoader {
  private let resource: Resource
  private let client: HTTPClient
  
  public typealias Result = ArticlesLoader.Result
  
  public init(resource: Resource, client: HTTPClient) {
    self.resource = resource
    self.client = client
  }
  
  public enum Error: Swift.Error {
    case connectivity
    case invalidData
  }
  
  public func fetchArticles(completion: @escaping (Result) -> Void) {
    client.get(from: resource) { result in
      
      switch result  {
      case let .success((data, response)):
        completion(Self.map(data, response))
      case .failure:
        completion(.failure(Error.connectivity))
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
