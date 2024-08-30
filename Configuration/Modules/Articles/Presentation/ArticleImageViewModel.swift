//
//  ArticleCellViewModel.swift
//  Articles
//
//  Created by Afsal on 29/08/2024.
//

import Foundation

struct ArticleImageViewModel {
  public let image: ArticleImage

  init(image: ArticleImage) {
    self.image = image
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
  
  func getImageData(with url: URL, completion: @escaping (Data) -> Void) {
    URLSession.shared.dataTask(with: url) { data, response, error in
      guard let data = data, error == nil else { return }
        completion(data)
    }.resume()
  }
}
