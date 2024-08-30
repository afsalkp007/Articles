//
//  ArticlesDetailViewController.swift
//  Articles
//
//  Created by Afsal Mohammed on 3/9/22
//

import UIKit

final class ArticlesDetailViewController: UIViewController {
  
  var viewModel: ArticleImageViewModel!
    
  @IBOutlet weak var articleImageView: UIImageView!
  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var authorLabel: UILabel!
  @IBOutlet weak var descLabel: UILabel!
  override func viewDidLoad() {
    super.viewDidLoad()
    configureView()
  }
  
  private func configureView() {
    guard let viewModel = viewModel else { return }
    titleLabel.text = viewModel.image.title
    authorLabel.text = "\(viewModel.image.author)  \(viewModel.image.date)"
    descLabel.text = viewModel.image.description
    
    getImage(for: viewModel)
  }
  
  private func getImage(for viewModel: ArticleImageViewModel) {
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

