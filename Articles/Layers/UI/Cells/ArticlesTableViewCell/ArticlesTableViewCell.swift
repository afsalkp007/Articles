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
}
