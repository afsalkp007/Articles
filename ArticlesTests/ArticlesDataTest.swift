//
//  ArticlesDataTest.swift
//  Articles
//
//  Created by Afsal Mohammed on 3/9/22
//

import XCTest
@testable import Articles

class ArticlesDataTest: XCTestCase {
  
  func testParsing() throws {
    let json: [String: Any] = [
      "title": "Republicans, Once Outraged by Mar-a-Lago Search, Become Quieter as Details Emerge",
      "byline": "By Jonathan Weisman",
      "published_date": "2022-08-26",
      "abstract": "Some of former President Donald J. Trump’s most loyal allies were initially focused elsewhere —&nbsp;a potentially telling reaction with ramifications for his political future."
    ]
    
    let data = try JSONSerialization.data(withJSONObject: json, options: [])
    let decoder = JSONDecoder()
    let article = try decoder.decode(Article.self, from: data)
    
    XCTAssertEqual(article.title, "Republicans, Once Outraged by Mar-a-Lago Search, Become Quieter as Details Emerge")
    XCTAssertEqual(article.author, "By Jonathan Weisman")
    XCTAssertEqual(article.date, "2022-08-26")
    XCTAssertEqual(article.desc, "Some of former President Donald J. Trump’s most loyal allies were initially focused elsewhere —&nbsp;a potentially telling reaction with ramifications for his political future.")
  }
}
