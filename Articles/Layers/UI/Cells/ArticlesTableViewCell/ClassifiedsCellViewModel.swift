//
//  ArticlesCellViewModel.swift
//  Articles
//
//  Created by Afsal Mohammed on 3/9/22.
//

import Foundation
import UIKit

struct ArticlesCellViewModel {
  var title: String
  var author: String
  var date: String?
  var desc: String?
  var imageUrl: URL?
  
  init(article: Article) {
    self.title = article.title
    self.author = article.author
    self.date = article.date
    self.desc = article.desc
    self.imageUrl = URL(string: article.media?.first?.metadata?.first?.imageUrl ?? "")
  }
}
