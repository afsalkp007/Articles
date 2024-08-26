//
//  ArticlesResponse.swift
//  Articles
//
//  Created by Afsal Mohammed on 3/9/22
//

import Foundation

struct ArticlesResponse: Decodable {
  var articles: [Article]?
  
  enum CodingKeys: String, CodingKey {
    case articles = "results"
  }
  
  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    articles = try container.decodeValueIfPresent(forKey: .articles)
  }
}
