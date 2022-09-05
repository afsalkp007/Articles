//
//  ArticlesDataServiceTests.swift
//  Articles
//
//  Created by Afsal Mohammed on 3/9/22
//

import XCTest
@testable import Articles

class ArticlesDataServiceTests: XCTestCase {
  
  func testFetchWeatherData() {
    let expectation = self.expectation(description: #function)
    let mockNetworkService = MockNetworkService(fileName: "articles")
    let articlesService = APIService(networking: mockNetworkService)
    
    articlesService.fetchArticles(for: .week) { result in
      switch result {
      case .success(let response):
        let article = response?.articles?.first ?? nil
        XCTAssertEqual(article?.title, "Republicans, Once Outraged by Mar-a-Lago Search, Become Quieter as Details Emerge")
        XCTAssertEqual(article?.author, "By Jonathan Weisman")
        XCTAssertEqual(article?.date, "2022-08-26")
        XCTAssertEqual(article?.desc, "Some of former President Donald J. Trump’s most loyal allies were initially focused elsewhere —&nbsp;a potentially telling reaction with ramifications for his political future.")
        expectation.fulfill()
      case .failure(let error):
        print(error.localizedDescription)
      }
    }
    
    wait(for: [expectation], timeout: 1)
  }
}
