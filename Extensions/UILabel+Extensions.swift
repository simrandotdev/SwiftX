//
//  UILabel+Extensions.swift
//  AppStoreMVC
//
//  Created by Simran Preet Singh Narang on 2022-05-23.
//

import Foundation
import UIKit

extension UILabel {
    
    convenience init(text: String, font: UIFont, numberOfLines: Int = 0) {
        
        self.init(frame: .zero)
        self.text = text
        self.font = font
        self.translatesAutoresizingMaskIntoConstraints = false
        self.numberOfLines = numberOfLines
    }
}
