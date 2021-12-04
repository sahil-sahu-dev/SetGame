//
//  set_game.swift
//  setGameA3
//
//  Created by Sahil Sahu on 04/05/21.
//

import Foundation
import SwiftUI


struct Set_Game {
    
    //MARK: variables declaration
    var deckofCards = [Card]()
    var cardsOnScreen = [Card]()
    var score: Int = 0
    var indexes = [Int]()
    
    //MARK: init
    init(deckofCards: [Card], cardsOnScreen: [Card]){
      
        self.cardsOnScreen = cardsOnScreen
        self.deckofCards = deckofCards
        self.deckofCards.shuffle()

    }
    
    //MARK: Choose card
        mutating func choose(card: Card){
        let chosenIndex: Int = cardsOnScreen.firstIndex(matching: card)!
                
        if(!cardsOnScreen[chosenIndex].isSelected && !cardsOnScreen[chosenIndex].isMatched){
        
            cardsOnScreen[chosenIndex].isSelected.toggle()

            var count = 0
            for i in 0..<cardsOnScreen.count {
                if(cardsOnScreen[i].isSelected){
                    count+=1
                    if(!indexes.contains(i)){
                        indexes.append(i)
                    }
                }
            }
            
            if count == 3 {
                checkForMatches(chosenIndex: chosenIndex)
            }
        
        }
    }
    
     mutating func removeMatchedCards(_ id1: Int, _ id2: Int, _ id3: Int) {
        for _ in 0..<3{
            for i in 0..<cardsOnScreen.count{
                if cardsOnScreen[i].id == id1 || cardsOnScreen[i].id == id2 || cardsOnScreen[i].id == id3{
                    cardsOnScreen.remove(at: i)
                    break
                }
            }
        }
    }
    
     mutating func checkForMatches(chosenIndex: Int) {
        
        if
                    cardsOnScreen[indexes[0]].shading == cardsOnScreen[indexes[1]].shading && cardsOnScreen[indexes[1]].shading == cardsOnScreen[indexes[2]].shading
                    ||
                    cardsOnScreen[indexes[0]].color == cardsOnScreen[indexes[1]].color && cardsOnScreen[indexes[1]].color == cardsOnScreen[indexes[2]].color
                    ||
                    cardsOnScreen[indexes[0]].noOfShapes == cardsOnScreen[indexes[1]].noOfShapes && cardsOnScreen[indexes[1]].noOfShapes == cardsOnScreen[indexes[2]].noOfShapes
                
                    
            {
                
                let id1 = cardsOnScreen[indexes[0]].id
                let id2 = cardsOnScreen[indexes[1]].id
                let id3 = cardsOnScreen[indexes[2]].id
                
                removeMatchedCards(id1, id2, id3)
                
                score+=2
            }
       
        for i in cardsOnScreen.indices{ cardsOnScreen[i].isSelected = false }
        indexes.removeAll()
}
    
    
    //MARK: Add card on screen
    mutating func addCardToScreen() {
        let newCard = deckofCards.first!
        cardsOnScreen.append(newCard)
        deckofCards.removeFirst()
        score -= 1
    }
    

    //MARK: Card struct
struct Card: Identifiable {
    
    var id: Int
    var shape: String
    var noOfShapes: Int
    var shading: Double
    var color: Color
    var isMatched: Bool = false
    var isSelected: Bool = false
    var hasBeenSeen: Int = 0
    
}
}
