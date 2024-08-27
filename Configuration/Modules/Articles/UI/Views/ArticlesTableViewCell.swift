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
  @IBOutlet weak var articleImageView: UIImageView!
  
  private let imageCache = NSCache<NSString, AnyObject>()
    
  let activityIndicator = UIActivityIndicatorView()
    
  required init?(coder: NSCoder) {
    super.init(coder: coder)
    selectionStyle = .none
  }
  
  func setUpLoader() {
    activityIndicator.center = center
    activityIndicator.hidesWhenStopped = true
    addSubview(activityIndicator)
    self.activityIndicator.startAnimating()
  }
  
  func cofigure(with item: ArticleImage) {
    titleLabel.text = item.title
    authorLabel.text = "\(item.author)   \(item.date)"
    guard let url = item.imageUrl else { return }
    setUpLoader()
    downloadImageFrom(url: url, imageMode: .scaleAspectFit)
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
          self.activityIndicator.stopAnimating()
        }
      }.resume()
    }
  }
}
