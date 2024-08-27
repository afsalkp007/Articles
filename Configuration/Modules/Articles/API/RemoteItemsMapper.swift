//
//  RemoteItemsMapper.swift
//  Articles
//
//  Created by Afsal on 27/08/2024.
//

import Foundation

final class RemoteItemsMapper {
  static func map(_ data: Data, _ response: HTTPURLResponse) throws -> [ArticleImage] {
    guard let result = try? JSONDecoder().decode(Articles.self, from: data), response.isOK else {
      throw RemoteArticlesLoader.Error.invalidData
    }
    
    return result.results.toModels()
  }
}

private struct Articles: Decodable {
  let results: [RemoteArticleItem]
}

private struct RemoteArticleItem: Decodable {
  let title: String
  let byline: String
  let updated: String
  let abstract: String
  let media: [Media]
  
  var url: String { media.first?.metadata.first?.url ?? "" }
}

private struct Media: Decodable {
  let metadata: [MetaData]
  
  enum CodingKeys: String, CodingKey {
    case metadata = "media-metadata"
  }
  
  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    metadata = try container.decodeValue(forKey: .metadata)
  }
}

private struct MetaData: Decodable {
  let url: String?
}

extension Array where Element == RemoteArticleItem {
  func toModels() -> [ArticleImage] {
    map { ArticleImage(title: $0.title, author: $0.byline, date: $0.updated, description: $0.abstract, url: URL(string: $0.url)) }
  }
}

