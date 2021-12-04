//
//  viewModel.swift
//  setGameA3
//
//  Created by Sahil Sahu on 04/05/21.
//

import Foundation
import SwiftUI

class SetViewModel: ObservableObject {
    
    
    //MARK: Access to model
    
    @Published var model: Set_Game = createSetGame()
    
    var cardsOnScreen: Array<Set_Game.Card>{
        model.cardsOnScreen
    }
    
    var deckofCards: Array<Set_Game.Card> {
        model.deckofCards
    }
    
    var score: Int {
        model.score
    }
    
    var splashScreen:Bool = false
    
    
    //MARK: Creating set game
    
    static func createSetGame() -> Set_Game {
        
        let numberOfShapes = [1,2,3]
        let shapes = ["diamond", "rectangle", "oval"]
        let shades = [0, 0.3, 1]
        let colors: Array<Color> = [.red, .green, .purple]
        
        var a: Array<Set_Game.Card> = [] //the array whcihc will have the deck of cards
            
        var index: Int
        var index1: Int
        var index2: Int
            
        for i in 12..<81{
            
            index  = Int.random(in: 0..<3)
            index1 = Int.random(in: 0..<3)
            index2 = Int.random(in: 0..<3)
            
            a.append(Set_Game.Card(id: i+1, shape: shapes[index], noOfShapes: numberOfShapes[index], shading: shades[index2], color: colors[index2]))
            
            }

        var b = [Set_Game.Card]() //the array which will have the deck of cards on screen
        
        for i in 0..<12{
           
            index  = Int.random(in: 0..<3)
            index1 = Int.random(in: 0..<3)
            index2 = Int.random(in: 0..<3)
            
           
            b.append(Set_Game.Card(id: i+1, shape: shapes[index], noOfShapes: numberOfShapes[index], shading: shades[index1], color: colors[index2]))
        }
        b.shuffle()
        
        return Set_Game(deckofCards: a, cardsOnScreen: b)
    }
    
    //MARK: Intents
    
    func choose(card: Set_Game.Card){
        
        model.choose(card: card)
        
    }
    
    func newGame() {
        model = SetViewModel.createSetGame()
    }
    
    func addNewCard() {
        model.addCardToScreen()
        
    }
    
    
}
