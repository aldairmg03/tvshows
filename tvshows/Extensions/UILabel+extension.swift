//
//  UILabel+extension.swift
//  tvshows
//
//  Created by Aldair Martínez on 02/12/22.
//

import Foundation
import UIKit

extension UILabel {
    func makeOutLine(textColor: UIColor, size: CGFloat) {
        let fontSize = UIFont.boldSystemFont(ofSize: size)
        
        let strokeTextAttributes = [
            NSAttributedString.Key.foregroundColor : textColor,
            NSAttributedString.Key.font : fontSize,
            ] as [NSAttributedString.Key : Any]
        self.attributedText = NSMutableAttributedString(string: self.text ?? "", attributes: strokeTextAttributes)
    }
    
}
