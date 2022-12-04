//
//  UIStackView+extension.swift
//  tvshows
//
//  Created by Aldair Martínez on 03/12/22.
//

import Foundation
import UIKit

extension UIStackView {
    
    func removeViews() {
        subviews.forEach({ $0.removeFromSuperview() })
    }
    
    func addArrangedSubviews(_ views: UIView...) {
        views.forEach({ self.addArrangedSubview($0) })
    }
    
}
