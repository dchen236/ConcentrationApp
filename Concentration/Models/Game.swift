//
//  game.swift
//  Concentration
//
//  Created by Danni on 1/1/19.
//  Copyright © 2019 Danni Chen. All rights reserved.
//

import Foundation

struct Game{
    var cards = [Card]()
    var indexOfOneAndOnlyFaceUp:Int?
    var score:Int = 0
    var chosenTheme:Theme
    var emojies:[Theme:[String]] = [.animal:["🐶","🦊","🐻","🐷","🙊","🦇","🦄","🦋","🐍","🐢","🦖","🐙","🐫","🦚","🐩"],
                                    .smileyFace:["😇","🥰","🥳","🥶","🤢","😈","👻","🤣","🥺","🎃","💩","😙","🤪","😱"],
                                    .wheather:["🔥","🌈","🌪","☀️","🌧","❄️","☃️","💦","🌊","⛈","🌩","☄️","🌬","💨"],
                                    .fruit:["🍎","🥥","🥭","🍈","🍌","🥝","🥑","🌽","🍊","🍒","🍉","🍇","🍍","🍓"],
                                    .flag:["🏁","🇦🇺","🏳️‍🌈","🇻🇳","🇨🇳","🇬🇧","🇨🇦","🇰🇷","🇱🇷","🇯🇵","🇳🇪","🇺🇸","🇵🇰","🇫🇴"]]

    
    
    
    
    
    init(numberOfPairs:Int,theme:Theme) {
        if numberOfPairs%2 != 0 {
            print("number of pairs must be multiple of two cause 4 cards per row")
        }
        else{
            for _ in 0..<numberOfPairs{
                let card = Card()
                cards+=[card,card]
            }
        }
        chosenTheme = theme
        shuffleCards()
        
        
    }
    
    mutating private func shuffleCards(){
        let shuffleTimes = Int.random(in: 0..<5)+10
        for _ in 0..<shuffleTimes{
            let randomIndex1 = Int.random(in: 0..<cards.count)
            let randomIndex2 = Int.random(in: 0..<cards.count)
            swapCards(between: randomIndex1, and: randomIndex2)
        }
    }
    
   mutating private func swapCards(between index1:Int,and index2:Int){
        let tempCard = cards[index1]
        cards[index1] = cards[index2]
        cards[index2] = tempCard
    }
    
    func newScore()->Int{
        return score
    }
    
    mutating func cardSelected(selectedCardIndex:Int){
        cards[selectedCardIndex].isFaceUp = true
        if indexOfOneAndOnlyFaceUp == nil{
            indexOfOneAndOnlyFaceUp = selectedCardIndex
            for i in 0..<cards.count{
                if i != selectedCardIndex{
                    cards[i].isFaceUp = false
                }
            }
        }
        else{   //oneAndOnlyFaceUp card exists
            if cards[selectedCardIndex].identifier != cards[indexOfOneAndOnlyFaceUp!].identifier{ //no match
                score-=1
            }
            else{   //match!
                cards[indexOfOneAndOnlyFaceUp!].isMatched = true
                cards[selectedCardIndex].isMatched = true
                score+=2
            }
            indexOfOneAndOnlyFaceUp = nil
        }
        
        
   
        
    }
    
}
