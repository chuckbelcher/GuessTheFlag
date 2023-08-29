//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Chuck Belcher on 8/28/23.
//

import SwiftUI

struct ContentView: View {
    @State private var showFinalMessage = false
    @State private var showingScore = false
    @State private var scoreTitle = ""
    @State private var score = 0
    @State private var questionNumber = 0
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled() //Note .shuffled() will ensure that the Array is not always in the same order. Pretty cool.
    @State private var correctAnswer = Int.random(in: 0...2)
    @State private var finalMessage = "Your final score was "
    
    var body: some View {
        ZStack {
            RadialGradient(stops: [
                .init(color: Color(red: 0.1, green: 0.2, blue: 0.45), location: 0.3),
                .init(color: Color(red: 0.76, green: 0.15, blue: 0.3), location: 0.3)
            ], center: .top, startRadius: 200, endRadius: 700)
            .opacity(0.90)
            VStack {
                Spacer()
                Text("Guess the Flag")
                    .font(.largeTitle.weight(.bold))
                    .foregroundColor(.white)
                VStack (spacing: 15) {
                    VStack {
                        Text("Tap the flag of ")
                            .font(.title2.bold())
                            .foregroundStyle(.secondary)
                        Text(countries[correctAnswer])
                            .font(.title)
                            .bold()
                    }
                    
                    
                    ForEach (0..<3) { number in
                        Button {
                            flagTapped(number)
                        } label: {
                            Image(countries[number])
                                .renderingMode(.original)
                                .clipShape(Capsule())
                                .shadow(radius: 10)
                        }
                        
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .background(.ultraThinMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                Spacer()
                Spacer()
                Text("Your Score: \(score) out of \(questionNumber)")
                    .padding(.top, 30)
                    .foregroundColor(.white)
                    .font(.title.bold())
                Spacer()
            }
            .padding()
        }
        .ignoresSafeArea()
        .alert(scoreTitle, isPresented: $showingScore) {
            Button("Continue", action: askQuestion)
        } message: {
            Text("Your Score is \(score)")
        }
        .alert(finalMessage, isPresented: $showFinalMessage) {
            Button("Reset", action: resetGame)
        } message: {
            Text("\(score) out of \(questionNumber)")
        }
    }
    
    func resetGame() {
        score = 0
        questionNumber = 0
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
    
    func flagTapped(_ number: Int) {
        
            if number == correctAnswer {
                scoreTitle = "Correct"
                score += 1
            } else {
                scoreTitle = "Sorry you picked \(countries[number])"
            }
        questionNumber += 1
        if questionNumber < 8 {
            showingScore = true
            
        } else {
            showFinalMessage = true
        }
    }
    
    func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
