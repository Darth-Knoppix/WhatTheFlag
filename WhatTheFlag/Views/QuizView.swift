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
        return Country.flag(for: id)
    }
}

struct QuizView: View {
    @State private var gameState = GameState.notStarted
    @State private var correctAnswerCode: String?
    @State private var countries: [CountryChoice] = []
    @State private var gameScore: Int = 0
    @State private var userChosenAnswerCode: String?
    @State private var numOfQuestionsAttempted: Int = 0
    @State private var canUserChoose: Bool = false

    func newQuestion() {
        canUserChoose = true
        countries = Array(Country.countries.shuffled()[0 ..< 4]).map { CountryChoice(id: $0) }
        correctAnswerCode = countries.shuffled().first!.id
    }

    func newGame() {
        gameState = .started
        gameScore = 0
        numOfQuestionsAttempted = 0
        newQuestion()
    }

    func choose(_ country: CountryChoice) {
        userChosenAnswerCode = country.id
        numOfQuestionsAttempted += 1
        if country.id == correctAnswerCode {
            gameScore += 1
        }

        canUserChoose = false

        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1.0) {
            userChosenAnswerCode = nil
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.5) {
                withAnimation { self.newQuestion() }
            }
        }
    }

    func flagHighlight(when isShowing: Bool, and isCorrect: Bool) -> Color {
        switch (isShowing, isCorrect) {
        case (true, true):
            return .green
        case (true, false):
            return .red
        default:
            return .white
        }
    }

    func flagScale(when isShowing: Bool, and isCorrect: Bool, for userCorrect: Bool) -> CGSize {
        switch (isShowing, isCorrect, userCorrect) {
        case (false, _, _):
            return CGSize(width: 1.0, height: 1.0)
        case (true, false, true):
            return CGSize(width: 0.5, height: 0.5)
        case (true, true, false):
            return CGSize(width: 1.25, height: 1.25)
        default:
            return CGSize(width: 1.0, height: 1.0)
        }
    }

    var score: some View {
        ZStack {
            Circle()
                .fill(Color.gray)
                .frame(width: 50, height: 50, alignment: .center)
            Text("\(gameScore)/\(numOfQuestionsAttempted)")
                .foregroundColor(.white)
        }
    }

    var body: some View {
        VStack {
            if gameState == GameState.started {
                score
            }

            VStack(alignment: .center, spacing: 20) {
                if gameState == GameState.started {
                    Text("Which flag belongs to \(Country.name(for: correctAnswerCode!))?")
                }
                LazyVGrid(columns: [GridItem(), GridItem()]) {
                    ForEach(countries, id: \.self) { country in
                        let isShowingAnswer = (userChosenAnswerCode != nil)
                        let isCorrect = isShowingAnswer && country.id == correctAnswerCode
                        let didChooseCorrectly = isShowingAnswer && correctAnswerCode == userChosenAnswerCode
                        let highlighColor = flagHighlight(when: isShowingAnswer, and: isCorrect)
                        let flagSize = flagScale(when: isShowingAnswer, and: isCorrect, for: didChooseCorrectly)

                        Text(country.flag)
                            .font(.system(size: 72.0))
                            .onTapGesture {
                                if canUserChoose {
                                    choose(country)
                                }
                            }
                            .scaleEffect(flagSize)
                            .shadow(color: highlighColor, radius: 3, x: 0.0, y: 0.0)
                            .animation(.easeInOut)
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
