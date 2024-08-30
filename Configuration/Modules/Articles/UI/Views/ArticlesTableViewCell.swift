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
  @IBOutlet weak var dateLabel: UILabel!
  @IBOutlet weak var articleImageView: UIImageView!
      
  func cofigure(with viewModel: ArticleImageViewModel) {
    titleLabel.text = viewModel.image.title
    authorLabel.text = viewModel.image.author
    dateLabel.text = viewModel.relativeDate()
    
    getImage(from: viewModel)
  }
  
  private func getImage(from viewModel: ArticleImageViewModel) {
    viewModel.getImageData { result in
      if case let .success(data) = result {
        DispatchQueue.main.async {
          let image = UIImage(data: data)
          self.articleImageView.image = image
        }
      }
    }
  }
}
