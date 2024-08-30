//
//  ArticlesDetailViewController.swift
//  Articles
//
//  Created by Afsal Mohammed on 3/9/22
//

import UIKit

final class ArticlesDetailViewController: UIViewController {
  
  var viewModel: ArticleImageViewModel!
  
  private let imageCache = NSCache<NSString, AnyObject>()
  
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
    guard let url = viewModel.image.url else { return }
    
    if let cachedImage = imageCache.object(forKey: url.absoluteString as NSString) as? UIImage {
      articleImageView.image = cachedImage
    } else {
      viewModel.getImageData { result in
        if case let .success(data) = result {
          DispatchQueue.main.async {
            let imageToCache = UIImage(data: data)?.resizeImage(with: CGSize(width: 101.0, height: 101.0))
            self.imageCache.setObject(imageToCache!, forKey: url.absoluteString as NSString)
            self.articleImageView.image = imageToCache
          }
        }
      }
    }
  }
}
