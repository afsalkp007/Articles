//
//  ImageLoader.swift
//  Articles
//
//  Created by Afsal on 30/08/2024.
//

import Foundation

protocol ImageLoader {
  typealias Result = Swift.Result<Data, Error>
  
  func loadImageData(completion: @escaping (ImageLoader.Result) -> Void)
}
