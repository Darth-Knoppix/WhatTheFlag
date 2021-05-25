//
//  ContentView.swift
//  WhatTheFlag
//
//  Created by Seth Corker on 24/05/2021.
//

import SwiftUI

enum GameState {
    case notStarted
    case started
    case inProgress
    case completed
}

struct CountryChoice: Identifiable, Hashable {
    let id: String
    var flag: String {
        return Country.flag(for: self.id)
    }
}

struct QuizView: View {
    @State private var gameState = GameState.notStarted
    @State private var correctAnswerCode: String?
    @State private var countries: [CountryChoice] = []
    @State private var gameScore: Int = 0
    
    func newQuestion() {
        countries = Array(Country.countries.shuffled()[0 ..< 4]).map({ CountryChoice(id: $0)})
        correctAnswerCode = countries.shuffled().first!.id
    }
    
    func newGame() {
        gameState = .started
        gameScore = 0
        self.newQuestion()
    }
    
    func choose(_ country: CountryChoice) {
        if country.id == correctAnswerCode {
            gameScore += 1
        }
    }
    
    var body: some View {
        VStack {
            if gameState == GameState.started {
                ZStack {
                    Circle()
                        .fill(Color.gray)
                        .frame(width: 50, height: 50, alignment: .center)
                    Text("\(gameScore)")
                }
            }
        
            VStack(alignment: .center, spacing: 20) {
                if gameState == GameState.started{
                    Text("Which flag belongs to \(Country.name(for: correctAnswerCode!))?")
                }
                LazyVGrid(columns: [GridItem(), GridItem()]) {
                    ForEach(countries, id: \.self) { country in
                        Text(country.flag).font(.system(size: 72.0)).onTapGesture {
                            choose(country)
                        }
                    }
                }
                Button("New Game", action: { withAnimation { newGame() } })
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        QuizView()
    }
}
