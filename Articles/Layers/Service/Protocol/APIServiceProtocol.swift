//
//  APIServiceProtocol.swift
//  Articles
//
//  Created by Afsal Mohammed on 3/9/22
//

import Foundation

protocol APIServiceProtocol {
  func fetchArticles(for period: Period, _ completion: @escaping (Result<ArticlesResponse?>) -> Void)
}

extension APIServiceProtocol {
  func fetchArticles(for period: Period, _ completion: @escaping (Result<ArticlesResponse?>) -> Void) { }
}
