//
//  ArticlesViewController.swift
//  Articles
//
//  Created by Afsal Mohammed on 3/9/22.
//

import UIKit

final class ArticlesViewController: UITableViewController {
  private var loader: ArticlesLoader!
  private var resource: Resource!
  
  convenience init?(coder: NSCoder, loader: ArticlesLoader, resource: Resource) {
    self.init(coder: coder)
    self.loader = loader
    self.resource = resource
  }
  
  private var data = [ArticleImage]() {
    didSet { tableView.reloadData() }
  }
  
  var selection: ((ArticleImage) -> Void)?
  var viewIsAppearing: ((ArticlesViewController) -> Void)?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    viewIsAppearing = { vc in
      vc.viewIsAppearing = nil
      vc.refresh()
    }
  }
  
  override func viewIsAppearing(_ animated: Bool) {
    super.viewIsAppearing(animated)
    
    viewIsAppearing?(self)
  }

  @IBAction func refresh() {
    refreshControl?.beginRefreshing()
    loader?.fetchArticles(with: resource) { [weak self] result in
      switch result {
      case let .success(images):
        self?.data = images
        
      case let .failure(error):
        print(error.localizedDescription)
      }
      self?.refreshControl?.endRefreshing()
    }
  }
}

extension ArticlesViewController {
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    data.count
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell: ArticlesTableViewCell = tableView.dequeue(indexPath)
    let model = data[indexPath.row]
    cell.cofigure(with: model)
    return cell
  }
  
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let viewModel = data[indexPath.row]
    selection?(viewModel)
  }
  
  override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 110.0
  }
}
