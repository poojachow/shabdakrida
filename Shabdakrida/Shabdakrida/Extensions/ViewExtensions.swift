//
//  ViewExtensions.swift
//  Shabdakrida
//
//  Created by Pooja Chowdhary on 12/30/20.
//

import UIKit

extension UIView {
    
    func attachConstraints(format: String, children: UIView...) {
        var views: [String: UIView] = [:]
        for (index, view) in children.enumerated() {
            views["v\(index)"] = view
            view.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    
}
