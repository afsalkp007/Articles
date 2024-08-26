//
//  MainQueueDispatchDecorator.swift
//  Articles
//
//  Created by Afsal on 26/08/2024.
//

import Foundation

final class MainQueueDispatchDecorator<T> {
  private let decoratee: T
  
  init(decoratee: T) {
    self.decoratee = decoratee
  }
  
  func action(_ completion: @escaping () -> Void) {
    guard Thread.isMainThread else {
      return DispatchQueue.main.async { completion() }
    }
    
    completion()
  }
}
 
extension MainQueueDispatchDecorator: ArticlesLoader where T: ArticlesLoader {
  func fetchArticles(with resource: Resource, _ completion: @escaping (ArticlesLoader.Result) -> Void) {
    decoratee.fetchArticles(with: resource) { [weak self] result in
      guard let self = self else { return }
      
      self.action { completion(result) }
    }
  }
}
