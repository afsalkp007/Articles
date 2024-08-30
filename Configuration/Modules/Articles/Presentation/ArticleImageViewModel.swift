//
//  ArticleCellViewModel.swift
//  Articles
//
//  Created by Afsal on 29/08/2024.
//

import Foundation

struct ArticleImageViewModel {
  public let image: ArticleImage
  private let loader: ImageLoader
  
  typealias Result = Swift.Result<Data, Error>

  init(image: ArticleImage, loader: ImageLoader) {
    self.image = image
    self.loader = loader
  }
  
  func relativeDate(
    currentDate: Date = Date(),
    calendar: Calendar = .current,
    locale: Locale = .current
  ) -> String {
    let formatter = RelativeDateTimeFormatter()
    formatter.calendar = calendar
    formatter.locale = locale
    return formatter.localizedString(for: image.date, relativeTo: currentDate)
  }
  
  func getImageData(completion: @escaping (Result) -> Void) {
    loader.loadImageData(completion: completion)
  }
}
