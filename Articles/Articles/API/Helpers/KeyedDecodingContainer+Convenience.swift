//
//  KeyedDecodingContainer+Convenience.swift
//  Articles
//
//  Created by Afsal Mohammed on 3/9/22
//

import Foundation

extension KeyedDecodingContainer {
  func decodeValue<T: Decodable>(forKey key: Key) throws -> T {
    try decode(T.self, forKey: key)
  }

  func decodeValueIfPresent<T: Decodable>(forKey key: Key) throws -> T? {
    try decodeIfPresent(T.self, forKey: key)
  }
}
