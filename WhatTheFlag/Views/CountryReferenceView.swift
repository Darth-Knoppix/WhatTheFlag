//
//  CountryReferenceView.swift
//  WhatTheFlag
//
//  Created by Seth Corker on 25/05/2021.
//

import SwiftUI

struct CountryReferenceView: View {
    var body: some View {
        List {
            ForEach(0 ..< Country.countries.count) { index in
                HStack {
                    Text(Country.flag(for: Country.countries[index]))
                    Text(Country.name(for: Country.countries[index]))
                }
            }
        }
    }
}

struct CountryReferenceView_Previews: PreviewProvider {
    static var previews: some View {
        CountryReferenceView()
    }
}
