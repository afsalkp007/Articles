//
//  ArticlesLoader.swift
//  Articles
//
//  Created by Afsal Mohammed on 3/9/22
//

import Foundation

protocol ArticlesLoader {
  typealias Result = Swift.Result<ArticlesResponse?, Error>
  
  func fetchArticles(for period: Period, _ completion: @escaping (Result) -> Void)
}
