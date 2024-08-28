//
//  RemoteArticlesLoaderTests.swift
//  ArticlesTests
//
//  Created by Afsal on 28/08/2024.
//

import XCTest
import Articles

class RemoteArticlesLoaderTests: XCTestCase {
  
  func test_fetch_deliversConnectivityErrorOnClientError() {
    let (sut, client) = makeSUT()
    
    expect(sut, toCompleteWith: .failure(RemoteArticlesLoader.Error.connectivity), when: {
      client.complete(with: anyNSError())
    })
  }
  
  func test_fetch_deliversInvalidDataErrorOnNon200HTTPResponse() {
    let (sut, client) = makeSUT()
        
    let samples = [199, 201, 300, 400, 500]
    samples.enumerated().forEach { index, code in
      expect(sut, toCompleteWith: .failure(RemoteArticlesLoader.Error.invalidData), when: {
        let invalidData = Data()
        client.complete(withStatusCode: code, data: invalidData, at: index)
      })
    }
  }
  
  func test_fetch_deliversErrorOn200HTTPResponseWithInvalidJSON() {
    let (sut, client) = makeSUT()
    
    expect(sut, toCompleteWith: .failure(RemoteArticlesLoader.Error.invalidData), when: {
      let invalidJSON = Data("invlaid json".utf8)
      client.complete(withStatusCode: 200, data: invalidJSON)
    })
  }
  
  func test_fetch_deliversNoItemsOn200HTTPResponseWithEmptyJSONList() {
    let (sut, client) = makeSUT()
    
    expect(sut, toCompleteWith: .success([]), when: {
      let emptyJSON = Data("{\"results\": []}".utf8)
      client.complete(withStatusCode: 200, data: emptyJSON)
    })
  }
  
  func test_fetch_deliversItemsOn200HTTPResponseWithJSONItems() {
    let (sut, client) = makeSUT()
    
    let item1 = makeItem(
      title: "any title",
      author: "any author",
      date: "any date",
      description: "any description",
      url: URL(string: "http://any-url.com"))
    
    let item2 = makeItem(
      title: "another title",
      author: "another author",
      date: "another date",
      description: "another description",
      url: URL(string: "http://another-url.com"))
    
    let items = [item1.model, item2.model]
    let itemsJSON = [
      "results": [item1.json, item2.json]
    ]
    
    expect(sut, toCompleteWith: .success(items), when: {
      let json = try! JSONSerialization.data(withJSONObject: itemsJSON)
      client.complete(withStatusCode: 200, data: json)
    })
  }
  
  // MARK: - HTTPCientSpy
  
  private func makeSUT(url: URL = URL(string: "http://any-url.com")!) -> (sut: RemoteArticlesLoader, client: HTTPCientSpy) {
    let client = HTTPCientSpy()
    let url = URL(string: "http://any-url.com")!
    let resource = Resource(url: url)
    let sut = RemoteArticlesLoader(resource: resource, client: client)
    return (sut, client)
  }
  
  private func makeItem(title: String, author: String, date: String, description: String, url: URL? = URL(string: "http://any-url.com")) -> (model: ArticleImage, json: [String: Any]) {
    let item = ArticleImage(title: title, author: author, date: date, description: description, url: url)
    let json = [
      "title": item.title,
      "byline": item.author,
      "updated": item.date,
      "abstract": item.description,
      "media": [["media-metadata": [["url": item.url?.absoluteString]]]]
    ].compactMapValues { $0 }
    return (item, json)
  }
  
  private func expect(_ sut: RemoteArticlesLoader, toCompleteWith expectedResult: RemoteArticlesLoader.Result, when action: () -> Void, file: StaticString = #filePath, line: UInt = #line) {
    
    sut.fetchArticles { receivedResult in
      switch (receivedResult, expectedResult) {
        
      case let (.success(receivedImages), .success(expectedImages)):
        XCTAssertEqual(receivedImages, expectedImages, file: file, line: line)
      
      case let (.failure(receivedError as RemoteArticlesLoader.Error), .failure(expectedError as RemoteArticlesLoader.Error)):
        XCTAssertEqual(receivedError, expectedError, file: file, line: line)
        
      default:
        XCTFail("Expected \(expectedResult), got \(receivedResult) instead.", file: file, line: line)
      }
    }
    
    action()
  }
  
  private class HTTPCientSpy: HTTPClient {
    var messages = [(resource: Resource, completion: (HTTPClient.Result) -> Void)]()
    
    var recievedURLs: [Resource] {
      messages.map(\.resource)
    }
    
    func get(from resource: Resource, completion: @escaping (HTTPClient.Result) -> Void) -> HTTPClientTask? {
      messages.append((resource, completion))
      return nil
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
  
  private func anyNSError() -> NSError {
    return NSError(domain: "any error", code: 0)
  }
}

