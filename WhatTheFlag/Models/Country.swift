//
//  CountryService.swift
//  WhatTheFlag
//
//  Created by Seth Corker on 25/05/2021.
//

import SwiftUI

struct Country {
    static let countries: [String] = Locale.isoRegionCodes

    static func name(for regionCode: String) -> String {
        return Locale.current.localizedString(forRegionCode: regionCode) ?? "-"
    }

    static func flag(for regionCode: String) -> String {
        return regionCode
            .unicodeScalars
            .map { 127_397 + $0.value }
            .compactMap(UnicodeScalar.init)
            .map(String.init)
            .joined()
    }
}
