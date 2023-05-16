//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by ashu sharma on 26/02/23.
//

import SwiftUI

struct ContentView: View {
    @State private var showingScore = false
    @State private var scoreTitle = ""
    
  @State  var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
   @State var correctAnswer = Int.random(in: 0...2)
    @State private var score = 0
    @State private var selected = 0
    @State private var numberOfTries = 0
    
    func flagTapped(_ number: Int) {
        selected = number
        if number == correctAnswer {
            scoreTitle = "Correct"
            score += 1
        } else {
            scoreTitle = "Wrong"
        }
        numberOfTries += 1

        showingScore = true
    }
    
    func askQuestion() {
        if(numberOfTries == 10) {
            scoreTitle = ""
            showingScore = false
            score = 0
            selected = 0
        }
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
    
    var body: some View {
        ZStack {
            RadialGradient(stops: [
                .init(color: Color(red: 0.1, green: 0.2, blue: 0.45), location: 0.3),
                .init(color: Color(red: 0.76, green: 0.15, blue: 0.26), location: 0.3),
            ], center: .top, startRadius: 300, endRadius: 400)
                .ignoresSafeArea()
            VStack {
                Text("Score: \(score)").foregroundColor(.white).font(.title.bold())
                Text("Guess the Flag")
                        .font(.largeTitle.bold())
                        .foregroundColor(.white)
                VStack(spacing: 15) {
                    VStack {
                        Text("Tap the flag of").foregroundColor(.white)
                            .font(.subheadline.weight(.heavy))
                            .foregroundStyle(.secondary)
                        Text(countries[correctAnswer]).font(.largeTitle.weight(.semibold))
                    }
                    .frame(width: 300)
                    .padding(.vertical, 20)
                    .background(.regularMaterial)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                    ForEach(0..<3) { number in
                        Button() {
                            flagTapped(number)
                        } label: {
                            Image(countries[number]).renderingMode(.original)
                            .cornerRadius(15)
                                .shadow(radius: 5)
                        }
                    }
                    Image(systemName: "goforward").foregroundColor(.white).font(.system(size: 30))
                }
            }
        }.alert(scoreTitle, isPresented: $showingScore) {
            Button(
                numberOfTries == 10 ?
                "Restart" : "Continue", action: askQuestion)
        } message: {
            if(numberOfTries == 10) {
                Text("Game Over!\nYou got \(score) correct")
            } else
            if scoreTitle == "Wrong" {
                Text("Wrong! That's the flag of \(countries[selected])\n\(10 - numberOfTries) Tries left")
            } else {
                Text("Your score is \(scoreTitle)\n\(10 - numberOfTries) Tries left")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
