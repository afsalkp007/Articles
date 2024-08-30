//
//  ArticlesViewController.swift
//  Articles
//
//  Created by Afsal Mohammed on 3/9/22.
//

import UIKit

final class ArticlesViewController: UITableViewController {
  private var loader: ArticlesLoader!
  
  convenience init?(coder: NSCoder, loader: ArticlesLoader) {
    self.init(coder: coder)
    self.loader = loader
  }
  
  private var data = [ArticleImageViewModel]() {
    didSet { tableView.reloadData() }
  }
  
  var selection: ((ArticleImageViewModel) -> Void)?
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
    loader.fetchArticles { [weak self] result in
      switch result {
      case let .success(images):
        self?.data = images.map { ArticleImageViewModel(image: $0, loader: RemoteImageLoader(url: $0.url!, client: URLSessionHTTPClient(session: URLSession(configuration: .ephemeral))))}
        
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
