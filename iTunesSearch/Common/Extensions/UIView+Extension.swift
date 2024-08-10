//
//  UIView+Extension.swift
//  iTunesSearch
//
//  Created by 권대윤 on 8/10/24.
//

import UIKit

extension UIView {
    func addSubViews(_ views: UIView...) {
        views.forEach { self.addSubview($0) }
    }
}
