//
//  RemoteItemsMapper.swift
//  Articles
//
//  Created by Afsal on 27/08/2024.
//

import Foundation

public final class RemoteItemsMapper {
  public static func map(_ data: Data, _ response: HTTPURLResponse) throws -> [ArticleImage] {
    let decoder = JSONDecoder()
    decoder.dateDecodingStrategy = decodeDate(with: "yyyy-MM-d H:mm:ss")

    let result = try decoder.decode(ArticlesResponse.self, from: data)
    return result.results.toModels()
  }
  
  private static func decodeDate(with format: String) -> JSONDecoder.DateDecodingStrategy {
    let formatter = DateFormatter()
    formatter.dateFormat = format
    formatter.timeZone = TimeZone(secondsFromGMT: 0)
    return .formatted(formatter)
  }
}

private struct ArticlesResponse: Decodable {
  let results: [RemoteArticleItem]
  
  enum CodingKeys: CodingKey {
    case results
  }
  
  init(from decoder: any Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    results = try container.decode([RemoteArticleItem].self, forKey: .results)
  }
}

private struct RemoteArticleItem: Decodable {
  let title: String
  let byline: String
  let updated: Date
  let abstract: String
  let media: [Media]
  
  var url: String { media.first?.metadata.first?.url ?? "" }
  
  enum CodingKeys: String, CodingKey {
    case title
    case byline
    case updated
    case abstract
    case media
  }
  
  init(from decoder: any Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    title = try container.decode(String.self, forKey: .title)
    byline = try container.decode(String.self, forKey: .byline)
    updated = try container.decode(Date.self, forKey: .updated)
    abstract = try container.decode(String.self, forKey: .abstract)
    media = try container.decode([Media].self, forKey: .media)
  }
}

private struct Media: Decodable {
  let metadata: [MetaData]
  
  enum CodingKeys: String, CodingKey {
    case metadata = "media-metadata"
  }
  
  init(from decoder: any Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    metadata = try container.decode([MetaData].self, forKey: .metadata)
  }
}

private struct MetaData: Decodable {
  let url: String?
  
  enum CodingKeys: String, CodingKey {
    case url
  }
  
  init(from decoder: any Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    url = try container.decodeIfPresent(String.self, forKey: .url)
  }
}

extension Array where Element == RemoteArticleItem {
  func toModels() -> [ArticleImage] {
    map { ArticleImage(title: $0.title, author: $0.byline, date: $0.updated, description: $0.abstract, url: URL(string: $0.url)) }
  }
}

