//
//  ArticleCellViewModel.swift
//  Articles
//
//  Created by Afsal on 29/08/2024.
//

import Foundation

struct ArticleImageViewModel {
  public let title: String
  public let author: String
  public let date: String
  public let description: String
  public let url: URL?

  init(image: ArticleImage) {
    self.title = image.title
    self.author = image.author
    self.date = Self.relativeDate(for: image.date)
    self.description = image.description
    self.url = image.url
  }
  
  private static func relativeDate(
    for date: Date,
    currentDate: Date = Date(),
    calendar: Calendar = .current,
    locale: Locale = .current
  ) -> String {
    let formatter = RelativeDateTimeFormatter()
    formatter.calendar = calendar
    formatter.locale = locale
    return formatter.localizedString(for: date, relativeTo: currentDate)
  }
}
