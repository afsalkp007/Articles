//
//  CacheableImageView.swift
//  Articles
//
//  Created by Afsal Mohammed on 3/9/22.
//

import UIKit

final class CacheableImageView: UIImageView {
    
  private let imageCache = NSCache<NSString, AnyObject>()
    
  let activityIndicator = UIActivityIndicatorView()
  
  func downloadImageFrom(urlString: String, imageMode: UIView.ContentMode) {
    guard let url = URL(string: urlString) else { return }
    downloadImageFrom(url: url, imageMode: imageMode)
  }
  
  func setUpLoader() {
    activityIndicator.center = center
    activityIndicator.hidesWhenStopped = true
    addSubview(activityIndicator)
    self.activityIndicator.startAnimating()
  }
  
  func downloadImageFrom(url: URL,imageMode: UIView.ContentMode) {
    if let cachedImage = imageCache.object(forKey: url.absoluteString as NSString) as? UIImage {
      self.image = cachedImage
    } else {
      URLSession.shared.dataTask(with: url) { data, response, error in
        guard let data = data, error == nil else { return }
        DispatchQueue.main.async {
          let imageToCache = UIImage(data: data)?.resizeImage(with: CGSize(width: 101.0, height: 101.0))
          self.imageCache.setObject(imageToCache!, forKey: url.absoluteString as NSString)
          self.image = imageToCache
          self.activityIndicator.stopAnimating()
        }
      }.resume()
    }
  }
}

