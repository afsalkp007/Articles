//
//  ArticlesLoader.swift
//  Articles
//
//  Created by Afsal Mohammed on 3/9/22
//

import Foundation

public protocol ArticlesLoader {
  typealias Result = Swift.Result<[ArticleImage], Error>
  
  func fetchArticles(completion: @escaping (Result) -> Void)
}
