//
//  ArticleImageViewModel.swift
//  Articles
//
//  Created by Afsal Mohammed on 3/9/22.
//

import Foundation
import UIKit

public struct ArticleImage: Equatable {
  public let title: String
  public let author: String
  public let date: Date
  public let description: String
  public let url: URL?
  
  public init(
    title: String,
    author: String,
    date: Date,
    description: String,
    url: URL? = nil
  ) {
    self.title = title
    self.author = author
    self.date = date
    self.description = description
    self.url = url
  }
}
