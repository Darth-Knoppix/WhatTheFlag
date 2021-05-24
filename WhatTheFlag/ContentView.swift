//
//  ContentView.swift
//  WhatTheFlag
//
//  Created by Seth Corker on 24/05/2021.
//

import SwiftUI

internal func flag(for regionCode: String) -> String {
    return regionCode
        .unicodeScalars
        .map({ 127397 + $0.value })
        .compactMap(UnicodeScalar.init)
        .map(String.init)
        .joined()
}

func countryName(for regionCode: String) -> String {
    return Locale.current.localizedString(forRegionCode: regionCode) ?? "-"
}

struct ContentView: View {
    var countries: [String] {
        return Locale.isoRegionCodes
    }
    
    var body: some View {
        List {
            ForEach(0 ..< countries.count) { index in
                HStack {
                    Text(flag(for: countries[index]))
                    Text(countryName(for: countries[index]))
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
