//
//  GameplayViewModel.swift
//  Kelimeci
//
//  Created by Emel Topaloglu on 8/24/17.
//  Copyright © 2017 Emel Topaloglu. All rights reserved.
//

import Foundation

class GameplayViewModel: NSObject {
    var score = 0
    var word: Word?
    var isMinimal = false
    var currentWord = ""
    var currentCharacters: [String] = []
    
    func checkCurrentWord() -> Bool {
        guard let word = word else { return false }
        
        if validateCharacterCount() {
            return word.allWords.contains(currentWord)
        }
        return false
    }
    
    func validateCharacterCount() -> Bool {
        let characterCount = currentWord.count
        return characterCount >= 4
    }
    
    func getPoints(forWord word: Word, guess: String) -> Int {
        var score = (guess.count - 3) * 10
        if word.characters.count == guess.count {
            score *= 2
        }
        return score
    }
}
