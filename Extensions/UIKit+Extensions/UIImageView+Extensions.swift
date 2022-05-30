//
//  UIImageView+Extensions.swift
//  AppStoreMVC
//
//  Created by Simran Preet Narang on 2022-05-27.
//

import Foundation
import UIKit

extension UIImageView {
    
    convenience init(cornerRadius: CGFloat, clipsToBounds: Bool = true, contentMode: UIView.ContentMode = .scaleAspectFill, translatesAutoresizingMaskIntoConstraints: Bool = false) {
        self.init(image: nil)
        layer.cornerRadius = cornerRadius
        self.clipsToBounds = clipsToBounds
        self.contentMode = contentMode
        self.translatesAutoresizingMaskIntoConstraints = translatesAutoresizingMaskIntoConstraints
    }
}
