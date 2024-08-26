//
//  ArticlesResponse.swift
//  Articles
//
//  Created by Afsal Mohammed on 3/9/22
//

import Foundation

struct ArticlesResponse: Decodable {
  var articles: [RemoteArticleImage]
  
  var images: [ArticleImage] {
    return articles.map(\.image)
  }
  
  enum CodingKeys: String, CodingKey {
    case articles = "results"
  }
  
  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    articles = try container.decodeValue(forKey: .articles)
  }
  
  struct RemoteArticleImage: Decodable {
    var title: String
    var author: String
    var date: String
    var description: String
    var media: [Media]
    
    var image: ArticleImage {
      return ArticleImage(title: title, author: author, date: date, description: description, imageUrl: URL(string: media.first?.url ?? ""))
    }
    
    enum CodingKeys: String, CodingKey {
      case title
      case author = "byline"
      case date = "updated"
      case desc = "abstract"
      case media
    }

    init(from decoder: Decoder) throws {
      let container = try decoder.container(keyedBy: CodingKeys.self)
      title = try container.decodeValue(forKey: .title)
      author = try container.decodeValue(forKey: .author)
      date = try container.decodeValue(forKey: .date)
      description = try container.decodeValue(forKey: .desc)
      media = try container.decodeValue(forKey: .media)
    }
    
    struct Media: Decodable {
      var metadata: [MetaData]
      
      var url: String? {
        metadata.first?.imageUrl
      }
       
      enum CodingKeys: String, CodingKey {
        case metadata = "media-metadata"
      }
      
      init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        metadata = try container.decodeValue(forKey: .metadata)
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
  }

}
