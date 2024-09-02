//
//  ArticlesAPIEndToEndTests.swift
//  ArticlesAPIEndToEndTests
//
//  Created by Afsal on 02/09/2024.
//

import XCTest
import Articles

class ArticlesAPIEndToEndTests: XCTestCase {
  
  func test_endToEndTestServerGETFeedResult_matchesFixedTestAccountData() {
    
    switch getFeedResult() {
    case let .success(imageFeed)?:
      XCTAssertEqual(imageFeed.count, 20, "Expected 20 images on the test account image feed")
      XCTAssertEqual(imageFeed[0], expectedImage(at: 0))
      
    case let .failure(error)?:
      XCTFail("Expected succesful result, got \(error) instead.")
      
    default:
      XCTFail("Expected success, got no result instead.")
    }
  }
  
  private func getFeedResult(file: StaticString = #filePath, line: UInt = #line) -> ArticlesLoader.Result? {
    let loader = RemoteArticlesLoader(resource: Resource(url: feedTestServerURL), client: ephemeralHTTPClient())
    trackForMemoryLeaks(loader, file: file, line: line)
    
    let exp = expectation(description: "Wait for load completion")
    
    var receivedResult: ArticlesLoader.Result?
    loader.fetchArticles { result in
      receivedResult = result
      exp.fulfill()
    }
    wait(for: [exp], timeout: 50.0)
    
    return receivedResult
  }
  
  private func expectedImage(at index: Int) -> ArticleImage {
    return ArticleImage(
      title: title(at: index),
      author: auathor(at: index),
      date: date(at: index),
      description: description(at: index),
      url: url(at: index)
    )
  }
  
  private var feedTestServerURL: URL {
    return URL(string: "https://api.nytimes.com/svc/mostpopular/v2/mostviewed/all-sections/7.json?api-key=gGc5U7GM2xeyNgFlxJxf3qb0x8AfqLe5")!
  }
  
  private func ephemeralHTTPClient(file: StaticString = #file, line: UInt = #line) -> URLSessionHTTPClient {
    let client = URLSessionHTTPClient(session: URLSession(configuration: .ephemeral))
    trackForMemoryLeaks(client, file: file, line: line)
    return client
  }
  
  private func title(at index: Int) -> String {
    ["Trump Reposts Crude Sexual Remark About Harris on Truth Social"][index]
  }
  
  private func auathor(at index: Int) -> String {
    ["By Michael Gold"][index]
  }
  
  private func date(at index: Int) -> Date {
    [formatted(date: "2024-08-29 22:47:28")][index]
  }
  
  private func description(at index: Int) -> String {
    ["Though the former president has a history of making crass insults about opponents, the reposts signal his willingness to continue to shatter longstanding political norms."][index]
  }
  
  private func url(at index: Int) -> URL? {
    [URL(string: "https://static01.nyt.com/images/2024/08/28/multimedia/28election-live-trump-harris-truth-social-qglj/28election-live-trump-harris-truth-social-qglj-thumbStandard.jpg")][index]
  }
  
  private func formatted(date: String) -> Date {
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM-d H:mm:ss"
    formatter.timeZone = TimeZone(secondsFromGMT: 0)
    return formatter.date(from: date)!
  }
}
