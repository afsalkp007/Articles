//
//  HTTPClient.swift
//  Articles
//
//  Created by Afsal Mohammed on 3/9/22.
//

import Foundation

public protocol HTTPClientTask {
  func cancel()
}

public protocol HTTPClient {
  typealias Result = Swift.Result<(Data, HTTPURLResponse), Error>

  @discardableResult
  func get(from resource: Resource, completion: @escaping (Result) -> Void) -> HTTPClientTask?
}
