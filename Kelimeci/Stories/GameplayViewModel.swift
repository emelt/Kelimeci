//
//  GameplayViewModel.swift
//  Kelimeci
//
//  Created by Emel Topaloglu on 8/24/17.
//  Copyright © 2017 Emel Topaloglu. All rights reserved.
//

import Foundation

class GameplayViewModel: NSObject {
    var word: Word?
    var isMinimal = false
    var currentWord = ""
    var currentCharacters: [String] = []
    
    func checkCurrentWord() -> Bool {
        guard let word = word else { return false }
        
        if validateCharacterCount() {
            if currentWord.count == 4 {
               return word.fourLetters.contains(currentWord)
            } else if currentWord.count == 5 {
                return word.fiveLetters.contains(currentWord)
            } else if currentWord.count == 6 {
                return word.sixLetters.contains(currentWord)
            } else if currentWord.count == 7 {
                return word.sevenLetters.contains(currentWord)
            } else if currentWord.count == 8 {
                return word.eightLetters.contains(currentWord)
            } else if currentWord.count == 9 {
                return word.nineLetters.contains(currentWord)
            } else if currentWord.count == 10 {
                return word.tenLetters.contains(currentWord)
            } else if currentWord.count == 11 {
                return word.elevenLetters.contains(currentWord)
            } else if currentWord.count == 12 {
                return word.thirteenLetters.contains(currentWord)
            } else if currentWord.count == 13 {
                return word.thirteenLetters.contains(currentWord)
            }
        }
        return false
    }
    
    func validateCharacterCount() -> Bool {
        let characterCount = currentWord.count
        return characterCount >= 4
    }
}
