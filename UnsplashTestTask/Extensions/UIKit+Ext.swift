//
//  UILabel+Ext.swift
//  UnsplashTestTask
//
//  Created by Нагоев Магомед on 07.06.2022.
//

import UIKit

extension UILabel {
    convenience init(text: String, font: UIFont, textColor: UIColor) {
        self.init(frame: .zero)
        self.text = text
        self.font = font
        self.textColor = textColor
    }
    
    convenience init(text: String, font: UIFont, textAlignment: NSTextAlignment) {
        self.init(frame: .zero)
        self.text = text
        self.font = font
        self.textAlignment = textAlignment
    }
}

extension UIButton {
    func heartButton() {
        let configuration = UIImage.SymbolConfiguration(pointSize: 20, weight: .light, scale: .large)
        let image = UIImage(systemName: "suit.heart", withConfiguration: configuration)?.withTintColor(.red, renderingMode: .alwaysOriginal)
        self.setImage(image, for: .normal)
    }
    
    func heartButtonFill() {
        let configuration = UIImage.SymbolConfiguration(pointSize: 20, weight: .light, scale: .large)
        let image = UIImage(systemName: "suit.heart.fill", withConfiguration: configuration)?.withTintColor(.red, renderingMode: .alwaysOriginal)
        self.setImage(image, for: .normal)
    }
}

extension Formatter {
    static let currency: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.currencySymbol = ""
        formatter.currencyDecimalSeparator = "."
        formatter.currencyGroupingSeparator = ","
        return formatter
    }()
    
    static let date: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy"
        return formatter
    }()
}

extension String {
    func asCurrency() -> String? {
        if self.isEmpty {
            return Formatter.currency.string(from: NSNumber(value: 0))
        } else {
            return Formatter.currency.string(from: NSNumber(value: (Int(self) ?? 0)))
        }
    }
    
    func removeFormatAmount() -> Double {
        let nsNumber = Formatter.currency.number(from: self)
        if let nsNumber = nsNumber {
            return Double(truncating: nsNumber)
        }
        return 0.0
    }
    
    func asDate() -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        if self.isEmpty {
            return Formatter.date.string(from: Date())
            
        } else {
            return Formatter.date.string(from: dateFormatter.date(from: self) ?? Date())
        }
    }
}
