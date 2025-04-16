//
//  String+UI.swift
//  EMTodoList
//
//  Created by Jahongir Anvarov on 16.04.2025.
//

import UIKit

extension String {
    func strikethrough() -> NSAttributedString {
        let attributeString = NSMutableAttributedString(string: self)
        attributeString.addAttribute(.strikethroughStyle,
                                     value: NSUnderlineStyle.single.rawValue,
                                     range: NSRange(location: 0, length: self.count))
        return attributeString
    }
}
