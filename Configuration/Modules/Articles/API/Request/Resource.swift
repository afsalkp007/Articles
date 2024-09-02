//
//  Resource.swift
//  Articles
//
//  Created by Afsal Mohammed on 3/9/22.
//

import Foundation

public struct Resource {
  public let url: URL
  public let path: String?
  public let httpMethod: HTTPMethod
  public let parameters: [String: String]
  public let headers: [String: String]
  
  public init(
    url: URL,
    path: String? = nil,
    httpMethod: HTTPMethod = .GET,
    parameters: [String: String] = [:],
    headers: [String: String] = [:]
  ) {
    self.url = url
    self.path = path
    self.httpMethod = httpMethod
    self.parameters = parameters
    self.headers = headers
  }
}

public enum HTTPMethod: String {
  case GET = "GET"
  case POST = "POST"
  case PUT = "PUT"
  case DELETE = "DELETE"
}
