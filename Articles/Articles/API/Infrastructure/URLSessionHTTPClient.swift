//
//  URLSessionHTTPClient.swift
//  Articles
//
//  Created by Afsal Mohammed on 3/9/22.
//

import Foundation

final class URLSessionHTTPClient: HTTPClient {
  private let session: URLSession
  
  init(session: URLSession) {
    self.session = session
  }
  
  private enum Error: Swift.Error {
    case makeRequestFailed
    case invalidData
  }
}
 
extension URLSessionHTTPClient {
  private struct URLSessionTaskWrapper: HTTPClientTask {
    let wrapper: URLSessionTask
    
    func cancel() {
      wrapper.cancel()
    }
  }
  
  func get(from resource: Resource, completion: @escaping (HTTPClient.Result) -> Void) -> HTTPClientTask? {
    guard let request = makeRequest(resource: resource) else {
      completion(.failure(Error.makeRequestFailed))
      return nil
    }
    
    let task = session.dataTask(with: request, completionHandler: { data, _, error in
      guard let data = data, error == nil else {
        completion(.failure(Error.invalidData))
        return
      }
      
      completion(.success(data))
    })
    
    task.resume()
    return URLSessionTaskWrapper(wrapper: task)
  }
  
  private func makeRequest(resource: Resource) -> URLRequest? {
    let url = resource.path.map({ resource.url.appendingPathComponent($0) }) ?? resource.url
    guard var component = URLComponents(url: url, resolvingAgainstBaseURL: true) else {
      assertionFailure()
      return nil
    }
    
    component.queryItems = resource.parameters.map({
      return URLQueryItem(name: $0, value: $1)
    })
    
    guard let resolvedUrl = component.url else {
      assertionFailure()
      return nil
    }
    
    var request = URLRequest(url: resolvedUrl)
    request.httpMethod = resource.httpMethod
    request.allHTTPHeaderFields = resource.headers
    return request
  }
}
