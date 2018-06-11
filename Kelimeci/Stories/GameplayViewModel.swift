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
    var currentWord = ""
    var currentCharacters: [String] = []
    var guessedWords: [String] = []
    
    func guessCurrentWord() -> Bool {
        guard let word = word, !guessedWords.contains(currentWord) else { return false }
        
        if validateCharacterCount() {
            let success = word.allWords.contains(currentWord)
            if success {
                let pointsEarned = getPoints(forGuess: currentWord)
                score += pointsEarned
                guessedWords.append(currentWord)
            }
            return success
        }
        return false
    }
    
    func validateCharacterCount() -> Bool {
        let characterCount = currentWord.count
        return characterCount >= 4
    }
    
    func getPoints(forGuess guess: String) -> Int {
        guard let word = word else { return 0 }
        
        var score = (guess.count - 3) * 10
        if word.characters.count == guess.count {
            score *= 2
        }
        return score
    }
    
    func getMaximumScore() -> Int {
        guard let word = word else { return 0 }
        var maximumAvailableScore = 0
        
        for possibleWord in word.allWords {
            maximumAvailableScore += getPoints(forGuess: possibleWord)
        }
        
        return maximumAvailableScore
    }
    
    func getLongestWord() -> String {
        if let max = word?.allWords.max(by: {$1.count > $0.count}) {
            return max
        }
        return ""
    }
}
