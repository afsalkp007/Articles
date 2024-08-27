//
//  ArticlesTableViewCell.swift
//  Articles
//
//  Created by Afsal Mohammed on 3/9/22.
//

import UIKit

final class ArticlesTableViewCell: UITableViewCell {

  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var authorLabel: UILabel!
  @IBOutlet weak var articleImageView: CacheableImageView!
  
  required init?(coder: NSCoder) {
    super.init(coder: coder)
    selectionStyle = .none
  }
  
  func cofigure(with item: ArticleImage) {
    titleLabel.text = item.title
    authorLabel.text = "\(item.author)   \(item.date)"
    guard let url = item.imageUrl else { return }
    articleImageView.setUpLoader()
    articleImageView.downloadImageFrom(url: url, imageMode: .scaleAspectFit)
  }
}
