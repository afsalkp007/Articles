//
//  HTTPURLResponse+StatusCode.swift
//  Articles
//
//  Created by Afsal on 26/08/2024.
//

import Foundation

extension HTTPURLResponse {
  var isOK: Bool {
    statusCode == 200
  }
}

