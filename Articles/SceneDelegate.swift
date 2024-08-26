//
//  SceneDelegate.swift
//  Articles
//
//  Created by Afsal on 25/08/2024.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
  var window: UIWindow?
    
  private lazy var navigationController = UINavigationController(
      rootViewController: ArticlesUIComposer.composed(
        with:  resource(for: .week),
        selection: showDetail))
  
  func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
    
    guard let scene = (scene as? UIWindowScene) else { return }
    
    window = UIWindow(windowScene: scene)
    window?.backgroundColor = .white
    window?.rootViewController = navigationController
    window?.makeKeyAndVisible()
  }
  
  private func showDetail(with vm: ArticleImageViewModel) {
    let detail = ArticlesDetailUIComposer.composedWith(vm)
    navigationController.pushViewController(detail, animated: true)
  }
  
  private func resource(for period: Period) -> Resource {
    Resource(
      url: Constants.Urls.nytMostPopularUrl,
      path: "svc/mostpopular/v2/mostviewed/all-sections/\(period.rawValue).json",
      parameters: ["api-key": Constants.APIkey.nyt])
  }
}
