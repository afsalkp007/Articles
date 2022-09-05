//
//  Media.swift
//  Articles
//
//  Created by Afsal on 04/09/2022.
//

import Foundation

struct Media {
  var metadata: [MetaData]?
}

extension Media: Codable {
  enum CodingKeys: String, CodingKey {
    case metadata = "media-metadata"
  }
  
  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    metadata = try container.decodeValueIfPresent(forKey: .metadata)
  }
}
