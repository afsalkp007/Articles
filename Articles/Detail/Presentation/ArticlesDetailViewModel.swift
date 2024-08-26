//
//  ArticlesDetailViewModel.swift
//  Articles
//
//  Created by Afsal Mohammed on 3/9/22
//

import Foundation

struct ArticlesDetailViewModel {
  
  let cellViewModel: ArticleImageViewModel
  
  var title: String
  var author: String
  var date: String?
  var desc: String?
  var imageUrl: URL?
  
  init(cellViewModel: ArticleImageViewModel) {
    self.cellViewModel = cellViewModel
    self.title = cellViewModel.title
    self.author = cellViewModel.author
    self.date = cellViewModel.date
    self.desc = cellViewModel.desc
    self.imageUrl = cellViewModel.imageUrl
  }
}
