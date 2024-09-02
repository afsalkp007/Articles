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
      updated: (Date(timeIntervalSince1970: 1567019522), "2019-08-28 19:12:02"),
      description: "any description",
      url: URL(string: "http://any-url.com"))
    
    let item2 = makeItem(
      title: "another title",
      author: "another author",
      updated: (Date(timeIntervalSince1970: 1253575474), "2009-09-21 23:24:34"),
      description: "another description",
      url: URL(string: "http://another-url.com"))
    
    let items = [item1.model, item2.model]
    
    expect(sut, toCompleteWith: .success(items), when: {
      let json = makeItemsJSON([item1.json, item2.json])
      client.complete(withStatusCode: 200, data: json)
    })
  }
  
  // MARK: - HTTPCientSpy
  
  private func makeItemsJSON(_ items: [[String: Any]]) -> Data {
    let json = ["results": items]
    return try! JSONSerialization.data(withJSONObject: json)
  }
  
  private func makeSUT(
    url: URL = URL(string: "http://any-url.com")!,
    file: StaticString = #filePath,
    line: UInt = #line
  ) -> (sut: RemoteArticlesLoader, client: HTTPCientSpy) {
    let client = HTTPCientSpy()
    let url = URL(string: "http://any-url.com")!
    let resource = Resource(url: url)
    let sut = RemoteArticlesLoader(resource: resource, client: client)
    trackForMemoryLeaks(sut, file: file, line: line)
    trackForMemoryLeaks(client, file: file, line: line)
    return (sut, client)
  }
  
  private func makeItem(title: String, author: String, updated: (date: Date, formatted: String), description: String, url: URL? = URL(string: "http://any-url.com")
  ) -> (model: ArticleImage, json: [String: Any]) {
    let item = ArticleImage(
      title: title,
      author: author,
      date: updated.date,
      description: description,
      url: url)
    
    let json = [
      "title": title,
      "byline": author,
      "updated": updated.formatted,
      "abstract": description,
      "media": [["media-metadata": [["url": url?.absoluteString]]]]
    ].compactMapValues { $0 }
    return (item, json)
  }
  
  private func expect(
    _ sut: RemoteArticlesLoader,
    toCompleteWith expectedResult: RemoteArticlesLoader.Result,
    when action: () -> Void,
    file: StaticString = #filePath,
    line: UInt = #line
  ) {
    
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
}

