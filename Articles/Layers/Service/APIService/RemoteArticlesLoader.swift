//
//  ArticlesDataService.swift
//  Articles
//
//  Created by Afsal Mohammed on 3/9/22
//

import Foundation

final class RemoteArticlesLoader: ArticlesLoader {
  private let client: HTTPClient
  
  init(client: HTTPClient) {
    self.client = client
  }
  
  private enum Error: Swift.Error {
    case invalidData
  }
  
  func fetchArticles(for period: Period, _ completion: @escaping (ArticlesLoader.Result) -> Void) {
    let resource = Resource(
      url: Constants.Urls.nytMostPopularUrl,
      path: "svc/mostpopular/v2/mostviewed/all-sections/\(period.rawValue).json",
      parameters: ["api-key": Constants.APIkey.nyt])
    _ = client.fetch(resource: resource) { result in
      DispatchQueue.main.async {
        completion(result.map(ArticlesResponse.make))
      }
    }
  }
}
