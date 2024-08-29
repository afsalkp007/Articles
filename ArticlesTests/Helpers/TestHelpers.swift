//
//  TestHelpers.swift
//  ArticlesTests
//
//  Created by Afsal on 29/08/2024.
//

import Foundation

func anyURL() -> URL {
  return URL(string: "http://any-url.com")!
}

func anyNSError() -> NSError {
  return NSError(domain: "any error", code: 0)
}

extension HTTPURLResponse {
  convenience init(statusCode code: Int) {
    self.init(
      url: anyURL(),
      statusCode: code,
      httpVersion: nil,
      headerFields: nil)!
  }
}

func makeItemJSON(items: [[String: Any]]) -> Data {
  let json = ["results": items]
  return try! JSONSerialization.data(withJSONObject: json)
}
  

