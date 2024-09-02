//
//  URLSessionHTTPClient.swift
//  Articles
//
//  Created by Afsal Mohammed on 3/9/22.
//

import Foundation

public final class URLSessionHTTPClient: HTTPClient {
  private let session: URLSession
  
  public init(session: URLSession) {
    self.session = session
  }
  
  private struct UnexpectedError: Error {}
}
 
extension URLSessionHTTPClient {
  private struct URLSessionTaskWrapper: HTTPClientTask {
    let wrapper: URLSessionTask
    
    func cancel() {
      wrapper.cancel()
    }
  }
    
  public func get(from resource: Resource, completion: @escaping (HTTPClient.Result) -> Void) -> HTTPClientTask? {
    let request = makeRequest(resource: resource)
    let task = session.dataTask(with: request, completionHandler: { data, response, error in
      if let error = error {
        completion(.failure(error))
      } else if let data = data, let response = response as? HTTPURLResponse {
        completion(.success((data, response)))
      } else {
        completion(.failure(UnexpectedError()))
      }
    })
    
    task.resume()
    return URLSessionTaskWrapper(wrapper: task)
  }
  
  private func makeRequest(resource: Resource) -> URLRequest {
    let url = resource.path.map { resource.url.appendingPathComponent($0) } ?? resource.url
    var component = URLComponents(url: url, resolvingAgainstBaseURL: true)
    component?.queryItems = resource.parameters.map { URLQueryItem(name: $0, value: $1) }
        
    var request = URLRequest(url: component?.url ?? url)
    request.httpMethod = resource.httpMethod.rawValue
    request.allHTTPHeaderFields = resource.headers
    return request
  }
}
