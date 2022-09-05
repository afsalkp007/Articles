//
//  ArticlesUITests.swift
//  ArticlesUITests
//
//  Created by Afsal Mohammed on 11/7/21.
//

import XCTest

@testable import Articles

class ArticlesUITests: XCTestCase {
  
  func testExample() throws {
    let app = XCUIApplication()
    app.launch()
  }
  
  func testLaunchPerformance() throws {
    if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
      measure(metrics: [XCTApplicationLaunchMetric()]) {
        XCUIApplication().launch()
      }
    }
  }
}
