//
//  RemoteImageLoader.swift
//  Articles
//
//  Created by Afsal on 30/08/2024.
//

import Foundation

final class RemoteImageLoader: ImageLoader {
  private let url: URL
  private let client: HTTPClient
  
  private enum Error: Swift.Error {
    case connectivity
  }
  
  init(url: URL, client: HTTPClient) {
    self.url = url
    self.client = client
  }
  
  func loadImageData(completion: @escaping (ImageLoader.Result) -> Void) {
    client.get(from: Resource(url: url)) { result in
      switch result {
      case let .success((data, _)):
        completion(.success(data))
        
      case .failure:
        completion(.failure(Error.connectivity))
      }
    }
  }
}
