//
//  HTTPClient.swift
//  Articles
//
//  Created by Afsal Mohammed on 3/9/22.
//

import Foundation

protocol HTTPClientTask {
  func cancel()
}

protocol HTTPClient {
  typealias Result = Swift.Result<Data, Error>

  @discardableResult
  func get(from resource: Resource, completion: @escaping (Result) -> Void) -> HTTPClientTask?
}
