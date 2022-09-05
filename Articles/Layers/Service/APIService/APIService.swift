//
//  ArticlesDataService.swift
//  Articles
//
//  Created by Afsal Mohammed on 3/9/22
//

import Foundation

enum Result<T> {
  case success(T)
  case failure(Error)
}

final class APIService: APIServiceProtocol {
  private let networking: Networking
  
  init(networking: Networking = NetworkService()) {
    self.networking = networking
  }
  
  /// Fetch articles data
  /// - Parameter completion: Called when operation finishes
  func fetchArticles(for period: Period, _ completion: @escaping (Result<ArticlesResponse?>) -> Void) {
    let resource = Resource(
      url: Constants.Urls.nytMostPopularUrl,
      path: "svc/mostpopular/v2/mostviewed/all-sections/\(period.rawValue).json",
      parameters: ["api-key": Constants.APIkey.nyt])
    _ = networking.fetch(resource: resource, completion: { data in
      DispatchQueue.main.async {
        completion(.success(data.flatMap({ ArticlesResponse.make(data: $0) }) ))
      }
    })
  }
}
