//
//  MetaData.swift
//  Articles
//
//  Created by Afsal on 04/09/2022.
//

import Foundation

struct MetaData {
  var imageUrl: String?
}

extension MetaData: Codable {
  enum CodingKeys: String, CodingKey {
    case imageUrl = "url"
  }
  
  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    imageUrl = try container.decodeValueIfPresent(forKey: .imageUrl)
  }
}
