//
//  ArticlesViewController.swift
//  Articles
//
//  Created by Afsal Mohammed on 3/9/22.
//

import UIKit

final class ArticlesViewController: UIViewController, Storyboarded {
  
  var coordinator: ArticlesDetailCoordinator?
  var viewModel: ArticlesViewModel?
  
  @IBOutlet weak var tableView: UITableView!
  var loaderView = UIActivityIndicatorView()
  private let adapter = Adapter<ArticlesCellViewModel, ArticlesTableViewCell>()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupUI()
    setupData()
  }

  private func setupUI() {
    setUpLoader()
    tableView.register(cellType: ArticlesTableViewCell.self)
  }

  private func setupData() {
    viewModel?.updateUI = { [weak self] in
      guard let self = self, let viewModel = self.viewModel else { return }
      self.title = viewModel.title
      self.adapter.items = viewModel.viewModels
      self.configureTableView()
      self.loaderView.stopAnimating()
    }
  }
  
  private func configureTableView() {
    adapter.cellHeight = 110
    tableView.delegate = adapter
    tableView.dataSource = adapter
    tableView.layer.cornerRadius = 0
    tableView.backgroundColor = UIColor.clear
    tableView.tableFooterView = UIView()
    tableView.reloadData()
    
    adapter.configure = { item, cell in
      cell.titleLabel.text = item.title
      cell.authorLabel.text = "\(item.author)   \(item.date ?? "")"
      guard let url = item.imageUrl else { return }
      cell.articleImageView.setUpLoader()
      cell.articleImageView.downloadImageFrom(url: url, imageMode: .scaleAspectFit)
    }
    
    adapter.select = { [weak self] viewModel in
      self?.coordinator?.start(viewModel)
    }
  }
  
  private func setUpLoader() {
    tableView.addSubview(loaderView)
    loaderView.hidesWhenStopped = true
    loaderView.translatesAutoresizingMaskIntoConstraints = false
    loaderView.centerXAnchor.constraint(equalTo: tableView.centerXAnchor).isActive = true
    loaderView.centerYAnchor.constraint(equalTo: tableView.centerYAnchor).isActive = true
    loaderView.startAnimating()
  }
}
