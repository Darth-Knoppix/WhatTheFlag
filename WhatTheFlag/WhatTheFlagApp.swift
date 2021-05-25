//
//  WhatTheFlagApp.swift
//  WhatTheFlag
//
//  Created by Seth Corker on 24/05/2021.
//

import SwiftUI

@main
struct WhatTheFlagApp: App {
    var body: some Scene {
        WindowGroup {
            TabView {
                QuizView().tabItem { Label("Quiz", systemImage: "person") }
                CountryReferenceView().tabItem { Label("Countries", systemImage: "person") }
            }
        }
    }
}
