//
//  ArticlesDetailViewController.swift
//  Articles
//
//  Created by Afsal Mohammed on 3/9/22
//

import UIKit

final class ArticlesDetailViewController: UIViewController {
  
  var model: ArticleImage!
  
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
    guard let model = model else { return }
    titleLabel.text = model.title
    authorLabel.text = "\(model.author)  \(model.date)"
    descLabel.text = model.description
    guard let url = model.url else { return }
    downloadImageFrom(url: url, imageMode: .scaleToFill)
  }
  
  func downloadImageFrom(url: URL,imageMode: UIView.ContentMode) {
    if let cachedImage = imageCache.object(forKey: url.absoluteString as NSString) as? UIImage {
      articleImageView.image = cachedImage
    } else {
      URLSession.shared.dataTask(with: url) { data, response, error in
        guard let data = data, error == nil else { return }
        DispatchQueue.main.async {
          let imageToCache = UIImage(data: data)?.resizeImage(with: CGSize(width: 101.0, height: 101.0))
          self.imageCache.setObject(imageToCache!, forKey: url.absoluteString as NSString)
          self.articleImageView.image = imageToCache
        }
      }.resume()
    }
  }
}
