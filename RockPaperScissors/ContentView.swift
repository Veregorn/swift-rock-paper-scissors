//
//  ContentView.swift
//  RockPaperScissors
//
//  Created by Rul-ex on 8/9/21.
//

import SwiftUI

struct MoveImage: View {
    var move: String
    
    var body: some View {
        Image(move)
            .resizable(resizingMode: .stretch)
            .aspectRatio(contentMode: .fit)
            .padding(.horizontal)
    }
}

struct ContentView: View {
    @State private var moves = ["rock", "paper", "scissors"]
    @State private var iaChoice = Int.random(in: 0...2)
    @State private var shouldWin = Bool.random()
    @State private var score = 0
    @State private var scoreTitle = ""
    @State private var showingScore = false
    
    var body: some View {
        VStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, spacing: 30) {
            VStack {
                Text("My move is")
                Text(moves[iaChoice])
                    .font(.largeTitle)
                    .bold()
                    .foregroundColor(.blue)
            }
            VStack {
                Text("What move do you need to")
                if shouldWin {
                    Text("WIN?")
                        .bold()
                        .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                        .padding(.bottom)
                } else {
                    Text("LOSE?")
                        .bold()
                        .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                        .padding(.bottom)
                }
                HStack {
                    ForEach(0 ..< 3) { number in
                        Button(action: {
                            self.moveTapped(number)
                        }) {
                            MoveImage(move: self.moves[number])
                        }
                    }
                }
            }
            Text("Your current score is: \(score)")
        }
        .padding(.top)
        .alert(isPresented: $showingScore) {
            Alert(title: Text(scoreTitle), message: Text("Your score is \(score)"), dismissButton: .default(Text("Continue")) {
                self.resetGame()
            })
        }
    }
    
    func moveTapped(_ number: Int) {
        if number == iaChoice {
            scoreTitle = "Tie"
        } else if shouldWin {
            if iaChoice == 0 {
                if number == 1 {
                    scoreTitle = "Win! Great work"
                    score += 1
                } else {
                    scoreTitle = "Lose :-("
                }
            } else if iaChoice == 1 {
                if number == 0 {
                    scoreTitle = "Lose :-("
                } else {
                    scoreTitle = "Win! Great work"
                    score += 1
                }
            } else {
                if number == 0 {
                    scoreTitle = "Win! Great work"
                    score += 1
                } else {
                    scoreTitle = "Lose :-("
                }
            }
        } else { // You need to lose
            if iaChoice == 0 {
                if number == 1 {
                    scoreTitle = "Win, but needed to lose..."
                } else {
                    scoreTitle = "Lose! Great work"
                    score += 1
                }
            } else if iaChoice == 1 {
                if number == 0 {
                    scoreTitle = "Lose! Great work"
                    score += 1
                } else {
                    scoreTitle = "Win, but needed to lose..."
                }
            } else {
                if number == 0 {
                    scoreTitle = "Win, but needed to lose..."
                } else {
                    scoreTitle = "Lose! Great work"
                    score += 1
                }
            }
        }
        showingScore = true
    }
    
    func resetGame() {
        iaChoice = Int.random(in: 0...2)
        shouldWin = Bool.random()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
