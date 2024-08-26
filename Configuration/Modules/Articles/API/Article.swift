//
//  Article.swift
//  Articles
//
//  Created by Afsal Mohammed on 3/9/22
//

import Foundation

struct Article: Decodable {
  var title: String
  var author: String
  var date: String?
  var desc: String?
  var media: [Media]?
  
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
}

struct Media: Decodable {
  var metadata: [MetaData]?
   
  enum CodingKeys: String, CodingKey {
    case metadata = "media-metadata"
  }
  
  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    metadata = try container.decodeValueIfPresent(forKey: .metadata)
  }
}

struct MetaData: Decodable {
  var imageUrl: String?
  
  enum CodingKeys: String, CodingKey {
    case imageUrl = "url"
  }
  
  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    imageUrl = try container.decodeValueIfPresent(forKey: .imageUrl)
  }
}


