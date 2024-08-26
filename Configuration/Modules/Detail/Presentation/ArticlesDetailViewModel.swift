//
//  ArticlesDetailViewModel.swift
//  Articles
//
//  Created by Afsal Mohammed on 3/9/22
//

import Foundation

struct ArticlesDetailViewModel {
  
  let cellViewModel: ArticleImage
  
  var title: String
  var author: String
  var date: String?
  var desc: String?
  var imageUrl: URL?
  
  init(cellViewModel: ArticleImage) {
    self.cellViewModel = cellViewModel
    self.title = cellViewModel.title
    self.author = cellViewModel.author
    self.date = cellViewModel.date
    self.desc = cellViewModel.description
    self.imageUrl = cellViewModel.imageUrl
  }
}
