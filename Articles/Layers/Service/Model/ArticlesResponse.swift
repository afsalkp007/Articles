//
//  ArticlesResponse.swift
//  Articles
//
//  Created by Afsal Mohammed on 3/9/22
//

import Foundation

struct ArticlesResponse {
  var articles: [Article]?
}

extension ArticlesResponse: Codable {
  enum CodingKeys: String, CodingKey {
    case articles = "results"
  }
  
  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    articles = try container.decodeValueIfPresent(forKey: .articles)
  }
  
  func encode(to encoder: Encoder) throws {
    var container = encoder.container(keyedBy: CodingKeys.self)
    try container.encode(articles, forKey: .articles)
  }
  
  static func make(data: Data) -> ArticlesResponse? {
    return try? JSONDecoder().decode(ArticlesResponse.self, from: data)
  }
}
