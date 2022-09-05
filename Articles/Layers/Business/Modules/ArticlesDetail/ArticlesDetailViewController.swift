//
//  ArticlesDetailViewController.swift
//  Articles
//
//  Created by Afsal Mohammed on 3/9/22
//

import UIKit

final class ArticlesDetailViewController: UIViewController, Storyboarded {
  
  var viewModel: ArticlesDetailViewModel?
  
  @IBOutlet weak var articleImageView: CacheableImageView!
  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var authorLabel: UILabel!
  @IBOutlet weak var descLabel: UILabel!
  override func viewDidLoad() {
    super.viewDidLoad()
    configureView()
  }
  
  private func configureView() {
    guard let viewModel = viewModel else { return }
    titleLabel.text = viewModel.title
    authorLabel.text = "\(viewModel.author)  \(viewModel.date ?? "")"
    descLabel.text = viewModel.desc ?? ""
    guard let url = viewModel.imageUrl else { return }
    articleImageView.setUpLoader()
    articleImageView.downloadImageFrom(url: url, imageMode: .scaleToFill)
  }
}
