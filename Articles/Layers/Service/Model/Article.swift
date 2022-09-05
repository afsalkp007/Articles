//
//  Article.swift
//  Articles
//
//  Created by Afsal Mohammed on 3/9/22
//

import Foundation

struct Article {
  var title: String
  var author: String
  var date: String?
  var desc: String?
  var media: [Media]?
}

extension Article: Codable {
  enum CodingKeys: String, CodingKey {
    case title
    case author = "byline"
    case date = "published_date"
    case desc = "abstract"
    case media
  }

  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    title = try container.decodeValue(forKey: .title)
    author = try container.decodeValue(forKey: .author)
    date = try container.decodeValueIfPresent(forKey: .date)
    desc = try container.decodeValueIfPresent(forKey: .desc)
    media = try container.decodeValueIfPresent(forKey: .media)
  }

  func encode(to encoder: Encoder) throws {
    var container = encoder.container(keyedBy: CodingKeys.self)
    try container.encode(title, forKey: .title)
    try container.encode(author, forKey: .author)
    try container.encode(date, forKey: .date)
    try container.encode(desc, forKey: .desc)
    try container.encode(media, forKey: .media)
  }
}
