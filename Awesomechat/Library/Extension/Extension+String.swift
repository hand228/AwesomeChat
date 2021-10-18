//
//  Extension+String.swift
//  Awesomechat
//
//  Created by MaiNQ on 18/10/2021.
//

import Foundation

extension String {
    func localized() -> String {
        return NSLocalizedString(self, tableName: "Localizations", bundle: .main, value: self, comment: self)
    }
}
