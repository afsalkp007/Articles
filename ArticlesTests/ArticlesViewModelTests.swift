//
//  ArticlesViewControllerTests.swift
//  ArticlesTests
//
//  Created by Afsal on 25/08/2024.
//

import XCTest
@testable import Articles

class ArticlesViewModelTests: XCTestCase {
  
  func test() {
    let spy = ServiceSpy()
    let sut = ArticlesViewModel(articlesService: spy)
        
    XCTAssertEqual(spy.completions.count, 1)
  }
  
  // MARK: - Helpers
  
  private class ServiceSpy: ArticlesLoader {
    var completions = [(ArticlesLoader.Result) -> Void]()
    
    func fetchArticles(for period: Period, _ completion: @escaping (ArticlesLoader.Result) -> Void) {
      completions.append(completion)
    }
  }
}
