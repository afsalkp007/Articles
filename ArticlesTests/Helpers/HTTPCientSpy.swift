//
//  HTTPCientSpy.swift
//  ArticlesTests
//
//  Created by Afsal on 29/08/2024.
//

import Foundation
import Articles

class HTTPCientSpy: HTTPClient {
  var messages = [(resource: Resource, completion: (HTTPClient.Result) -> Void)]()
  
  var recievedURLs: [Resource] {
    messages.map(\.resource)
  }
  
  func get(from resource: Resource, completion: @escaping (HTTPClient.Result) -> Void) -> HTTPClientTask? {
    messages.append((resource, completion))
    return FakeURLSessionTask()
  }
  
  private struct FakeURLSessionTask: HTTPClientTask {
    func cancel() {}
  }
  
  func complete(with error: Error, at index: Int = 0) {
    messages[index].completion(.failure(error))
  }
  
  func complete(withStatusCode code: Int, data: Data, at index: Int = 0) {
    let response = HTTPURLResponse(
      url: recievedURLs[index].url,
      statusCode: code,
      httpVersion: nil,
      headerFields: nil)!
    messages[index].completion(.success((data, response)))
  }
}
